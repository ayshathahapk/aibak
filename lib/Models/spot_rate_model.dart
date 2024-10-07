// To parse this JSON data, do
//
//     final spotRateModel = spotRateModelFromMap(jsonString);

import 'dart:convert';

SpotRateModel spotRateModelFromMap(String str) =>
    SpotRateModel.fromMap(json.decode(str));

String spotRateModelToMap(SpotRateModel data) => json.encode(data.toMap());

class SpotRateModel {
  final bool success;
  final Info info;
  final String message;

  SpotRateModel({
    required this.success,
    required this.info,
    required this.message,
  });

  SpotRateModel copyWith({
    bool? success,
    Info? info,
    String? message,
  }) =>
      SpotRateModel(
        success: success ?? this.success,
        info: info ?? this.info,
        message: message ?? this.message,
      );

  factory SpotRateModel.fromMap(Map<String, dynamic> json) => SpotRateModel(
        success: json["success"],
        info: Info.fromMap(json["info"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "info": info.toMap(),
        "message": message,
      };
}

class Info {
  final String id;
  final String createdBy;
  final double silverAskSpread;
  final double silverBidSpread;
  final double goldAskSpread;
  final double goldBidSpread;
  final double copperAskSpread;
  final double copperBidSpread;
  final double platinumAskSpread;
  final double platinumBidSpread;
  final double goldLowMargin;
  final double goldHighMargin;
  final double silverLowMargin;
  final double silverHighMargin;
  final double copperLowMargin;
  final double copperHighMargin;
  final double platinumLowMargin;
  final double platinumHighMargin;
  final List<Commodity> commodities;
  final int v;

  Info({
    required this.id,
    required this.createdBy,
    required this.silverAskSpread,
    required this.silverBidSpread,
    required this.goldAskSpread,
    required this.goldBidSpread,
    required this.copperAskSpread,
    required this.copperBidSpread,
    required this.platinumAskSpread,
    required this.platinumBidSpread,
    required this.goldLowMargin,
    required this.goldHighMargin,
    required this.silverLowMargin,
    required this.silverHighMargin,
    required this.copperLowMargin,
    required this.copperHighMargin,
    required this.platinumLowMargin,
    required this.platinumHighMargin,
    required this.commodities,
    required this.v,
  });

  Info copyWith({
    String? id,
    String? createdBy,
    double? silverAskSpread,
    double? silverBidSpread,
    double? goldAskSpread,
    double? goldBidSpread,
    double? copperAskSpread,
    double? copperBidSpread,
    double? platinumAskSpread,
    double? platinumBidSpread,
    double? goldLowMargin,
    double? goldHighMargin,
    double? silverLowMargin,
    double? silverHighMargin,
    double? copperLowMargin,
    double? copperHighMargin,
    double? platinumLowMargin,
    double? platinumHighMargin,
    List<Commodity>? commodities,
    int? v,
  }) =>
      Info(
        id: id ?? this.id,
        createdBy: createdBy ?? this.createdBy,
        silverAskSpread: silverAskSpread ?? this.silverAskSpread,
        silverBidSpread: silverBidSpread ?? this.silverBidSpread,
        goldAskSpread: goldAskSpread ?? this.goldAskSpread,
        goldBidSpread: goldBidSpread ?? this.goldBidSpread,
        copperAskSpread: copperAskSpread ?? this.copperAskSpread,
        copperBidSpread: copperBidSpread ?? this.copperBidSpread,
        platinumAskSpread: platinumAskSpread ?? this.platinumAskSpread,
        platinumBidSpread: platinumBidSpread ?? this.platinumBidSpread,
        goldLowMargin: goldLowMargin ?? this.goldLowMargin,
        goldHighMargin: goldHighMargin ?? this.goldHighMargin,
        silverLowMargin: silverLowMargin ?? this.silverLowMargin,
        silverHighMargin: silverHighMargin ?? this.silverHighMargin,
        copperLowMargin: copperLowMargin ?? this.copperLowMargin,
        copperHighMargin: copperHighMargin ?? this.copperHighMargin,
        platinumLowMargin: platinumLowMargin ?? this.platinumLowMargin,
        platinumHighMargin: platinumHighMargin ?? this.platinumHighMargin,
        commodities: commodities ?? this.commodities,
        v: v ?? this.v,
      );

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        id: json["_id"],
        createdBy: json["createdBy"],
        silverAskSpread: json["silverAskSpread"].toDouble(),
        silverBidSpread: json["silverBidSpread"].toDouble(),
        goldAskSpread: json["goldAskSpread"].toDouble(),
        goldBidSpread: json["goldBidSpread"].toDouble(),
        copperAskSpread: json["copperAskSpread"].toDouble(),
        copperBidSpread: json["copperBidSpread"].toDouble(),
        platinumAskSpread: json["platinumAskSpread"].toDouble(),
        platinumBidSpread: json["platinumBidSpread"].toDouble(),
        goldLowMargin: json["goldLowMargin"].toDouble(),
        goldHighMargin: json["goldHighMargin"].toDouble(),
        silverLowMargin: json["silverLowMargin"].toDouble(),
        silverHighMargin: json["silverHighMargin"].toDouble(),
        copperLowMargin: json["copperLowMargin"].toDouble(),
        copperHighMargin: json["copperHighMargin"].toDouble(),
        platinumLowMargin: json["platinumLowMargin"].toDouble(),
        platinumHighMargin: json["platinumHighMargin"].toDouble(),
        commodities: List<Commodity>.from(
            json["commodities"].map((x) => Commodity.fromMap(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "createdBy": createdBy,
        "silverAskSpread": silverAskSpread,
        "silverBidSpread": silverBidSpread,
        "goldAskSpread": goldAskSpread,
        "goldBidSpread": goldBidSpread,
        "copperAskSpread": copperAskSpread,
        "copperBidSpread": copperBidSpread,
        "platinumAskSpread": platinumAskSpread,
        "platinumBidSpread": platinumBidSpread,
        "goldLowMargin": goldLowMargin,
        "goldHighMargin": goldHighMargin,
        "silverLowMargin": silverLowMargin,
        "silverHighMargin": silverHighMargin,
        "copperLowMargin": copperLowMargin,
        "copperHighMargin": copperHighMargin,
        "platinumLowMargin": platinumLowMargin,
        "platinumHighMargin": platinumHighMargin,
        "commodities": List<dynamic>.from(commodities.map((x) => x.toMap())),
        "__v": v,
      };
}

class Commodity {
  final String metal;
  final int purity;
  final int unit;
  final String weight;
  final int buyPremium;
  final int sellPremium;
  final int buyCharge;
  final int sellCharge;
  final String id;

  Commodity({
    required this.metal,
    required this.purity,
    required this.unit,
    required this.weight,
    required this.buyPremium,
    required this.sellPremium,
    required this.buyCharge,
    required this.sellCharge,
    required this.id,
  });

  Commodity copyWith({
    String? metal,
    int? purity,
    int? unit,
    String? weight,
    int? buyPremium,
    int? sellPremium,
    int? buyCharge,
    int? sellCharge,
    String? id,
  }) =>
      Commodity(
        metal: metal ?? this.metal,
        purity: purity ?? this.purity,
        unit: unit ?? this.unit,
        weight: weight ?? this.weight,
        buyPremium: buyPremium ?? this.buyPremium,
        sellPremium: sellPremium ?? this.sellPremium,
        buyCharge: buyCharge ?? this.buyCharge,
        sellCharge: sellCharge ?? this.sellCharge,
        id: id ?? this.id,
      );

  factory Commodity.fromMap(Map<String, dynamic> json) => Commodity(
        metal: json["metal"],
        purity: json["purity"],
        unit: json["unit"],
        weight: json["weight"],
        buyPremium: json["buyPremium"],
        sellPremium: json["sellPremium"],
        buyCharge: json["buyCharge"],
        sellCharge: json["sellCharge"],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "metal": metal,
        "purity": purity,
        "unit": unit,
        "weight": weight,
        "buyPremium": buyPremium,
        "sellPremium": sellPremium,
        "buyCharge": buyCharge,
        "sellCharge": sellCharge,
        "_id": id,
      };
}
