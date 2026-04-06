import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/coms/com_service.dart';
import '../../../../core/state/auth_state.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/utils/payload_builder.dart';
import '../../../../core/models/working_spot.dart';

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
  final List<WorkingSpot> spots;

  const SyncState({
    this.status = SyncConnectionStatus.idle,
    this.statusText = 'Waiting to start...',
    this.progress = 0.0,
    this.spots = const [],
  });

  SyncState copyWith({
    SyncConnectionStatus? status,
    String? statusText,
    double? progress,
    List<WorkingSpot>? spots,
  }) {
    return SyncState(
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      progress: progress ?? this.progress,
      spots: spots ?? this.spots,
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
    ref.listen<UsbState>(comServiceProvider, (previous, next) {
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
      // Wrap in microtask to avoid modifying other providers (ComService)
      // synchronously during the dispose phase of this provider.
      Future.microtask(() => _comService.disconnectWebSocket());
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
    _sendWorkingspotPayload();
  }

  Future<void> _sendWorkingspotPayload() async {
    if (_isDisposed) return;

    state = state.copyWith(
      status: SyncConnectionStatus.sendingPayload,
      statusText: 'Querying Data...',
      progress: 0.6,
    );

    try {
      final appRepo = ref.read(appRepositoryProvider);

      // 1. Get logged in person directly from authProvider
      final auth = ref.read(authProvider);
      final driverID = auth.currentUser?.uid;

      if (driverID == null || driverID.isEmpty) {
        throw Exception('No active user found in session');
      }

      // 2. Fetch Workingspots for sync based on shift
      final currentTime = DateTime.now();
      final spots = await appRepo.getWorkingSpotsForSync(driverID, currentTime);

      if (!_isDisposed) {
        state = state.copyWith(
          statusText: 'Sending ${spots.length} Records...',
          progress: 0.8,
          spots: spots,
        );
      }

      // 3. Build ByteArray Payload
      final payloadBytes = PayloadBuilder.buildSyncPayload(
        packageId: 0,
        workingSpots: spots,
      );

      // 4. Send via WebSocket (raw)
      _comService.sendRawDataToHost(payloadBytes);

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
          statusText: 'Failed to sync: $e',
          progress: 0.75,
        );
      }
    }
  }
}

final syncPresenterProvider =
    NotifierProvider.autoDispose<SyncPresenter, SyncState>(SyncPresenter.new);
