import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/coms/com_service.dart';

// --- State Status Enum ---
enum SyncConnectionStatus {
  idle,
  connecting,
  connected,
  sendingPayload,
  payloadSent,
  error,
}

// --- Specific State Class ---
class SyncState {
  final SyncConnectionStatus status;
  final String statusText;
  final double progress;

  const SyncState({
    this.status = SyncConnectionStatus.idle,
    this.statusText = 'Waiting to start...',
    this.progress = 0.0,
  });

  SyncState copyWith({
    SyncConnectionStatus? status,
    String? statusText,
    double? progress,
  }) {
    return SyncState(
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      progress: progress ?? this.progress,
    );
  }
}

class SyncPresenter extends Notifier<SyncState> {
  late final ComService _comService;
  bool _isDisposed = false;

  @override
  SyncState build() {
    _comService = ref.watch(comServiceProvider.notifier);

    // Watch for WebSocket connection drops automatically from ComService state
    ref.listen(comServiceProvider, (previous, next) {
      if (_isDisposed) return;
      if (previous?.isWsConnected == true && next.isWsConnected == false) {
        state = state.copyWith(
          status: SyncConnectionStatus.error,
          statusText: 'Disconnected from Host network',
          progress: 0.0,
        );
      }
    });

    ref.onDispose(() {
      _isDisposed = true;
      _comService.disconnectWebSocket();
    });

    return const SyncState();
  }

  Future<void> startSync() async {
    state = state.copyWith(
      status: SyncConnectionStatus.connecting,
      statusText: 'Connecting to Host Network...',
      progress: 0.2,
    );

    final success = await _comService.connectToHostWebSocket();

    if (!success) {
      if (!_isDisposed) {
        state = state.copyWith(
          status: SyncConnectionStatus.error,
          statusText: 'Failed to connect. Are you on the Host Hotspot?',
          progress: 0.0,
        );
      }
      return;
    }

    if (!_isDisposed) {
      state = state.copyWith(
        status: SyncConnectionStatus.connected,
        statusText: 'Connected to Host!',
        progress: 0.5,
      );
    }

    // Automatically trigger test payload on successful connection
    _sendTestPayload();
  }

  Future<void> _sendTestPayload() async {
    if (_isDisposed) return;

    state = state.copyWith(
      status: SyncConnectionStatus.sendingPayload,
      statusText: 'Sending test payload...',
      progress: 0.8,
    );

    try {
      // Create a test payload dictionary
      final payload = {
        'type': 'test_sync',
        'data': [1, 2, 3, 4, 5],
      };

      _comService.sendDataToHost(payload);

      // Simulate a slight delay for UI impact
      await Future.delayed(const Duration(milliseconds: 500));

      if (!_isDisposed) {
        state = state.copyWith(
          status: SyncConnectionStatus.payloadSent,
          statusText: 'Payload sent successfully!',
          progress: 1.0,
        );
      }
    } catch (e) {
      if (!_isDisposed) {
        state = state.copyWith(
          status: SyncConnectionStatus.error,
          statusText: 'Failed to send payload',
          progress: 0.75,
        );
      }
    }
  }
}

final syncPresenterProvider =
    NotifierProvider.autoDispose<SyncPresenter, SyncState>(SyncPresenter.new);
