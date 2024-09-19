class SpreadDocumentModel {
  final double editedAskSilverSpreadValue;
  final double editedAskSpreadValue;
  final double editedBidSilverSpreadValue;
  final double editedBidSpreadValue;

//<editor-fold desc="Data Methods">
  const SpreadDocumentModel({
    required this.editedAskSilverSpreadValue,
    required this.editedAskSpreadValue,
    required this.editedBidSilverSpreadValue,
    required this.editedBidSpreadValue,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpreadDocumentModel &&
          runtimeType == other.runtimeType &&
          editedAskSilverSpreadValue == other.editedAskSilverSpreadValue &&
          editedAskSpreadValue == other.editedAskSpreadValue &&
          editedBidSilverSpreadValue == other.editedBidSilverSpreadValue &&
          editedBidSpreadValue == other.editedBidSpreadValue);

  @override
  int get hashCode =>
      editedAskSilverSpreadValue.hashCode ^
      editedAskSpreadValue.hashCode ^
      editedBidSilverSpreadValue.hashCode ^
      editedBidSpreadValue.hashCode;

  @override
  String toString() {
    return 'SpreadDocumentModel{ editedAskSilverSpreadValue: $editedAskSilverSpreadValue, editedAskSpreadValue: $editedAskSpreadValue, editedBidSilverSpreadValue: $editedBidSilverSpreadValue, editedBidSpreadValue: $editedBidSpreadValue,}';
  }

  SpreadDocumentModel copyWith({
    double? editedAskSilverSpreadValue,
    double? editedAskSpreadValue,
    double? editedBidSilverSpreadValue,
    double? editedBidSpreadValue,
  }) {
    return SpreadDocumentModel(
      editedAskSilverSpreadValue:
          editedAskSilverSpreadValue ?? this.editedAskSilverSpreadValue,
      editedAskSpreadValue: editedAskSpreadValue ?? this.editedAskSpreadValue,
      editedBidSilverSpreadValue:
          editedBidSilverSpreadValue ?? this.editedBidSilverSpreadValue,
      editedBidSpreadValue: editedBidSpreadValue ?? this.editedBidSpreadValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'editedAskSilverSpreadValue': editedAskSilverSpreadValue,
      'editedAskSpreadValue': editedAskSpreadValue,
      'editedBidSilverSpreadValue': editedBidSilverSpreadValue,
      'editedBidSpreadValue': editedBidSpreadValue,
    };
  }

  factory SpreadDocumentModel.fromMap(Map<String, dynamic> map) {
    return SpreadDocumentModel(
      editedAskSilverSpreadValue:
          map['editedAskSilverSpreadValue'].toDouble() ?? 0,
      editedAskSpreadValue: map['editedAskSpreadValue'].toDouble() ?? 0,
      editedBidSilverSpreadValue:
          map['editedBidSilverSpreadValue'].toDouble() ?? 0,
      editedBidSpreadValue: map['editedBidSpreadValue'].toDouble() ?? 0,
    );
  }

//</editor-fold>
}
