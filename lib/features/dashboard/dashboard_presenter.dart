import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/database/database_service.dart';
import '../../core/models/working_spot.dart';
import '../../core/models/workfile.dart';
import '../../core/state/auth_state.dart';
import '../../core/services/coordinate_service.dart';

// --- State Class ---
class DashboardData {
  final double productivity; // Spot/Hour (multiplied by 3600 from spot/sec)
  final double
  productivitySpotsHr; // Only spot/hour raw? Or same? User said: "productivity = production / workhours(sec) * 3600"
  final double percentageProductivity;

  final double precision; // Average accuracy
  final double percentagePrecision;

  final int productionSpots; // Spots count
  final int
  productionSpotsTotal; // Maybe same as above or cumulative? defaulting to same for now.
  final double percentageProduction;

  final String workHours; // Formatted "HH:mm" or similar
  final double percentageWorkHours;
  final double workHoursInSeconds; // Internal use

  final List<FlSpot> productivityTrend;
  final List<FlSpot> productionTrend;

  // New Fields for Progress Card
  final double areaHa; // Current Area in Ha
  final double maxAreaHa; // Target Area in Ha
  final double percentageProgress; // areaHa / maxAreaHa
  final String spacing;

  // New Fields for Charts
  final double productivityMaxY;
  final double productionMaxY;
  final double trendInterval; // X-Axis Interval in ms

  // New Fields for Workfile selection
  final List<WorkFile> workfiles;

  DashboardData({
    this.productivity = 0,
    this.productivitySpotsHr = 0,
    this.percentageProductivity = 0,
    this.precision = 0,
    this.percentagePrecision = 0,
    this.productionSpots = 0,
    this.productionSpotsTotal = 0,
    this.percentageProduction = 0,
    this.workHours = '00:00',
    this.percentageWorkHours = 0,
    this.workHoursInSeconds = 0,
    this.productivityTrend = const [],
    this.productionTrend = const [],
    this.areaHa = 0,
    this.maxAreaHa = 1,
    this.percentageProgress = 0,
    this.spacing = '4.0 m x 1.87 m',
    this.productivityMaxY = 1.0,
    this.productionMaxY = 100.0,
    this.trendInterval = 7200000,
    this.workfiles = const [],
  });
}

// --- Filter State ---
enum DashboardFilterType { morning, night, weekly, monthly, custom }

class DashboardFilter {
  final DashboardFilterType type;
  final DateTime
  selectedDate; // The reference date (e.g., today or selected day)
  final DateTimeRange? customRange; // For custom date selection
  final String? selectedFileID;

  DashboardFilter({
    required this.type,
    required this.selectedDate,
    this.customRange,
    this.selectedFileID,
  });

  DashboardFilter copyWith({
    DashboardFilterType? type,
    DateTime? selectedDate,
    DateTimeRange? customRange,
    String? selectedFileID,
  }) {
    return DashboardFilter(
      type: type ?? this.type,
      selectedDate: selectedDate ?? this.selectedDate,
      customRange: customRange ?? this.customRange,
      selectedFileID: selectedFileID ?? this.selectedFileID,
    );
  }
}

// --- Presenter Class ---
class DashboardPresenter extends AsyncNotifier<DashboardData> {
  late Isar _isar;
  DashboardFilter _filter = DashboardFilter(
    type: DashboardFilterType.morning, // Default
    selectedDate: DateTime.now(),
  );

  DashboardFilter get filter => _filter;

  @override
  FutureOr<DashboardData> build() async {
    // Ensure DB is initialized
    await DatabaseService().init();
    _isar = DatabaseService().isar;

    // Watch auth state so this provider rebuilds when auth changes
    ref.watch(authProvider);

    // Determine initial filter based on current time if first load?
    // User requested: "flow shift Morning => today 07.00 s/d 18.59"
    // Using default from _filter initialized above for now, but we could sync with time.
    final now = DateTime.now();
    if (now.hour >= 19 || now.hour < 7) {
      _filter = _filter.copyWith(type: DashboardFilterType.night);
    }

    // Set initial fileID if not already set, and load workfiles
    if (_filter.selectedFileID == null) {
      final workfiles = await _isar.workFiles.where().findAll();
      if (workfiles.isNotEmpty) {
        _filter = _filter.copyWith(
          selectedFileID: workfiles.first.uid.toString(),
        );
      }
    }

    return _loadDashboardData();
  }

  // --- Actions ---

  void updateFilterType(DashboardFilterType type) {
    if (_filter.type == type) return;
    _filter = _filter.copyWith(type: type);
    refresh();
  }

  void updateDate(DateTime date) {
    _filter = _filter.copyWith(selectedDate: date);
    refresh();
  }

  void updateCustomRange(DateTimeRange range) {
    _filter = _filter.copyWith(
      type: DashboardFilterType.custom,
      customRange: range,
    );
    refresh();
  }

  void updateSelectedFileID(String fileID) {
    _filter = _filter.copyWith(selectedFileID: fileID);
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadDashboardData());
  }

  Future<DashboardData> _loadDashboardData() async {
    DateTime startTime;
    DateTime endTime;

    final selectedDay = DateTime(
      _filter.selectedDate.year,
      _filter.selectedDate.month,
      _filter.selectedDate.day,
    );

    switch (_filter.type) {
      case DashboardFilterType.morning:
        // 07:00 - 18:59 on selected date
        startTime = selectedDay.add(const Duration(hours: 7));
        endTime = selectedDay.add(
          const Duration(hours: 18, minutes: 59, seconds: 59),
        );
        break;

      case DashboardFilterType.night:
        // Night Logic:
        // If selected date is Today and time is 19:00 - 23:59 -> Today 19:00 - 23:59
        // If selected date is Today and time is 00:00 - 06:59 -> Yesterday 19:00 - Today 06:59
        // BUT here we are filtering by a "Selected Date" from the picker.
        // Logic: The "Night Shift" OF that day.
        // Usually Night Shift of Date X starts at 19:00 Date X and ends 06:59 Date X+1.
        startTime = selectedDay.add(const Duration(hours: 19));
        endTime = selectedDay.add(
          const Duration(days: 1, hours: 6, minutes: 59, seconds: 59),
        );
        break;

      case DashboardFilterType.weekly:
        // Selected Date - 7 days? Or Current Week?
        // Let's do "Week including selected date" or "Last 7 days ending selected date".
        // Going with Last 7 days including today.
        endTime = selectedDay.add(
          const Duration(hours: 23, minutes: 59, seconds: 59),
        );
        startTime = selectedDay.subtract(
          const Duration(days: 6),
        ); // 7 days total
        break;

      case DashboardFilterType.monthly:
        // Full Month of selected date
        startTime = DateTime(selectedDay.year, selectedDay.month, 1);
        // Last day of month
        final nextMonth = DateTime(selectedDay.year, selectedDay.month + 1, 1);
        endTime = nextMonth.subtract(const Duration(seconds: 1));
        break;

      case DashboardFilterType.custom:
        if (_filter.customRange != null) {
          startTime = _filter.customRange!.start;
          endTime = _filter.customRange!.end.add(
            const Duration(hours: 23, minutes: 59, seconds: 59),
          ); // End of end day
        } else {
          // Fallback
          startTime = selectedDay;
          endTime = selectedDay.add(
            const Duration(hours: 23, minutes: 59, seconds: 59),
          );
        }
        break;
    }

    final workfiles = await _isar.workFiles.where().findAll();

    // Get Auth Context
    final auth = ref.read(authProvider);
    final driverID = auth.currentUser?.uid ?? '';
    final systemMode = auth.mode.name.toUpperCase(); // 'SPOT' or 'CRUMBLING'
    final fileID = _filter.selectedFileID ?? '';

    final activeWorkfile = workfiles.firstWhere(
      (w) => w.uid.toString() == fileID,
      orElse: () => WorkFile(),
    );

    final currentSpacing =
        '${activeWorkfile.panjang ?? 4.0} m x ${activeWorkfile.lebar ?? 1.87} m';

    // Query Isar
    final spots = await _isar.workingSpots
        .filter()
        .fileIDEqualTo(fileID)
        .driverIDEqualTo(driverID)
        .statusEqualTo(1)
        .modeEqualTo(systemMode)
        .lastUpdateBetween(
          startTime.millisecondsSinceEpoch,
          endTime.millisecondsSinceEpoch,
        )
        .sortByLastUpdate()
        .findAll();

    if (spots.isEmpty) {
      return DashboardData(workfiles: workfiles, spacing: currentSpacing);
    }

    // --- Calculations ---

    // 8. WorkHours
    double workHoursSeconds = 0;
    double totalDistance = 0;

    // Load CoordinateService if crumbling
    // We assume it's imported at the top. Let's make sure to use it.
    // If dart complains, we'll fix import next.
    final _calc = CoordinateService();

    if (spots.length > 1) {
      for (int i = 0; i < spots.length - 1; i++) {
        final current = spots[i];
        final next = spots[i + 1];

        // Workhours
        if (current.lastUpdate != null && next.lastUpdate != null) {
          final diff = next.lastUpdate! - current.lastUpdate!;
          final diffSec = diff / 1000.0;
          if (diffSec <= 300) {
            workHoursSeconds += diffSec;
          }
        }

        // Distance for Crumbling
        if (systemMode == 'CRUMBLING') {
          if (current.lat != null &&
              current.lng != null &&
              next.lat != null &&
              next.lng != null) {
            totalDistance += _calc.getDistance(
              Position(current.lng!, current.lat!),
              Position(next.lng!, next.lat!),
            );
          }
        }
      }
    }

    final whDuration = Duration(seconds: workHoursSeconds.toInt());
    final hours = whDuration.inHours.toString().padLeft(2, '0');
    final minutes = (whDuration.inMinutes % 60).toString().padLeft(2, '0');
    final workHoursStr = "$hours:$minutes";

    // 9. Production
    // For Spot mode: count of spots. For Crumbling: Total Distance (meters)
    final double production = systemMode == 'CRUMBLING'
        ? totalDistance
        : spots.length.toDouble();

    // 10. Productivity
    double productivity = 0;
    if (workHoursSeconds > 0) {
      productivity = (production / workHoursSeconds) * 3600;
    }

    // 11. Spot/Line Precision
    double totalAccuracy = 0;
    for (var spot in spots) {
      totalAccuracy += (spot.akurasi ?? 0);
    }
    final precision = spots.isNotEmpty ? totalAccuracy / spots.length : 0.0;

    // --- Area Calculation (Ha) ---
    // If CRUMBLING: distance * panjang / 10000
    // If SPOT: Spots * (4.0 * 1.87) / 10000
    final areaM2 = systemMode == 'CRUMBLING'
        ? totalDistance * (activeWorkfile.panjang ?? 4.0)
        : production * (4.0 * 1.87);
    final areaHa = areaM2 / 10000.0;

    // Max Area (From Workfile, fallback to 5.0 Ha)
    final maxAreaHa = activeWorkfile.luasArea ?? 5.0;

    // Indicator Progress
    final percentageProgress = maxAreaHa > 0
        ? (areaHa / maxAreaHa).clamp(0.0, 1.0)
        : 0.0;

    // --- Trend Calculation ---
    final durationHours = endTime.difference(startTime).inHours;
    int intervalMinutes = 30;
    if (durationHours > 24) {
      intervalMinutes = 60 * 24; // Daily
    }

    final productivityTrendPoints = _calculateTrend(
      spots,
      startTime: startTime,
      intervalMinutes: intervalMinutes,
      valueMapper: (groupSpots) {
        if (systemMode == 'CRUMBLING') {
          double dist = 0;
          if (groupSpots.length > 1) {
            for (int i = 0; i < groupSpots.length - 1; i++) {
              final cur = groupSpots[i];
              final nxt = groupSpots[i + 1];
              if (cur.lat != null &&
                  cur.lng != null &&
                  nxt.lat != null &&
                  nxt.lng != null) {
                dist += _calc.getDistance(
                  Position(cur.lng!, cur.lat!),
                  Position(nxt.lng!, nxt.lat!),
                );
              }
            }
          }
          final m2 = dist * (activeWorkfile.panjang ?? 4.0);
          return m2 / 10000.0;
        } else {
          final m2 = groupSpots.length * (4.0 * 1.87);
          return m2 / 10000.0; // Ha
        }
      },
    );

    final productionTrendPoints = _calculateTrend(
      spots,
      startTime: startTime,
      intervalMinutes: intervalMinutes,
      valueMapper: (groupSpots) {
        if (systemMode == 'CRUMBLING') {
          double dist = 0;
          if (groupSpots.length > 1) {
            for (int i = 0; i < groupSpots.length - 1; i++) {
              final cur = groupSpots[i];
              final nxt = groupSpots[i + 1];
              if (cur.lat != null &&
                  cur.lng != null &&
                  nxt.lat != null &&
                  nxt.lng != null) {
                dist += _calc.getDistance(
                  Position(cur.lng!, cur.lat!),
                  Position(nxt.lng!, nxt.lat!),
                );
              }
            }
          }
          return dist;
        } else {
          return groupSpots.length.toDouble();
        }
      },
    );

    // Dynamic Max Y Calculations (with padding)
    double prodMax = 0;
    for (var p in productivityTrendPoints) {
      if (p.y > prodMax) prodMax = p.y;
    }
    final productivityMaxY = prodMax == 0 ? 1.0 : prodMax * 1.2;

    double productionMax = 0;
    for (var p in productionTrendPoints) {
      if (p.y > productionMax) productionMax = p.y;
    }
    final productionMaxY = productionMax == 0 ? 10.0 : productionMax * 1.2;

    // Chart Interval
    final double chartInterval = durationHours >= 24 ? 86400000.0 : 7200000.0;

    return DashboardData(
      productivity: double.parse(productivity.toStringAsFixed(0)),
      productivitySpotsHr: 250.0,
      percentageProductivity: (productivity / 250).clamp(
        0.0,
        1.0,
      ), // Mock Target 250

      precision: double.parse(precision.toStringAsFixed(2)),
      percentagePrecision: (precision / 10).clamp(0.0, 1.0), // Mock Max 10 cm?

      productionSpots: production.toInt(),
      productionSpotsTotal: production.toInt(),
      percentageProduction: (production / 5000).clamp(0.0, 1.0), // Mock Target

      workHours: workHoursStr,
      workHoursInSeconds: workHoursSeconds,
      percentageWorkHours: (workHoursSeconds / (12 * 3600)).clamp(
        0.0,
        1.0,
      ), // Target 12h
      // New Progress Data
      areaHa: double.parse(areaHa.toStringAsFixed(3)),
      maxAreaHa: maxAreaHa,
      percentageProgress: percentageProgress,
      spacing: currentSpacing,

      productivityTrend: productivityTrendPoints,
      productionTrend: productionTrendPoints,
      productivityMaxY: productivityMaxY,
      productionMaxY: productionMaxY,
      trendInterval: chartInterval,
      workfiles: workfiles,
    );
  }

  List<FlSpot> _calculateTrend<T>(
    List<WorkingSpot> spots, {
    required DateTime startTime,
    required int intervalMinutes,
    required double Function(List<WorkingSpot>) valueMapper,
  }) {
    if (spots.isEmpty) return [];

    final Map<int, List<WorkingSpot>> groups = {};

    // Grouping
    for (var spot in spots) {
      final dt = DateTime.fromMillisecondsSinceEpoch(spot.lastUpdate!);
      // Use difference from start time to group
      final diffMin = dt.difference(startTime).inMinutes;
      // if (diffMin < 0) continue; // Allow slightly before? No.
      if (diffMin < 0) continue;

      final intervalIndex = diffMin ~/ intervalMinutes;
      groups.putIfAbsent(intervalIndex, () => []).add(spot);
    }

    final List<FlSpot> points = [];
    final maxIndex = groups.keys.isNotEmpty ? groups.keys.reduce(max) : 0;

    for (int i = 0; i <= maxIndex; i++) {
      final groupSpots = groups[i] ?? [];
      final value = valueMapper(groupSpots);

      // X Value: Actual Timestamp of the start of this interval
      // startTime + (i * interval)
      final intervalStartInfo = startTime.add(
        Duration(minutes: i * intervalMinutes),
      );
      final xValue = intervalStartInfo.millisecondsSinceEpoch.toDouble();

      points.add(FlSpot(xValue, value));
    }

    return points;
  }
}

final dashboardPresenterProvider =
    AsyncNotifierProvider<DashboardPresenter, DashboardData>(() {
      return DashboardPresenter();
    });
