
class SendAcknowledge {
  final String sourceID;
  final int ackOpcode;
  final int status; // 0: Failed, 1: Success
  final DateTime timestamp;

  SendAcknowledge({
    required this.sourceID,
    required this.ackOpcode,
    required this.status,
    required this.timestamp,
  });

  bool get isSuccess => status == 1;

  @override
  String toString() {
    return 'SendAcknowledge(sourceID: $sourceID, ackOpcode: $ackOpcode, status: $status, timestamp: $timestamp)';
  }
}
