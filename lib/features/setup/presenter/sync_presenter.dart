import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/coms/nearby_sync_service.dart';

enum SyncConnectionStatus {
  idle,
  discovering,
  connecting,
  connected,
  sendingPayload,
  payloadSent,
  error,
}

class SyncState {
  final SyncConnectionStatus status;
  final String statusText;
  final String? connectedEndpointId;
  final double progress;

  const SyncState({
    this.status = SyncConnectionStatus.idle,
    this.statusText = 'Ready to sync',
    this.connectedEndpointId,
    this.progress = 0.0,
  });

  SyncState copyWith({
    SyncConnectionStatus? status,
    String? statusText,
    String? connectedEndpointId,
    double? progress,
  }) {
    return SyncState(
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      connectedEndpointId: connectedEndpointId ?? this.connectedEndpointId,
      progress: progress ?? this.progress,
    );
  }
}

class SyncPresenter extends Notifier<SyncState> {
  late final NearbySyncService _nearbyService;

  @override
  SyncState build() {
    _nearbyService = ref.watch(nearbySyncServiceProvider);
    return const SyncState();
  }

  Future<void> startDiscovery() async {
    state = state.copyWith(
      status: SyncConnectionStatus.discovering,
      statusText: 'Discovering host...',
      progress: 0.1,
    );

    final success = await _nearbyService.startDiscovery(
      userName: 'RoverApp', // Or whatever name is appropriate
      onEndpointFound: _onEndpointFound,
      onEndpointLost: _onEndpointLost,
    );

    if (!success) {
      state = state.copyWith(
        status: SyncConnectionStatus.error,
        statusText: 'Failed to start discovery',
        progress: 0.0,
      );
    }
  }

  void _onEndpointFound(
    String endpointId,
    String endpointName,
    String serviceId,
  ) async {
    state = state.copyWith(
      status: SyncConnectionStatus.connecting,
      statusText: 'Host found! Requesting connection...',
      progress: 0.3,
    );

    await _nearbyService.requestConnection(
      userName: 'RoverApp',
      endpointId: endpointId,
      onConnectionInitiated: _onConnectionInitiated,
      onConnectionResult: _onConnectionResult,
      onDisconnected: _onDisconnected,
    );
  }

  void _onEndpointLost(String? endpointId) {
    if (state.connectedEndpointId == endpointId) {
      state = state.copyWith(
        status: SyncConnectionStatus.error,
        statusText: 'Host connection lost during discovery',
        connectedEndpointId: null,
      );
    }
  }

  void _onConnectionInitiated(
    String endpointId,
    String endpointName,
    String token,
  ) async {
    state = state.copyWith(
      statusText: 'Connection initiated. Approving...',
      progress: 0.5,
    );

    await _nearbyService.acceptConnection(
      endpointId: endpointId,
      onDataReceived: (id, payloadBytes) {
        // Handle receiving data if needed
      },
    );
  }

  void _onConnectionResult(String endpointId, bool isConnected) {
    if (isConnected) {
      state = state.copyWith(
        status: SyncConnectionStatus.connected,
        statusText: 'Connected to host!',
        connectedEndpointId: endpointId,
        progress: 0.75,
      );

      // Connection is successful, automatically test sending payload
      _sendTestPayload(endpointId);
    } else {
      state = state.copyWith(
        status: SyncConnectionStatus.error,
        statusText: 'Connection rejected by host',
        connectedEndpointId: null,
        progress: 0.0,
      );
    }
  }

  void _onDisconnected(String endpointId) {
    state = state.copyWith(
      status: SyncConnectionStatus.error,
      statusText: 'Disconnected from host',
      connectedEndpointId: null,
      progress: 0.0,
    );
  }

  Future<void> _sendTestPayload(String endpointId) async {
    state = state.copyWith(
      status: SyncConnectionStatus.sendingPayload,
      statusText: 'Sending test payload...',
      progress: 0.85,
    );

    try {
      // 3. kirim list<int> dengan payload
      final testPayload = <int>[1, 2, 3, 4, 5];

      // Sending payload as JSON string initially, let's just use the NearbyPackage directly for bytes if needed
      // but NearbySyncService has sendJsonData which converts map to bytes. Let's create a raw byte sender in service.

      // For now we will wrap it in a Map since the service has sendJsonData
      await _nearbyService.sendJsonData(endpointId, {
        'test_payload': testPayload,
      });

      // 4. cek apakah berhasil di kirim
      state = state.copyWith(
        status: SyncConnectionStatus.payloadSent,
        statusText: 'Payload sent successfully!',
        progress: 1.0,
      );
    } catch (e) {
      state = state.copyWith(
        status: SyncConnectionStatus.error,
        statusText: 'Failed to send payload',
        progress: 0.75,
      );
    }
  }

  void stopSync() {
    _nearbyService.stopAll();
    state = const SyncState();
  }
}

final syncPresenterProvider = NotifierProvider<SyncPresenter, SyncState>(() {
  return SyncPresenter();
});
