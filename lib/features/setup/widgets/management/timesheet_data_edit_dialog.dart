import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/timesheet_data.dart';
import '../../../../core/repositories/app_repository.dart';
import 'package:isar_community/isar.dart';

class TimesheetDataEditDialog extends ConsumerStatefulWidget {
  final TimesheetData? timesheetData;

  const TimesheetDataEditDialog({super.key, this.timesheetData});

  @override
  ConsumerState<TimesheetDataEditDialog> createState() =>
      _TimesheetDataEditDialogState();
}

class _TimesheetDataEditDialogState
    extends ConsumerState<TimesheetDataEditDialog> {
  final _formKey = GlobalKey<FormState>();

  late String _activityType;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _activityType = widget.timesheetData?.activityType ?? 'MDT'; // default
    _nameController = TextEditingController(
      text: widget.timesheetData?.activityName ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      // Determine Icon based on selected activityType
      String iconName = 'build'; // default MDT
      if (_activityType == 'ODT') {
        iconName = 'local_gas_station';
      } else if (_activityType == 'OPERASIONAL') {
        iconName = 'precision_manufacturing';
      }

      final newData = TimesheetData(
        id: widget.timesheetData?.id ?? Isar.autoIncrement,
        activityType: _activityType,
        activityName: _nameController.text.trim(),
        icon: iconName,
      );

      // if editing existing, retain ID
      if (widget.timesheetData != null) {
        newData.id = widget.timesheetData!.id;
      }

      final repo = ref.read(appRepositoryProvider);
      await repo.saveTimesheetData(newData);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.timesheetData == null
                  ? 'Timesheet Data created'
                  : 'Timesheet Data updated',
            ),
            backgroundColor: const Color(0xFF2ECC71),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        widget.timesheetData == null
            ? 'Add Timesheet Data'
            : 'Edit Timesheet Data',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Activity Type Dropdown
              DropdownButtonFormField<String>(
                value: _activityType,
                dropdownColor: const Color(0xFF0F1410),
                decoration: InputDecoration(
                  labelText: 'Activity Type',
                  labelStyle: const TextStyle(color: Color(0xFFB0BEC5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1E3A2A)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2ECC71)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                items: const [
                  DropdownMenuItem(value: 'MDT', child: Text('MDT')),
                  DropdownMenuItem(value: 'ODT', child: Text('ODT')),
                  DropdownMenuItem(
                    value: 'OPERASIONAL',
                    child: Text('OPERASIONAL'),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _activityType = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Activity Name Input
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Activity Name',
                  labelStyle: const TextStyle(color: Color(0xFFB0BEC5)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1E3A2A)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2ECC71)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an activity name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2ECC71),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
