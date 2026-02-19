
class ProtocolService {
  // Singleton pattern
  static final ProtocolService _instance = ProtocolService._internal();

  factory ProtocolService() {
    return _instance;
  }

  ProtocolService._internal();

  void parseData(List<int> data) {
    // TODO: Implement protocol parsing logic
  }
}
