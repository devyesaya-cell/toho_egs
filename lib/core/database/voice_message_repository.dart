import 'package:isar_community/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_service.dart';
import '../models/voice_message.dart';

class VoiceMessageRepository {
  final Isar isar;

  VoiceMessageRepository(this.isar);

  Stream<List<VoiceMessage>> watchMessages() {
    return isar.voiceMessages
        .where()
        .sortByTimestampDesc()
        .watch(fireImmediately: true);
  }

  Future<void> addMessage(String text, {String? sender}) async {
    final message = VoiceMessage(
      text: text,
      timestamp: DateTime.now(),
      sender: sender,
    );
    await isar.writeTxn(() async {
      await isar.voiceMessages.put(message);
    });
  }

  Future<void> clearAll() async {
    await isar.writeTxn(() async {
      await isar.voiceMessages.clear();
    });
  }
}

final voiceMessageRepositoryProvider = Provider<VoiceMessageRepository>((ref) {
  final db = DatabaseService();
  return VoiceMessageRepository(db.isar);
});

final voiceMessageStreamProvider = StreamProvider<List<VoiceMessage>>((ref) {
  final repo = ref.watch(voiceMessageRepositoryProvider);
  return repo.watchMessages();
});
