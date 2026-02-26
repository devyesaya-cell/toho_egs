class RadioConfig {
  final int channel;
  final int key;
  final int address;
  final int netID;
  final int airDataRate;
  final int lastUpdate;

  RadioConfig({
    required this.channel,
    required this.key,
    required this.address,
    required this.netID,
    required this.airDataRate,
    required this.lastUpdate,
  });
}
