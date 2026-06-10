import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_service.dart';
import '../models/activation.dart';

class ActivationState {
  final bool isInitialized;
  final bool isActivated;
  final Activation? activationData;
  final String deviceId;

  ActivationState({
    this.isInitialized = false,
    this.isActivated = false,
    this.activationData,
    this.deviceId = 'Loading...',
  });

  ActivationState copyWith({
    bool? isInitialized,
    bool? isActivated,
    Activation? activationData,
    String? deviceId,
  }) {
    return ActivationState(
      isInitialized: isInitialized ?? this.isInitialized,
      isActivated: isActivated ?? this.isActivated,
      activationData: activationData ?? this.activationData,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}

class ActivationNotifier extends Notifier<ActivationState> {
  @override
  ActivationState build() {
    _init();
    return ActivationState();
  }

  Future<void> _init() async {
    final deviceId = await getDeviceIdentifier();
    
    final isar = DatabaseService().isar;
    if (!isar.isOpen) {
      state = state.copyWith(isInitialized: true, deviceId: deviceId);
      return;
    }

    final activation = await isar.activations.get(1);
    if (activation != null) {
      state = ActivationState(
        isInitialized: true,
        isActivated: activation.status,
        activationData: activation,
        deviceId: deviceId,
      );
    } else {
      // Create default inactive record
      final defaultActivation = Activation(
        status: false,
        lastUpdate: DateTime.now(),
      );
      await isar.writeTxn(() async {
        await isar.activations.put(defaultActivation);
      });
      state = ActivationState(
        isInitialized: true,
        isActivated: false,
        activationData: defaultActivation,
        deviceId: deviceId,
      );
    }
  }

  Future<String> getDeviceIdentifier() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfo.windowsInfo;
        return windowsInfo.deviceId.replaceAll('{', '').replaceAll('}', '');
      }
    } catch (e) {
      debugPrint("Error fetching device identifier: $e");
    }
    return "EGS-DEV-DEVICE";
  }

  Future<void> setActivation({
    required String token,
    required String macAddress,
    required String equipmentId,
  }) async {
    final isar = DatabaseService().isar;
    final activation = Activation(
      token: token,
      status: true,
      lastUpdate: DateTime.now(),
      macAddress: macAddress,
      equipmentId: equipmentId,
    );

    await isar.writeTxn(() async {
      await isar.activations.put(activation);
    });

    state = state.copyWith(
      isActivated: true,
      activationData: activation,
    );
  }

  Future<void> deactivate() async {
    final isar = DatabaseService().isar;
    final activation = Activation(
      status: false,
      lastUpdate: DateTime.now(),
    );

    await isar.writeTxn(() async {
      await isar.activations.put(activation);
    });

    state = state.copyWith(
      isActivated: false,
      activationData: activation,
    );
  }
}

final activationProvider = NotifierProvider<ActivationNotifier, ActivationState>(
  ActivationNotifier.new,
);
