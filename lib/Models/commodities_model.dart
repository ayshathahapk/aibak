class CommoditiesModel {
  final String buyAED;
  final String buyPremiumAED;
  final String metal;
  final String purity;
  final String sellAED;
  final String sellPremiumAED;
  final String unit;
  final String weight;
  final DateTime timestamp;

//<editor-fold desc="Data Methods">
  const CommoditiesModel({
    required this.buyAED,
    required this.buyPremiumAED,
    required this.metal,
    required this.purity,
    required this.sellAED,
    required this.sellPremiumAED,
    required this.unit,
    required this.weight,
    required this.timestamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommoditiesModel &&
          runtimeType == other.runtimeType &&
          buyAED == other.buyAED &&
          buyPremiumAED == other.buyPremiumAED &&
          metal == other.metal &&
          purity == other.purity &&
          sellAED == other.sellAED &&
          sellPremiumAED == other.sellPremiumAED &&
          unit == other.unit &&
          weight == other.weight &&
          timestamp == other.timestamp);

  @override
  int get hashCode =>
      buyAED.hashCode ^
      buyPremiumAED.hashCode ^
      metal.hashCode ^
      purity.hashCode ^
      sellAED.hashCode ^
      sellPremiumAED.hashCode ^
      unit.hashCode ^
      weight.hashCode ^
      timestamp.hashCode;

  @override
  String toString() {
    return 'CommoditiesModel{ buyAED: $buyAED, buyPremiumAED: $buyPremiumAED, metal: $metal, purity: $purity, sellAED: $sellAED, sellPremiumAED: $sellPremiumAED, unit: $unit, weight: $weight, timestamp: $timestamp,}';
  }

  CommoditiesModel copyWith({
    String? buyAED,
    String? buyPremiumAED,
    String? metal,
    String? purity,
    String? sellAED,
    String? sellPremiumAED,
    String? unit,
    String? weight,
    DateTime? timestamp,
  }) {
    return CommoditiesModel(
      buyAED: buyAED ?? this.buyAED,
      buyPremiumAED: buyPremiumAED ?? this.buyPremiumAED,
      metal: metal ?? this.metal,
      purity: purity ?? this.purity,
      sellAED: sellAED ?? this.sellAED,
      sellPremiumAED: sellPremiumAED ?? this.sellPremiumAED,
      unit: unit ?? this.unit,
      weight: weight ?? this.weight,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buyAED': this.buyAED,
      'buyPremiumAED': this.buyPremiumAED,
      'metal': this.metal,
      'purity': this.purity,
      'sellAED': this.sellAED,
      'sellPremiumAED': this.sellPremiumAED,
      'unit': this.unit,
      'weight': this.weight,
      'timestamp': this.timestamp,
    };
  }

  factory CommoditiesModel.fromMap(Map<String, dynamic> map) {
    return CommoditiesModel(
      buyAED: map['buyAED'] ?? "",
      buyPremiumAED: map['buyPremiumAED'] ?? "",
      metal: map['metal'] ?? "",
      purity: map['purity'] ?? "",
      sellAED: map['sellAED'] ?? "",
      sellPremiumAED: map['sellPremiumAED'] ?? "",
      unit: map['unit'] ?? "",
      weight: map['weight'] ?? "",
      timestamp:
          map['timestamp'] != null ? map['timestamp'].toDate() : DateTime.now(),
    );
  }

//</editor-fold>
}
