import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/timesheet_data.dart';
import '../../../core/models/timesheet_record.dart';
import '../../../core/repositories/app_repository.dart';
import '../../../core/state/auth_state.dart';

class TimesheetState {
  final bool isMdt;
  final TimesheetData? selectedActivity;
  final bool isRunning;
  final int elapsedSeconds;
  final int? currentTimesheetId;
  final bool isMorningShift;

  const TimesheetState({
    this.isMdt = true,
    this.selectedActivity,
    this.isRunning = false,
    this.elapsedSeconds = 0,
    this.currentTimesheetId,
    this.isMorningShift = true,
  });

  TimesheetState copyWith({
    bool? isMdt,
    TimesheetData? selectedActivity,
    bool? isRunning,
    int? elapsedSeconds,
    int? currentTimesheetId,
    bool? isMorningShift,
  }) {
    return TimesheetState(
      isMdt: isMdt ?? this.isMdt,
      selectedActivity: selectedActivity ?? this.selectedActivity,
      isRunning: isRunning ?? this.isRunning,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      currentTimesheetId: currentTimesheetId ?? this.currentTimesheetId,
      isMorningShift: isMorningShift ?? this.isMorningShift,
    );
  }
}

class TimesheetNotifier extends Notifier<TimesheetState> {
  Timer? _timer;

  @override
  TimesheetState build() {
    // Check active timesheet async after build
    Future.microtask(_checkActiveTimesheet);
    return const TimesheetState();
  }

  void disposeTimer() {
    _timer?.cancel();
  }

  Future<void> _checkActiveTimesheet() async {
    final repo = ref.read(appRepositoryProvider);
    final status = await repo.getStatusTimesheet();

    if (status != null &&
        status.status == "PAUSE" &&
        status.idTimesheet != -1) {
      final records = await repo.getAllTimesheetRecords();
      final activeRecord = records
          .where((r) => r.id == status.idTimesheet)
          .firstOrNull;

      if (activeRecord != null) {
        final startDateTime = DateTime.fromMillisecondsSinceEpoch(
          activeRecord.startTime,
        );
        final elapsed = DateTime.now().difference(startDateTime).inSeconds;

        state = state.copyWith(
          isRunning: true,
          currentTimesheetId: activeRecord.id,
          isMdt: activeRecord.activityType == 'MDT',
          elapsedSeconds: elapsed,
        );
        _startTimer();
      }
    }
  }

  void toggleMdt(bool isMdt) {
    if (state.isRunning) return;
    state = state.copyWith(isMdt: isMdt);
  }

  void setActivity(TimesheetData? activity) {
    if (state.isRunning) return;
    state = state.copyWith(selectedActivity: activity);
  }

  void toggleShift(bool isMorning) {
    state = state.copyWith(isMorningShift: isMorning);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    });
  }

  Future<void> startActivity() async {
    if (state.selectedActivity == null) return; // caller should show Snackbar

    final repo = ref.read(appRepositoryProvider);
    final authState = ref.read(authProvider);
    final personId = authState.currentUser?.uid ?? 'Unknown';
    final modSys = authState.mode.name;

    final generatedId = Random().nextInt(90000) + 10000;
    final now = DateTime.now().millisecondsSinceEpoch;

    final record = TimesheetRecord(
      id: generatedId,
      modeSystem: modSys,
      activityType: state.selectedActivity!.activityType ?? 'Unknown',
      activityName: state.selectedActivity!.activityName ?? 'Unknown',
      totalTime: 0,
      startTime: now,
      endTime: 0,
      hmStart: 0,
      hmEnd: 0,
      totalSpots: 0,
      workspeed: 0,
      personID: personId,
    );

    await repo.saveTimesheetRecord(record);
    await repo.pauseTimesheet(generatedId);

    state = state.copyWith(
      currentTimesheetId: generatedId,
      isRunning: true,
      elapsedSeconds: 0,
    );
    _startTimer();
  }

  Future<void> stopActivity() async {
    if (state.currentTimesheetId == null) return;

    _timer?.cancel();
    final repo = ref.read(appRepositoryProvider);
    final records = await repo.getAllTimesheetRecords();
    final activeRecord = records
        .where((r) => r.id == state.currentTimesheetId)
        .firstOrNull;

    if (activeRecord != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      activeRecord.endTime = now;
      final diffMinutes = DateTime.fromMillisecondsSinceEpoch(now)
          .difference(
            DateTime.fromMillisecondsSinceEpoch(activeRecord.startTime),
          )
          .inMinutes;
      activeRecord.totalTime = diffMinutes;

      await repo.saveTimesheetRecord(activeRecord);
    }

    await repo.clearTimesheetStatus();

    state = state.copyWith(
      isRunning: false,
      currentTimesheetId: null,
      elapsedSeconds: 0,
    );
  }

  Future<void> closeAppActivity() async {
    if (state.isRunning && state.currentTimesheetId != null) {
      await stopActivity();
    }
    SystemNavigator.pop();
  }
}

final timesheetProvider = NotifierProvider<TimesheetNotifier, TimesheetState>(
  () {
    return TimesheetNotifier();
  },
);
