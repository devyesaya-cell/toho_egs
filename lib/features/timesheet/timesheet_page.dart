import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/coms/com_service.dart';
import '../../../core/models/timesheet_data.dart';
import '../../../core/models/timesheet_record.dart';
import '../../../core/repositories/app_repository.dart';
import '../../../core/state/auth_state.dart';
import 'presenter/timesheet_presenter.dart'; // import the new presenter

// Top level stream providers for timesheet data to preserve caching across rebuilds
final timesheetDataStreamProvider =
    StreamProvider.autoDispose<List<TimesheetData>>((ref) {
      return ref.watch(appRepositoryProvider).watchTimesheetDatas();
    });

final timesheetRecordStreamProvider =
    StreamProvider.autoDispose<List<TimesheetRecord>>((ref) {
      return ref.watch(appRepositoryProvider).watchTimesheetRecords();
    });

class TimesheetPage extends ConsumerWidget {
  const TimesheetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Automatically reads & initializes via checkActiveTimesheet in constructor
    final state = ref.watch(timesheetProvider);
    final notifier = ref.read(timesheetProvider.notifier);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1410), // Dark background
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F1410),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              // Green Icon Box
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A2A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.table_chart,
                  color: Color(0xFF2ECC71),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Titles
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TIMESHEET',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'EGS TIMESHEET V4.0.0',
                    style: TextStyle(
                      color: Color(0xFF2ECC71), // Primary Green
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            // Right Side Actions: Person Widget + Connection Status
            _buildAppBarActions(ref),
            const SizedBox(width: 16),
          ],
          bottom: const TabBar(
            indicatorColor: Color(0xFF2ECC71),
            labelColor: Color(0xFF2ECC71),
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'ACTIVITY'),
              Tab(text: 'TIMESHEET VIEW'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF1E3A2A))),
          ),
          child: TabBarView(
            children: [
              // TAB 1: ACTIVITY
              _buildActivityTab(context, ref, state, notifier),

              // TAB 2: TIMESHEET VIEW
              _buildTimesheetViewTab(context, ref, state, notifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarActions(WidgetRef ref) {
    final usbState = ref.watch(comServiceProvider);
    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }
    final bool isUsbActive = usbState.isConnected && hasDataStream;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Compact Connection Status
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  Icons.usb,
                  size: 14,
                  color: isUsbActive
                      ? const Color(0xFF2ECC71)
                      : const Color(0xFFEF4444),
                ),
                const SizedBox(width: 4),
                Text(
                  isUsbActive ? 'RS232 Active' : 'RS232 Inactive',
                  style: TextStyle(
                    color: isUsbActive
                        ? const Color(0xFF2ECC71)
                        : const Color(0xFFEF4444),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Container(width: 1, height: 24, color: const Color(0xFF1E3A2A)),
        const SizedBox(width: 16),
        // Simple Profile Widget for AppBar
        Builder(
          builder: (context) {
            final authState = ref.watch(authProvider);
            final person = authState.currentUser;
            final name = person != null
                ? '${person.firstName} ${person.lastName}'
                : 'Unknown';
            final contractor = person?.kontraktor ?? 'Unknown';
            final photoUrl = person?.picURL;

            return InkWell(
              onTap: () {
                _showLogoutDialog(context, ref);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                          ? AssetImage(photoUrl)
                          : const AssetImage('images/avatar_person.png'),
                      backgroundColor: const Color(0xFF1E293B),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          contractor,
                          style: const TextStyle(
                            color: Color(0xFF2ECC71),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.orange),
            SizedBox(width: 8),
            Text('Sign Out', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              // Stop timesheet if running before logging out
              final notifier = ref.read(timesheetProvider.notifier);
              final state = ref.read(timesheetProvider);
              if (state.isRunning) {
                await notifier.stopActivity();
              }
              // Unauthenticate
              ref.read(authProvider.notifier).logout();
              // Navigation to login is handled automatically by the GoRouter redirect in app.dart based on authProvider state
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('SIGN OUT'),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab(
    BuildContext context,
    WidgetRef ref,
    TimesheetState state,
    TimesheetNotifier notifier,
  ) {
    final asyncActivities = ref.watch(timesheetDataStreamProvider);

    return asyncActivities.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
      ),
      error: (error, stack) => Center(
        child: Text(
          'Error loading activities: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      data: (allActivities) {
        final currentActivities = allActivities.where((a) {
          return state.isMdt
              ? a.activityType == 'MDT'
              : a.activityType == 'ODT';
        }).toList();

        TimesheetData? validSelectedActivity;
        if (currentActivities.isNotEmpty) {
          if (state.selectedActivity != null) {
            validSelectedActivity = currentActivities
                .where((a) => a.id == state.selectedActivity!.id)
                .firstOrNull;
          }
          if (validSelectedActivity == null && !state.isRunning) {
            validSelectedActivity = currentActivities.first;
          }
        }

        if (validSelectedActivity?.id != state.selectedActivity?.id) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notifier.setActivity(validSelectedActivity);
          });
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. MDT | ODT Toggle
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF1E3A2A)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildToggleBtn('MDT', state.isMdt, () {
                          notifier.toggleMdt(true);
                        }),
                        _buildToggleBtn('ODT', !state.isMdt, () {
                          notifier.toggleMdt(false);
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 2. Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: state.isRunning
                        ? const Color(0xFF0F1410)
                        : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1E3A2A)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<TimesheetData>(
                      value: validSelectedActivity,
                      dropdownColor: const Color(0xFF1E293B),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: state.isRunning
                            ? Colors.white38
                            : const Color(0xFF2ECC71),
                      ),
                      isExpanded: true,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: state.isRunning
                          ? null
                          : (TimesheetData? newValue) {
                              notifier.setActivity(newValue);
                            },
                      items: currentActivities
                          .map<DropdownMenuItem<TimesheetData>>((
                            TimesheetData value,
                          ) {
                            return DropdownMenuItem<TimesheetData>(
                              value: value,
                              child: Text(value.activityName ?? 'Unknown'),
                            );
                          })
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 3. Activity Name Display
                Text(
                  validSelectedActivity?.activityName?.toUpperCase() ?? '-',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFB0BEC5),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // 4. Timer View
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: state.isRunning
                        ? const Color(0xFF1E3A2A).withValues(alpha: 0.3)
                        : const Color(0xFF0F1410).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: state.isRunning
                          ? const Color(0xFF2ECC71).withValues(alpha: 0.5)
                          : const Color(0xFF1E3A2A),
                    ),
                    boxShadow: state.isRunning
                        ? [
                            BoxShadow(
                              color: const Color(
                                0xFF2ECC71,
                              ).withValues(alpha: 0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      _formatDuration(state.elapsedSeconds),
                      style: TextStyle(
                        color: state.isRunning
                            ? const Color(0xFF2ECC71)
                            : Colors.white38,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 5. Start / Stop Button & Close App
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (state.isRunning) {
                            await notifier.stopActivity();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Timesheet Record Saved Successfully.',
                                  ),
                                  backgroundColor: Color(0xFF2ECC71),
                                ),
                              );
                            }
                          } else {
                            if (state.selectedActivity == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select an activity first.',
                                  ),
                                  backgroundColor: Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }
                            await notifier.startActivity();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.isRunning
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF2ECC71),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          state.isRunning ? 'STOP ACTIVITY' : 'START ACTIVITY',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: notifier.closeAppActivity,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A2A),
                          foregroundColor: const Color(0xFF2ECC71),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: Color(0xFF2ECC71),
                              width: 2,
                            ),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'CLOSE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildToggleBtn(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2ECC71) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Widget _buildTimesheetViewTab(
    BuildContext context,
    WidgetRef ref,
    TimesheetState state,
    TimesheetNotifier notifier,
  ) {
    final authState = ref.watch(authProvider);
    final currentPersonId = authState.currentUser?.uid ?? 'Unknown';

    return Column(
      children: [
        // 1. Shift Selector
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF1E3A2A)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildToggleBtn('Morning Shift', state.isMorningShift, () {
                  notifier.toggleShift(true);
                }),
                _buildToggleBtn('Night Shift', !state.isMorningShift, () {
                  notifier.toggleShift(false);
                }),
              ],
            ),
          ),
        ),

        // 2. Data Table
        Expanded(
          child: ref
              .watch(timesheetRecordStreamProvider)
              .when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'Error loading timesheet records: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                data: (allRecords) {
                  // Filter logic
                  final now = DateTime.now();
                  DateTime shiftStart;
                  DateTime shiftEnd;

                  if (state.isMorningShift) {
                    shiftStart = DateTime(now.year, now.month, now.day, 7, 0);
                    shiftEnd = DateTime(now.year, now.month, now.day, 19, 0);
                  } else {
                    if (now.hour < 12) {
                      // It's past midnight, shift started yesterday at 19:00
                      final yesterday = now.subtract(const Duration(days: 1));
                      shiftStart = DateTime(
                        yesterday.year,
                        yesterday.month,
                        yesterday.day,
                        19,
                        0,
                      );
                      shiftEnd = DateTime(now.year, now.month, now.day, 7, 0);
                    } else {
                      // It's evening, shift starts today at 19:00, ends tomorrow at 07:00
                      final tomorrow = now.add(const Duration(days: 1));
                      shiftStart = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        19,
                        0,
                      );
                      shiftEnd = DateTime(
                        tomorrow.year,
                        tomorrow.month,
                        tomorrow.day,
                        7,
                        0,
                      );
                    }
                  }

                  final filteredRecords = allRecords.where((record) {
                    if (record.personID != currentPersonId) return false;

                    final recordStart = DateTime.fromMillisecondsSinceEpoch(
                      record.startTime,
                    );
                    // We only check if the startTime falls within the shift
                    return recordStart.isAfter(
                          shiftStart.subtract(const Duration(seconds: 1)),
                        ) &&
                        recordStart.isBefore(
                          shiftEnd.add(const Duration(seconds: 1)),
                        );
                  }).toList();

                  // Sort ascending by time
                  filteredRecords.sort(
                    (a, b) => a.startTime.compareTo(b.startTime),
                  );

                  if (filteredRecords.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Timesheet Records Found for this Shift.',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF1E3A2A),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: _buildDataTable(filteredRecords),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryFooter(filteredRecords),
                    ],
                  );
                },
              ),
        ),
      ],
    );
  }

  Widget _buildDataTable(List<TimesheetRecord> records) {
    // Header Style
    const headerStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    // Cell Style
    const cellStyle = TextStyle(
      color: Colors.black87,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    // Use FixedColumnWidth instead of FlexColumnWidth so the Table knows
    // exactly how wide to be inside a horizontal SingleChildScrollView.
    // We scale the original flex values (e.g. 18 -> 180 pixels).
    const columnWidths = {
      0: FixedColumnWidth(180),
      1: FixedColumnWidth(100), // Time Machine Start
      2: FixedColumnWidth(100), // Time Machine End
      3: FixedColumnWidth(80), // Time Operator Start
      4: FixedColumnWidth(80), // Time Operator End
      5: FixedColumnWidth(80), // Time Operator Hour
      6: FixedColumnWidth(100), // Total Spots
      7: FixedColumnWidth(100), // Ha/hour
      8: FixedColumnWidth(100), // Worktime
    };

    String formatTime(DateTime dt) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }

    return Column(
      children: [
        // Top Header Row grouping
        Table(
          columnWidths: const {
            0: FixedColumnWidth(180),
            1: FixedColumnWidth(200), // Starts & Ends combined (100+100)
            2: FixedColumnWidth(
              240,
            ), // Oper Start, End, Hour combined (80+80+80)
            3: FixedColumnWidth(
              300,
            ), // Total, ha/hour, worktime combined (100+100+100)
          },
          border: const TableBorder(
            horizontalInside: BorderSide(width: 1, color: Color(0xFF1E3A2A)),
            bottom: BorderSide(width: 1, color: Color(0xFF1E3A2A)),
          ),
          children: [
            TableRow(
              children: [
                _buildHeaderCell('', headerStyle, isTop: true),
                _buildHeaderCell('TIME MACHINE', headerStyle, isTop: true),
                _buildHeaderCell('TIME OPERATOR', headerStyle, isTop: true),
                _buildHeaderCell('', headerStyle, isTop: true),
              ],
            ),
          ],
        ),
        // Sub Header Row
        Table(
          columnWidths: columnWidths,
          border: const TableBorder(
            bottom: BorderSide(width: 2, color: Color(0xFF1E3A2A)),
          ),
          children: [
            TableRow(
              children: [
                _buildHeaderCell('Activity', headerStyle),
                _buildHeaderCell('Start', headerStyle),
                _buildHeaderCell('End', headerStyle),
                _buildHeaderCell('Start', headerStyle),
                _buildHeaderCell('End', headerStyle),
                _buildHeaderCell('Hour', headerStyle),
                _buildHeaderCell('Total', headerStyle),
                _buildHeaderCell('Ha/hour', headerStyle),
                _buildHeaderCell('Worktime', headerStyle),
              ],
            ),
          ],
        ),
        // Data Rows
        ...records.map((record) {
          final startDt = DateTime.fromMillisecondsSinceEpoch(record.startTime);
          final endDt = record.endTime > record.startTime
              ? DateTime.fromMillisecondsSinceEpoch(record.endTime)
              : null;

          String hourDiff = "00:00";
          if (endDt != null) {
            final diff = endDt.difference(startDt);
            final h = diff.inHours;
            final m = diff.inMinutes % 60;
            hourDiff =
                '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
          }

          final rowColor = _colorStatus(record.activityType);

          return Table(
            columnWidths: columnWidths,
            border: const TableBorder(
              horizontalInside: BorderSide(width: 1, color: Colors.black26),
              bottom: BorderSide(width: 1, color: Colors.black26),
            ),
            children: [
              TableRow(
                children: [
                  _buildDataCell(record.activityName, rowColor, cellStyle),
                  _buildDataCell(
                    record.hmStart.toString(),
                    rowColor,
                    cellStyle,
                  ),
                  _buildDataCell(record.hmEnd.toString(), rowColor, cellStyle),
                  _buildDataCell(formatTime(startDt), rowColor, cellStyle),
                  _buildDataCell(
                    endDt != null ? formatTime(endDt) : '-',
                    rowColor,
                    cellStyle,
                  ),
                  _buildDataCell(hourDiff, rowColor, cellStyle),
                  _buildDataCell(
                    record.totalSpots.toStringAsFixed(3),
                    rowColor,
                    cellStyle,
                  ),
                  _buildDataCell(
                    record.workspeed.toStringAsFixed(3),
                    rowColor,
                    cellStyle,
                  ),
                  _buildDataCell(record.activityType, rowColor, cellStyle),
                ],
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Color _colorStatus(String status) {
    status = status.toUpperCase();
    if (status == 'OPERASIONAL' || status == 'OPS') {
      return Colors.green.shade200;
    } else if (status == 'MDT') {
      return Colors.orange.shade100;
    } else {
      return Colors.pink.shade100; // for ODT or others
    }
  }

  Widget _buildHeaderCell(String text, TextStyle style, {bool isTop = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      color: const Color(0xFF1F3A52), // Header background
      child: Center(
        child: Text(text, style: style, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildDataCell(String text, Color bgColor, TextStyle style) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      color: bgColor,
      child: Center(
        child: Text(text, style: style, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildSummaryFooter(List<TimesheetRecord> records) {
    int mdtMins = 0;
    int odtMins = 0;
    int opMins = 0;

    for (var r in records) {
      // Use totalTime field or recalculate
      final s = DateTime.fromMillisecondsSinceEpoch(r.startTime);
      final e = r.endTime > r.startTime
          ? DateTime.fromMillisecondsSinceEpoch(r.endTime)
          : null;
      int mins = r.totalTime;
      if (mins == 0 && e != null) {
        mins = e.difference(s).inMinutes;
      }

      if (r.activityType.toUpperCase() == 'MDT') {
        mdtMins += mins;
      } else if (r.activityType.toUpperCase() == 'ODT') {
        odtMins += mins;
      } else {
        opMins += mins;
      }
    }

    String formatMsg(String title, int totalMins) {
      final h = totalMins ~/ 60;
      final m = totalMins % 60;
      return '$title: ${h.toString().padLeft(2, '0')}h ${m.toString().padLeft(2, '0')}m';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF0F1410),
        border: Border(top: BorderSide(color: Color(0xFF1E3A2A))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSummaryChip(
            formatMsg('Total MDT', mdtMins),
            const Color(0xFFEF4444),
          ),
          _buildSummaryChip(
            formatMsg('Total ODT', odtMins),
            const Color(0xFFEAB308),
          ),
          _buildSummaryChip(
            formatMsg('Total OPERASIONAL', opMins),
            const Color(0xFF2ECC71),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryChip(String text, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: accent,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
