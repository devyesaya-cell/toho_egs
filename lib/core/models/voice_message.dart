import 'package:isar_community/isar.dart';

part 'voice_message.g.dart';

@collection
class VoiceMessage {
  Id id = Isar.autoIncrement;

  late String text;
  
  @Index()
  late DateTime timestamp;

  String? sender;

  VoiceMessage({
    required this.text,
    required this.timestamp,
    this.sender,
  });
}
