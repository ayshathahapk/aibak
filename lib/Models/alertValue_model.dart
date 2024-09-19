class AlertValueModel {
  final double alertValue;
  final String fcm;
  final String uniqueId;
  final String docId;

//<editor-fold desc="Data Methods">

  const AlertValueModel({
    required this.alertValue,
    required this.docId,
    required this.fcm,
    required this.uniqueId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlertValueModel &&
          runtimeType == other.runtimeType &&
          alertValue == other.alertValue &&
          fcm == other.fcm &&
          uniqueId == other.uniqueId);

  @override
  int get hashCode => alertValue.hashCode ^ fcm.hashCode ^ uniqueId.hashCode;

  @override
  String toString() {
    return 'AlertValueModel{' +
        ' alertValue: $alertValue,' +
        ' fcm: $fcm,' +
        ' uniqueId: $uniqueId,' +
        '}';
  }

  AlertValueModel copyWith({
    double? alertValue,
    String? docId,
    String? fcm,
    String? uniqueId,
  }) {
    return AlertValueModel(
      alertValue: alertValue ?? this.alertValue,
      docId: docId ?? this.docId,
      fcm: fcm ?? this.fcm,
      uniqueId: uniqueId ?? this.uniqueId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alertValue': alertValue,
      'docId': docId,
      'fcm': fcm,
      'uniqueId': uniqueId,
    };
  }

  factory AlertValueModel.fromMap(Map<String, dynamic> map) {
    return AlertValueModel(
      alertValue: map['alertValue'].toDouble() ?? 0,
      fcm: map['fcm'] ?? "",
      docId: map['docId'] ?? "",
      uniqueId: map['uniqueId'] ?? "",
    );
  }

//</editor-fold>
}
