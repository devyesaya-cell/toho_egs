class WorkConfig {
  final int gnssAltRef;
  final int altRef;
  final int bucketLenRef;
  final int bucketHorizRef;
  final int pitchComp;

  const WorkConfig({
    this.gnssAltRef = 0,
    this.altRef = 0,
    this.bucketLenRef = 0,
    this.bucketHorizRef = 0,
    this.pitchComp = 0,
  });

  WorkConfig copyWith({
    int? gnssAltRef,
    int? altRef,
    int? bucketLenRef,
    int? bucketHorizRef,
    int? pitchComp,
  }) {
    return WorkConfig(
      gnssAltRef: gnssAltRef ?? this.gnssAltRef,
      altRef: altRef ?? this.altRef,
      bucketLenRef: bucketLenRef ?? this.bucketLenRef,
      bucketHorizRef: bucketHorizRef ?? this.bucketHorizRef,
      pitchComp: pitchComp ?? this.pitchComp,
    );
  }
}
