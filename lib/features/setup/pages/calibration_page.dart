import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/coms/com_service.dart';
import '../presenter/calibration_presenter.dart';
import 'package:usb_serial/usb_serial.dart';

import '../widgets/calibration/offset_calibration_tab.dart';
import '../widgets/calibration/body_calibration_tab.dart';
import '../widgets/calibration/boom_calibration_tab.dart';

class CalibrationPage extends ConsumerStatefulWidget {
  const CalibrationPage({super.key});

  @override
  ConsumerState<CalibrationPage> createState() => _CalibrationPageState();
}

class _CalibrationPageState extends ConsumerState<CalibrationPage> {
  final CalibrationPresenter _presenter = CalibrationPresenter();
  UsbPort? _activePort;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final usbState = ref.read(comServiceProvider);
      if (usbState.port != null) {
        _activePort = usbState.port;
        _presenter.setConfig(_activePort!);
      }
    });
  }

  @override
  void dispose() {
    if (_activePort != null) {
      _presenter.setNormal(_activePort!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1410), // Dark background
        appBar: AppBar(
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
                  Icons.precision_manufacturing,
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
                    'EQUIPMENT CALIBRATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'EGS CALIBRATION V4.0.0',
                    style: TextStyle(
                      color: Color(0xFF2ECC71), // Primary Green
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Consumer(
                builder: (context, ref, child) {
                  final usbState = ref.watch(comServiceProvider);
                  final calibAsync = ref.watch(calibStreamProvider);
                  bool hasDataStream = false;
                  if (usbState.lastDataReceived != null) {
                    final diff = DateTime.now().difference(
                      usbState.lastDataReceived!,
                    );
                    if (diff.inSeconds < 2) {
                      hasDataStream = true;
                    }
                  }
                  final bool isActive = usbState.isConnected && hasDataStream;
                  final bool isCalibActive =
                      calibAsync.hasValue && hasDataStream;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.usb,
                            color: isActive
                                ? Colors.greenAccent
                                : Colors.white54,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Connection to RS232 : ',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            isActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              color: isActive ? Colors.greenAccent : Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isActive ? Colors.greenAccent : Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: Colors.greenAccent.withOpacity(
                                          0.6,
                                        ),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.stream,
                            color: isCalibActive
                                ? Colors.greenAccent
                                : Colors.white54,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Calibration Stream : ',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            isCalibActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              color: isCalibActive
                                  ? Colors.greenAccent
                                  : Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isCalibActive
                                  ? Colors.greenAccent
                                  : Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: isCalibActive
                                  ? [
                                      BoxShadow(
                                        color: Colors.greenAccent.withOpacity(
                                          0.6,
                                        ),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          backgroundColor: const Color(0xFF0F1410), // Dark background
          foregroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF2ECC71), // Green
            labelColor: Color(0xFF2ECC71), // Green
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'OFFSET CALIBRATION'),
              Tab(text: 'BODY CALIBRATION'),
              Tab(text: 'BOOM CALIBRATION'),
              Tab(text: 'STICK CALIBRATION'),
              Tab(text: 'ATTACHMENT CALIBRATION'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF1E3A2A))),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final calibData = ref.watch(calibStreamProvider).asData?.value;
              final dataString = calibData != null
                  ? 'Pitch: ${calibData.pitch}\nRoll: ${calibData.roll}\nBoom: ${calibData.boomTilt}\nStick: ${calibData.stickTilt}\nBucket: ${calibData.bucketTilt}'
                  : 'No Calibration Data';

              return TabBarView(
                children: [
                  const OffsetCalibrationTab(),
                  const BodyCalibrationTab(),
                  const BoomCalibrationTab(),
                  Center(
                    child: Text(
                      'Stick Calibration Placeholder\n\n$dataString',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Attachment Calibration Placeholder\n\n$dataString',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
