import 'package:isar_community/isar.dart';

part 'status_timesheet.g.dart';

@collection
class StatusTimesheet {
  Id id = 1; // satu uniqe id, karena hanya ada 1 status

  int lastUpdate;
  String status; // "PAUSE" atau "NORMAL"
  int idTimesheet; // Id dari TimesheetRecord yang aktif

  StatusTimesheet({
    this.id = 1,
    required this.lastUpdate,
    required this.status,
    required this.idTimesheet,
  });
}
