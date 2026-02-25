import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widget/done_button_elevate.dart';
import '../../features/dashboard/presenter/models/enum_dashboard.dart';
import '../../models/driver_models.dart';
import '../../models/enum_general.dart';
import '../../models/timesheet_record.dart';
import '../../presenter/setup_presenter.dart';
import '../../services/main_provider.dart';

class ActivityPage extends ConsumerStatefulWidget {
  const ActivityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActivityPageState();
}

class _ActivityPageState extends ConsumerState<ActivityPage> {
  SetupPresenter? _setupPresenter;
  ExcaDriver? _driver;
  final _today = DateTime.now();
  int utility = 0;
  int avaibility = 0;
  List<TimesheetRecord> _tsList = [];
  List<TimesheetRecord> _mdtList = [];
  List<TimesheetRecord> _odtList = [];
  ReportFilter _filtered = ReportFilter.none;

  String _workStatus(String status) {
    if (status == 'ops') {
      return 'Operation';
    } else if (status == 'mdt') {
      return 'Avaiablity';
    } else {
      return 'Untility';
    }
  }

  Color _colorStatus(String status) {
    if (status == 'ops') {
      return Colors.green.shade200;
    } else if (status == 'mdt') {
      return Colors.orange.shade100;
    } else {
      return Colors.pink.shade100;
    }
  }

  Color _pickedColor(ReportFilter filter) {
    if (filter == _filtered) {
      return Colors.blue.shade300;
    } else {
      return Colors.grey;
    }
  }

  void pilihShift(ReportFilter filter) {
    setState(() {
      if (filter == ReportFilter.daily) {
        _tsList = _setupPresenter!.queryTimesheet(
            DateTime(_today.year, _today.month, _today.day, 7),
            DateTime(_today.year, _today.month, _today.day, 18, 59),
            _driver!.uid);
        _odtList = _tsList.where((e) => e.activityType == 'odt').toList();
        _mdtList = _tsList.where((e) => e.activityType == 'mdt').toList();
        utility = _odtList.fold(0, (previousValue, element) => previousValue + element.totalTime);
        avaibility =
            _mdtList.fold(0, (previousValue, element) => previousValue + element.totalTime);
      } else if (filter == ReportFilter.weekly) {
        if (DateTime.now().hour >= 19) {
          _tsList = _setupPresenter!.queryTimesheet(
              DateTime(_today.year, _today.month, _today.day, 19),
              DateTime(_today.year, _today.month, _today.day, 23, 59),
              _driver!.uid);
          _odtList = _tsList.where((e) => e.activityType == 'odt').toList();
          _mdtList = _tsList.where((e) => e.activityType == 'mdt').toList();
          utility = _odtList.fold(0, (previousValue, element) => previousValue + element.totalTime);
          avaibility =
              _mdtList.fold(0, (previousValue, element) => previousValue + element.totalTime);
        } else {
          _tsList = _setupPresenter!.queryTimesheet(
              DateTime(_today.year, _today.month, _today.day - 1, 19),
              DateTime(_today.year, _today.month, _today.day, 6, 59),
              _driver!.uid);
          _odtList = _tsList.where((e) => e.activityType == 'odt').toList();
          _mdtList = _tsList.where((e) => e.activityType == 'mdt').toList();
          utility = _odtList.fold(0, (previousValue, element) => previousValue + element.totalTime);
          avaibility =
              _mdtList.fold(0, (previousValue, element) => previousValue + element.totalTime);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _driver = ref.read(driverData);
    _setupPresenter = ref.read(setupController);
    _filtered = ReportFilter.daily;
    pilihShift(_filtered);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final streamData = ref.watch(streamTS);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.04,
          left: size.width * 0.023,
          right: size.width * 0.023,
          bottom: size.width * 0.01,
        ),
        child: Column(
          children: [
            // SizedBox(height: size.height * 0.03),
            Row(
              children: [
                DoneButton(
                  text: 'Pagi',
                  onPressed: () {
                    setState(() {
                      _filtered = ReportFilter.daily;
                    });
                    pilihShift(ReportFilter.daily);
                  },
                  width: size.width * 0.1,
                  height: size.height * 0.04,
                  color: _pickedColor(ReportFilter.daily),
                  radius: 8,
                  fontSize: 12,
                ),
                SizedBox(width: size.width * 0.005),
                DoneButton(
                  text: 'Malam',
                  onPressed: () {
                    setState(() {
                      _filtered = ReportFilter.weekly;
                    });
                    pilihShift(_filtered);
                  },
                  width: size.width * 0.1,
                  height: size.height * 0.04,
                  color: _pickedColor(ReportFilter.weekly),
                  radius: 8,
                  fontSize: 12,
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _setupPresenter!.dateNow(),
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.025),
                    ),
                    Text(
                      '${_driver!.firstName} ${_driver!.lastName}',
                      style: TextStyle(
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.02),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(18),
                1: FlexColumnWidth(20),
                2: FlexColumnWidth(24),
                3: FlexColumnWidth(31),
              },
              border: TableBorder(
                horizontalInside: BorderSide(width: 1, color: Theme.of(context).highlightColor),
              ),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Excavator',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'TIME MACHINE',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'TIME OPERATOR',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(18),
                1: FlexColumnWidth(10),
                2: FlexColumnWidth(10),
                3: FlexColumnWidth(8),
                4: FlexColumnWidth(8),
                5: FlexColumnWidth(8),
                6: FlexColumnWidth(10),
                7: FlexColumnWidth(10),
                8: FlexColumnWidth(10),
              },
              border: TableBorder(
                horizontalInside: BorderSide(width: 1, color: Theme.of(context).highlightColor),
              ),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Activity',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Start',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'End',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Start',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'End',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Hour',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Total',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Ha/hour',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        // width: size.width * 0.2,
                        padding: EdgeInsets.all(size.height * 0.01),
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Text(
                            'Worktime',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.65,
              child: SingleChildScrollView(
                child: Column(
                  children: _tsList.map((data) {
                    return Table(
                      columnWidths: const {
                        0: FlexColumnWidth(18),
                        1: FlexColumnWidth(8),
                        2: FlexColumnWidth(8),
                        3: FlexColumnWidth(8),
                        4: FlexColumnWidth(8),
                        5: FlexColumnWidth(8),
                        6: FlexColumnWidth(13),
                        7: FlexColumnWidth(8),
                        8: FlexColumnWidth(10),
                      },
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                          width: 1.5,
                          color: Colors.black,
                        ),
                      ),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    data.activityName,
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    data.hmStart.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    data.hmEnd.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    _setupPresenter!.timeNow(
                                        DateTime.fromMillisecondsSinceEpoch(data.startTime)),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    _setupPresenter!
                                        .timeNow(DateTime.fromMillisecondsSinceEpoch(data.endTime)),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    _setupPresenter!.showHours(data.totalTime),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    data.totalSpots.toStringAsFixed(3),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    data.workspeed.toStringAsFixed(3),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                // width: size.width * 0.2,
                                padding: EdgeInsets.all(size.height * 0.02),
                                color: _colorStatus(data.activityType),
                                child: Center(
                                  child: Text(
                                    _workStatus(data.activityType),
                                    style: TextStyle(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Divider(color: Theme.of(context).highlightColor),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.15,
                  child: Text(
                    'Availibility',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.01),
                Text(
                  _setupPresenter!.showHours2(avaibility),
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontWeight: FontWeight.w500,
                    fontSize: size.height * 0.025,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.15,
                  child: Text(
                    'Utilization',
                    style: TextStyle(
                      color: Theme.of(context).highlightColor,
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.01),
                Text(
                  _setupPresenter!.showHours2(utility),
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontWeight: FontWeight.w500,
                    fontSize: size.height * 0.025,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
