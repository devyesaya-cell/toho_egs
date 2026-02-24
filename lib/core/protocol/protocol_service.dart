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

class CRCCalculator {
  static int calculate(List<int> list) {
    int crc = 0xffff;
    for (int i = 0; i < list.length; i++) {
      crc = ((crc >> 8) & 0xff) | ((crc << 8) & 0xff00);
      crc ^= list[i];
      crc ^= ((crc & 0xff) >> 4) & 0xff;
      crc ^= ((crc << 8) << 4) & 0xff00;
      crc ^= ((crc & 0xff) << 4) << 1;
    }
    return crc;
  }
}
