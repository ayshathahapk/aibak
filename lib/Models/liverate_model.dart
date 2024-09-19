class LiveRateModel {
  Gold gold;
  Gold silver;

  LiveRateModel({
    required this.gold,
    required this.silver,
  });

  LiveRateModel copyWith({
    Gold? gold,
    Gold? silver,
  }) =>
      LiveRateModel(
        gold: gold ?? this.gold,
        silver: silver ?? this.silver,
      );

  factory LiveRateModel.fromJson(Map<dynamic, dynamic> json) => LiveRateModel(
        gold: Gold.fromJson(json["Gold"]),
        silver: Gold.fromJson(json["Silver"]),
      );

  Map<String, dynamic> toJson() => {
        "Gold": gold.toJson(),
        "Silver": silver.toJson(),
      };
}

class Gold {
  String symbol;
  double bid;
  double high;
  double low;
  String marketStatus;

  Gold({
    required this.symbol,
    required this.bid,
    required this.high,
    required this.low,
    required this.marketStatus,
  });

  Gold copyWith({
    String? symbol,
    double? bid,
    double? high,
    double? low,
    String? marketStatus,
  }) =>
      Gold(
        symbol: symbol ?? this.symbol,
        bid: bid ?? this.bid,
        high: high ?? this.high,
        low: low ?? this.low,
        marketStatus: marketStatus ?? this.marketStatus,
      );

  factory Gold.fromJson(Map<String, dynamic> json) => Gold(
        symbol: json["symbol"],
        bid: json["bid"]?.toDouble(),
        high: json["high"]?.toDouble(),
        low: json["low"]?.toDouble(),
        marketStatus: json["marketStatus"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "bid": bid,
        "high": high,
        "low": low,
        "marketStatus": marketStatus,
      };
}
