import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import '../../../core/database/database_service.dart';
import '../../../core/models/timesheet_data.dart';
import '../../../core/models/timesheet_record.dart';
import '../../../core/state/auth_state.dart';
import '../map_presenter.dart';

class TimesheetStartDialog extends ConsumerStatefulWidget {
  const TimesheetStartDialog({super.key});

  @override
  ConsumerState<TimesheetStartDialog> createState() =>
      _TimesheetStartDialogState();
}

class _TimesheetStartDialogState extends ConsumerState<TimesheetStartDialog> {
  final _hmController = TextEditingController();
  List<TimesheetData> _activities = [];
  TimesheetData? _selectedActivity;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final isar = DatabaseService().isar;
    final data = await isar.timesheetDatas
        .filter()
        .activityTypeEqualTo('OPERASIONAL')
        .findAll();

    setState(() {
      _activities = data;
      if (data.isNotEmpty) {
        _selectedActivity = data.first;
      }
      _isLoading = false;
    });
  }

  void _start() {
    final hmText = _hmController.text;
    final hmStart = int.tryParse(hmText) ?? 0;

    if (_selectedActivity == null) return;
    if (hmText.isEmpty || hmStart <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid HM Start')),
      );
      return;
    }

    final auth = ref.read(authProvider);
    final driverId = auth.currentUser?.uid.toString() ?? '0';

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // modeSystem comes from settings usually, we can just default to empty or query settings later if needed
    final newRecord = TimesheetRecord(
      id: Isar.autoIncrement,
      modeSystem: 'Manual', // Or whichever
      activityType: _selectedActivity!.activityType ?? 'operasional',
      activityName: _selectedActivity!.activityName ?? 'Unknown',
      totalTime: 0,
      startTime: now,
      endTime: now,
      hmStart: hmStart,
      hmEnd:
          hmStart, // Will be updated on stop if necessary, though MapPage only stops workspeed
      totalSpots: 0.0,
      workspeed: 0.0,
      personID: driverId,
    );

    ref.read(mapPresenterProvider.notifier).startTimesheet(newRecord);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const AlertDialog(
        content: SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return AlertDialog(
      backgroundColor: const Color(0xFF0F1410), // Dark background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Start Recording Activity',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity Name',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Theme(
              data: Theme.of(
                context,
              ).copyWith(canvasColor: const Color(0xFF1A211D)),
              child: DropdownButtonFormField<TimesheetData>(
                value: _selectedActivity,
                isExpanded: true,
                style: const TextStyle(color: Colors.white),
                items: _activities.map((a) {
                  return DropdownMenuItem(
                    value: a,
                    child: Text(a.activityName ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedActivity = val;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2ECC71)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2ECC71), width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('HM Start', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: _hmController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter HM Start Value',
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2ECC71)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2ECC71), width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2ECC71), // Green
            foregroundColor: Colors.white,
          ),
          onPressed: _start,
          child: const Text(
            'START',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
