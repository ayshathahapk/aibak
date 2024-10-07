// To parse this JSON data, do
//
//     final getCommodityModel = getCommodityModelFromMap(jsonString);

import 'dart:convert';

GetCommodityModel getCommodityModelFromMap(String str) =>
    GetCommodityModel.fromMap(json.decode(str));

String getCommodityModelToMap(GetCommodityModel data) =>
    json.encode(data.toMap());

class GetCommodityModel {
  final bool success;
  final List<String> commodities;
  final String message;

  GetCommodityModel({
    required this.success,
    required this.commodities,
    required this.message,
  });

  GetCommodityModel copyWith({
    bool? success,
    List<String>? commodities,
    String? message,
  }) =>
      GetCommodityModel(
        success: success ?? this.success,
        commodities: commodities ?? this.commodities,
        message: message ?? this.message,
      );

  factory GetCommodityModel.fromMap(Map<String, dynamic> json) =>
      GetCommodityModel(
        success: json["success"],
        commodities: List<String>.from(json["commodities"].map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "commodities": List<dynamic>.from(commodities.map((x) => x)),
        "message": message,
      };
}
