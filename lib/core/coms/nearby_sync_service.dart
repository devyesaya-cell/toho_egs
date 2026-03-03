import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearby_connections/nearby_connections.dart';

// TODO: Install package first by running:
// flutter pub add nearby_connections
// then uncomment the import below:
// import 'package:nearby_connections/nearby_connections.dart';

/// Provider untuk Service ini agar mudah di-inject ke dalam Presenter manapun.
/// Menggunakan provider dasar karena service ini bersifat stateless/singleton-like
/// dalam logic pemanggilannya.
final nearbySyncServiceProvider = Provider<NearbySyncService>((ref) {
  return NearbySyncService();
});

/// Service terdedikasi untuk menangani koneksi P2P Hardware (Bluetooth/Wi-Fi Direct)
/// Menerapkan prinsip Single Responsibility (Clean Code), tidak ada logika UI di sini.
class NearbySyncService {
  // --- KONFIGURASI NEARBY CONNECTIONS ---
  // P2P_STAR sangat cocok untuk skenario 1 Basestation (Group Owner) ke banyak Rover (Client)
  // Untuk sementara tipe datanya dinamik agar menghindari error sebelum package diinstall.
  // Gunakan tipe data 'Strategy' dari package jika sudah di-uncomment.
  final dynamic _strategy = null; // Ganti dengan: Strategy.P2P_STAR;

  // Service ID unik untuk aplikasi agar tidak bentrok dengan aplikasi Android lain
  final String _serviceId = "com.toho_egs.sync";

  // Menyimpan daftar device endpoint ID yang berhasil terkoneksi
  final List<String> _connectedEndpoints = [];
  List<String> get connectedEndpoints => List.unmodifiable(_connectedEndpoints);

  // ==========================================
  // 1. FUNGSI UNTUK HOST (Misal: Basestation)
  // ==========================================

  /// Membuka portal koneksi agar device ini bisa ditemukan (Advertising)
  Future<bool> startAdvertising({
    required String userName,
    required void Function(String endpointId, String endpointName, String token)
    onConnectionInitiated,
    required void Function(String endpointId, bool isConnected)
    onConnectionResult,
    required void Function(String endpointId) onDisconnected,
  }) async {
    try {
      return await Nearby().startAdvertising(
        userName,
        _strategy,
        serviceId: _serviceId,
        onConnectionInitiated: (id, info) {
          onConnectionInitiated(
            id,
            info.endpointName,
            info.authenticationToken,
          );
        },
        onConnectionResult: (id, status) {
          if (status == Status.CONNECTED) {
            if (!_connectedEndpoints.contains(id)) _connectedEndpoints.add(id);
            onConnectionResult(id, true);
          } else {
            onConnectionResult(id, false);
          }
        },
        onDisconnected: (id) {
          _connectedEndpoints.remove(id);
          onDisconnected(id);
        },
      );
    } catch (e) {
      // Log exception di sini
      return false;
    }
  }

  // ==========================================
  // 2. FUNGSI UNTUK CLIENT (Misal: Rover)
  // ==========================================

  /// Mencari Host yang sedang membuka Advertising (Discovery)
  Future<bool> startDiscovery({
    required String userName,
    required void Function(
      String endpointId,
      String endpointName,
      String serviceId,
    )
    onEndpointFound,
    required void Function(String? endpointId) onEndpointLost,
  }) async {
    try {
      // /* UNCOMMENT SETELAH PACKAGE DIINSTALL
      return await Nearby().startDiscovery(
        userName,
        _strategy,
        serviceId: _serviceId,
        onEndpointFound: onEndpointFound,
        onEndpointLost: onEndpointLost,
      );
    } catch (e) {
      return false;
    }
  }

  /// Meminta koneksi ke Host yang telah ditemukan
  Future<void> requestConnection({
    required String userName,
    required String endpointId,
    required void Function(String endpointId, String endpointName, String token)
    onConnectionInitiated,
    required void Function(String endpointId, bool isConnected)
    onConnectionResult,
    required void Function(String endpointId) onDisconnected,
  }) async {
    // /* UNCOMMENT SETELAH PACKAGE DIINSTALL
    await Nearby().requestConnection(
      userName,
      endpointId,
      onConnectionInitiated: (id, info) {
        onConnectionInitiated(id, info.endpointName, info.authenticationToken);
      },
      onConnectionResult: (id, status) {
        if (status == Status.CONNECTED) {
          if (!_connectedEndpoints.contains(id)) _connectedEndpoints.add(id);
          onConnectionResult(id, true);
        } else {
          onConnectionResult(id, false);
        }
      },
      onDisconnected: (id) {
        _connectedEndpoints.remove(id);
        onDisconnected(id);
      },
    );
  }

  // ==========================================
  // 3. FUNGSI BERSAMA (HOST & CLIENT)
  // ==========================================

  /// Menerima Request (Dipanggil di dalam onConnectionInitiated dari kedua pihak)
  Future<void> acceptConnection({
    required String endpointId,
    required void Function(String endpointId, Uint8List payloadBytes)
    onDataReceived,
  }) async {
    // /* UNCOMMENT SETELAH PACKAGE DIINSTALL
    await Nearby().acceptConnection(
      endpointId,
      onPayLoadRecieved: (endpointId, payload) {
        if (payload.type == PayloadType.BYTES && payload.bytes != null) {
          onDataReceived(endpointId, payload.bytes!);
        }
      },
      onPayloadTransferUpdate: (id, payloadTransferUpdate) {
        // Bisa digunakan untuk logging / monitoring progress transfer jika kirim file besar
      },
    );
    // */
  }

  /// Fungsi utilitas untuk men-send data Map diubah otomatis menjadi Byte String
  Future<void> sendJsonData(
    String endpointId,
    Map<String, dynamic> data,
  ) async {
    try {
      final jsonString = jsonEncode(data);
      final bytes = utf8.encode(jsonString);
      // /* UNCOMMENT SETELAH PACKAGE DIINSTALL
      await Nearby().sendBytesPayload(endpointId, Uint8List.fromList(bytes));
      // */
    } catch (e) {
      // Tangani error pengiriman
      rethrow;
    }
  }

  /// Menutup segala proses koneksi untuk hemat baterai jika tidak dipakai
  Future<void> stopAll() async {
    // /* UNCOMMENT SETELAH PACKAGE DIINSTALL
    await Nearby().stopDiscovery();
    await Nearby().stopAdvertising();
    await Nearby().stopAllEndpoints();
    // */
    _connectedEndpoints.clear();
  }
}
