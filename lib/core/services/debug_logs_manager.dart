import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../coms/com_service.dart';
import '../repositories/app_repository.dart';
import '../models/debug_logs.dart';

final debugLogsManagerProvider = Provider<DebugLogsManager>((ref) {
  final manager = DebugLogsManager(ref);
  
  // Listen to USB connection state changes
  ref.listen<UsbState>(comServiceProvider, (previous, next) {
    if (next.isConnected && !(previous?.isConnected ?? false)) {
      debugPrint("DebugLogsManager: USB connected, starting periodic logger.");
      manager.startLogging();
    } else if (!next.isConnected && (previous?.isConnected ?? true)) {
      debugPrint("DebugLogsManager: USB disconnected, stopping periodic logger.");
      manager.stopLogging();
    }
  }, fireImmediately: true);

  ref.onDispose(() {
    manager.stopLogging();
  });

  return manager;
});

class DebugLogsManager {
  final Ref _ref;
  Timer? _timer;
  final List<DebugLogs> _buffer = [];

  DebugLogsManager(this._ref);

  void startLogging() {
    stopLogging();
    // Run immediately when starting, then periodically every 1 minute
    _captureAndLog();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _captureAndLog();
    });
  }

  void stopLogging() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _captureAndLog() async {
    try {
      final comService = _ref.read(comServiceProvider.notifier);
      final gps = comService.lastGPSLoc;
      final sensor = comService.lastSensorNodeData;
      final rover = comService.lastRoverNodeData;
      final baseStatus = _ref.read(bsProvider);
      
      final alerts = _ref.read(errorProvider);
      final errorAlert = alerts.isNotEmpty ? alerts.first : null;

      // Instantiate new DebugLogs record
      final logEntry = DebugLogs(
        lastUpdate: DateTime.now(),
        gpsLoc: gps != null ? GPSLocEmbedded.fromGPSLoc(gps) : null,
        baseStatus: baseStatus != null ? BasestatusEmbedded.fromBasestatus(baseStatus) : null,
        roverNode: rover != null ? RoverNodeDataEmbedded.fromRoverNodeData(rover) : null,
        sensorNode: sensor != null ? SensorNodeDataEmbedded.fromSensorNodeData(sensor) : null,
        errorAlert: errorAlert != null ? ErrorAlertEmbedded.fromErrorAlert(errorAlert) : null,
      );

      final appRepo = _ref.read(appRepositoryProvider);
      final count = await appRepo.getDebugLogsCount();

      if (count < 10000) {
        // If there was any leftover data in buffer from a previous run, save them first
        if (_buffer.isNotEmpty) {
          _buffer.add(logEntry);
          debugPrint("DebugLogsManager: DB count ($count) < 10000. Saving buffered + current log (total: ${_buffer.length}).");
          await appRepo.saveDebugLogs(List<DebugLogs>.from(_buffer));
          _buffer.clear();
        } else {
          debugPrint("DebugLogsManager: DB count ($count) < 10000. Saving single log immediately.");
          await appRepo.saveDebugLog(logEntry);
        }
      } else {
        // DB count >= 10000, buffer logs
        _buffer.add(logEntry);
        debugPrint("DebugLogsManager: DB count ($count) >= 10000. Buffering log (current buffer size: ${_buffer.length}/100).");
        
        if (_buffer.length >= 100) {
          debugPrint("DebugLogsManager: Buffer full. Saving 100 logs and pruning oldest.");
          final logsToWrite = List<DebugLogs>.from(_buffer);
          _buffer.clear();
          await appRepo.saveDebugLogsAndPrune(logsToWrite);
        }
      }
    } catch (e, stack) {
      debugPrint("DebugLogsManager: Error capturing debug log: $e\n$stack");
    }
  }
}
