class ErrorAlert {
  String sourceID;
  String alertType;
  String message;
  DateTime timestamp;

  ErrorAlert({
    this.sourceID = 'N/A',
    this.alertType = 'N/A',
    this.message = 'N/A',
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
