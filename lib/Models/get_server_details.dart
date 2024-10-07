// To parse this JSON data, do
//
//     final getServerModel = getServerModelFromMap(jsonString);

import 'dart:convert';

GetServerModel getServerModelFromMap(String str) =>
    GetServerModel.fromMap(json.decode(str));

String getServerModelToMap(GetServerModel data) => json.encode(data.toMap());

class GetServerModel {
  final bool success;
  final Info info;
  final String message;

  GetServerModel({
    required this.success,
    required this.info,
    required this.message,
  });

  GetServerModel copyWith({
    bool? success,
    Info? info,
    String? message,
  }) =>
      GetServerModel(
        success: success ?? this.success,
        info: info ?? this.info,
        message: message ?? this.message,
      );

  factory GetServerModel.fromMap(Map<String, dynamic> json) => GetServerModel(
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
  final String serverUrl;
  final String serverName;

  Info({
    required this.serverUrl,
    required this.serverName,
  });

  Info copyWith({
    String? serverUrl,
    String? serverName,
  }) =>
      Info(
        serverUrl: serverUrl ?? this.serverUrl,
        serverName: serverName ?? this.serverName,
      );

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        serverUrl: json["serverURL"],
        serverName: json["serverName"],
      );

  Map<String, dynamic> toMap() => {
        "serverURL": serverUrl,
        "serverName": serverName,
      };
}
