# Payload Blueprint — `sync_workfile` Command

> **Versi:** 2.0  
> **Update:** 2026-04-16  
> **Arah:** Host Basestation → Rover/Client (WebSocket)

---

## 1. Alur Komunikasi

```
[Rover/Client]                        [Host Basestation]
      |                                       |
      |--- "get_workfile" (string) ---------> |
      |                                       | (Cari WorkFile + WorkingSpots di DB lokal)
      |                                       | (Serialize ke JSON payload)
      | <--- sync_workfile JSON payload ------ |
      |                                       |
      | (Parse → simpan WorkFile & WorkingSpot ke Isar lokal)
```

---

## 2. Format Payload JSON (Host → Rover)

```json
{
  "status": "success",
  "command": "sync_workfile",
  "data": {
    "workfile": {
      "uid": 1713200000,
      "areaName": "RSKA006603",
      "panjang": 3.0,
      "lebar": 2.0,
      "luasArea": 600.0,
      "contractor": "divaji",
      "equipment": "EXCAD01",
      "totalSpot": 100,
      "spotDone": 0,
      "status": "in_progress",
      "createAt": 1713200000,
      "lastUpdate": 1713200000,
      "doneAt": null,
      "equipmentID": 65521,
      "operatorID": 51,
      "areaID": 52075
    },
    "working_results": [
      {
        "status": 0,
        "driverID": "0",
        "fileID": "1713200000",
        "spotID": 0,
        "mode": "SPOT",
        "totalTime": 0,
        "akurasi": 0.0,
        "deep": 0,
        "lat": -6.200000,
        "lng": 106.816666,
        "alt": 0,
        "lastUpdate": 1713200000
      }
    ]
  }
}
```

---

## 3. Field Reference: `workfile` Object

| Field | Tipe JSON | Tipe Dart | Sumber (Host DB) | Catatan |
|---|---|---|---|---|
| `uid` | `number` | `int?` | `WorkFile.uid` — epoch seconds lokal Host | **Diabaikan oleh Rover**. Rover generate uid sendiri dari epoch saat terima. |
| `areaName` | `string` | `String?` | `WorkFile.areaName` → dari `areas[0].area_name` server | Kode area, contoh: `"RSKA006603"` |
| `panjang` | `number` | `double?` | `WorkFile.panjang` → parsed dari `areas[0].spacing` | Bagian pertama `"3x2"` → `3.0` |
| `lebar` | `number` | `double?` | `WorkFile.lebar` → parsed dari `areas[0].spacing` | Bagian kedua `"3x2"` → `2.0` |
| `luasArea` | `number` | `double?` | `WorkFile.luasArea` = `totalSpot × (panjang × lebar)` | Dihitung, bukan dari server |
| `contractor` | `string` | `String?` | `WorkFile.contractor` → `areas[0].contractor.name` | Contoh: `"divaji"` |
| `equipment` | `string` | `String?` | `WorkFile.equipment` → `areas[0].equipments[0].part_name` | Contoh: `"EXCAD01"` |
| `totalSpot` | `number` | `int?` | `WorkFile.totalSpot` = jumlah WorkingSpots di DB | Dihitung dari jumlah record |
| `spotDone` | `number` | `int?` | `WorkFile.spotDone` | Jumlah spot dengan `status ≠ 0` |
| `status` | `string` | `String?` | `WorkFile.status` → dari `project.status` server | Contoh: `"in_progress"` |
| `createAt` | `number` | `int?` | `WorkFile.createAt` | Epoch seconds |
| `lastUpdate` | `number` | `int?` | `WorkFile.lastUpdate` | Epoch seconds |
| `doneAt` | `number\|null` | `int?` | `WorkFile.doneAt` | Epoch seconds. `null` jika belum selesai |
| `equipmentID` | `number` | `int?` | `WorkFile.equipmentID` → `areas[0].equipments[0].id` | ID numerik dari server |
| `operatorID` | `number` | `int?` | `WorkFile.operatorID` → `areas[0].operators[0].id` | ID numerik operator pertama |
| `areaID` | `number` | `int?` | `WorkFile.areaID` → `areas[0].id` | ID numerik area |

---

## 4. Field Reference: `working_results` Array (per item)

| Field | Tipe JSON | Tipe Dart | Sumber (Host DB) | Catatan |
|---|---|---|---|---|
| `status` | `number` | `int?` | `WorkingSpot.status` | `0` = belum dikerjakan, `1` = selesai |
| `driverID` | `string` | `String?` | `WorkingSpot.driverID` | ID string operator. `"0"` jika belum ada |
| `fileID` | `string` | `String?` | `WorkingSpot.fileID` | **Harus sama** dengan `workfile.uid.toString()` di Host |
| `spotID` | `number` | `int?` | `WorkingSpot.spotID` | Nomor urut spot. `0` jika belum ditentukan |
| `mode` | `string` | `String?` | `WorkingSpot.mode` | Selalu `"SPOT"` |
| `totalTime` | `number` | `int?` | `WorkingSpot.totalTime` | Durasi kerja dalam detik |
| `akurasi` | `number` | `double?` | `WorkingSpot.akurasi` | Akurasi GPS dalam meter |
| `deep` | `number` | `int?` | `WorkingSpot.deep` | Kedalaman galian |
| `lat` | `number` | `double?` | `WorkingSpot.lat` | Latitude titik spot |
| `lng` | `number` | `double?` | `WorkingSpot.lng` | Longitude titik spot |
| `alt` | `number` | `int?` | `WorkingSpot.alt` | Altitude dalam meter |
| `lastUpdate` | `number` | `int?` | `WorkingSpot.lastUpdate` | Epoch seconds |

---

## 5. Aturan Parsing di Rover/Client (`_handleWorkfileSync`)

### 5.1 Verifikasi Awal
```dart
if (data['command'] == 'sync_workfile' && data['status'] == 'success') {
  // Lanjut proses
}
```

### 5.2 Generate UID Lokal (TIDAK dari payload)
```dart
// UID rover dibuat dari waktu penerimaan, bukan dari uid di payload!
final int generatedUid = DateTime.now().millisecondsSinceEpoch ~/ 1000;
final String fileIDStr = generatedUid.toString();
```

### 5.3 Parse WorkFile
```dart
final workFile = WorkFile(
  uid: generatedUid,                                   // ← lokal epoch, bukan dari payload
  areaName: workfileJson['areaName'] as String?,
  panjang: (workfileJson['panjang'] as num?)?.toDouble(),
  lebar: (workfileJson['lebar'] as num?)?.toDouble(),
  luasArea: (workfileJson['luasArea'] as num?)?.toDouble(),
  contractor: workfileJson['contractor'] as String?,
  equipment: workfileJson['equipment'] as String?,
  totalSpot: (workfileJson['totalSpot'] as num?)?.toInt(),
  spotDone: (workfileJson['spotDone'] as num?)?.toInt(),
  status: workfileJson['status'] as String?,
  createAt: (workfileJson['createAt'] as num?)?.toInt(),
  lastUpdate: (workfileJson['lastUpdate'] as num?)?.toInt(),
  doneAt: (workfileJson['doneAt'] as num?)?.toInt(),
  equipmentID: (workfileJson['equipmentID'] as num?)?.toInt(),
  operatorID: (workfileJson['operatorID'] as num?)?.toInt(),
  areaID: (workfileJson['areaID'] as num?)?.toInt(),
);
```

### 5.4 Parse WorkingSpots → Override fileID
```dart
final List<WorkingSpot> spots = [];
for (final json in workingResultsJson) {
  if (json is Map<String, dynamic>) {
    final spot = WorkingSpot.fromJson(json);
    spot.fileID = fileIDStr;  // ← selalu override dengan uid lokal
    spots.add(spot);
  }
}
```

### 5.5 Simpan ke Isar
```dart
await appRepo.saveWorkFile(workFile);
if (spots.isNotEmpty) {
  await appRepo.saveWorkingSpots(spots);
}
```

---

## 6. Aturan Serialisasi di Host Basestation (`nearby_host_app`)

Saat Host menerima `"get_workfile"` dari Rover:

1. **Cari WorkFile** yang aktif (status `"in_progress"`) dari database lokal Isar.
2. **Cari WorkingSpots** dengan `fileID == WorkFile.uid.toString()`.
3. **Bangun payload JSON** sesuai schema di atas (Section 2).
4. Kirim via WebSocket ke Rover.

### Contoh serialisasi WorkFile (Host side)
```dart
Map<String, dynamic> workfileToJson(WorkFile wf) => {
  'uid': wf.uid,
  'areaName': wf.areaName,
  'panjang': wf.panjang,
  'lebar': wf.lebar,
  'luasArea': wf.luasArea,
  'contractor': wf.contractor,
  'equipment': wf.equipment,
  'totalSpot': wf.totalSpot,
  'spotDone': wf.spotDone,
  'status': wf.status,
  'createAt': wf.createAt,
  'lastUpdate': wf.lastUpdate,
  'doneAt': wf.doneAt,
  'equipmentID': wf.equipmentID,
  'operatorID': wf.operatorID,
  'areaID': wf.areaID,
};
```

### Contoh serialisasi WorkingSpot per item (Host side)
```dart
// WorkingSpot.toJson() sudah tersedia di model
spot.toJson(); // menghasilkan semua field yang dibutuhkan
```

### Contoh payload akhir yang dikirim Host
```dart
final payload = jsonEncode({
  'status': 'success',
  'command': 'sync_workfile',
  'data': {
    'workfile': workfileToJson(workFile),
    'working_results': spots.map((s) => s.toJson()).toList(),
  },
});
_wsChannel.sink.add(payload);
```

---

## 7. Catatan Penting

> **PENTING — UID Tidak Simetris**:  
> `WorkFile.uid` di Host (angka besar dari hex project ID server) **berbeda** dengan `WorkFile.uid` di Rover (epoch seconds saat penerimaan).  
> Relasi antar record dijaga oleh: `WorkingSpot.fileID == WorkFile.uid.toString()` di masing-masing sisi.

> **Tipe Data Number**:  
> Semua field numerik harus di-cast dengan `(as num?)?.toInt()` atau `(as num?)?.toDouble()` di Rover karena JSON tidak membedakan `int` dan `double`.

> **`doneAt` bisa null**:  
> Jika WorkFile belum selesai, `doneAt` dikirim sebagai JSON `null`, bukan `0`.