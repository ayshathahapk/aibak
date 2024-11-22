// To parse this JSON data, do
//
//     final getProfile = getProfileFromMap(jsonString);

import 'dart:convert';

GetProfile getProfileFromMap(String str) =>
    GetProfile.fromMap(json.decode(str));

String getProfileToMap(GetProfile data) => json.encode(data.toMap());

class GetProfile {
  final String message;
  final bool success;
  final ProfileInfo info;

  GetProfile({
    required this.message,
    required this.success,
    required this.info,
  });

  GetProfile copyWith({
    String? message,
    bool? success,
    ProfileInfo? info,
  }) =>
      GetProfile(
        message: message ?? this.message,
        success: success ?? this.success,
        info: info ?? this.info,
      );

  factory GetProfile.fromMap(Map<String, dynamic> json) => GetProfile(
        message: json["message"],
        success: json["success"],
        info: ProfileInfo.fromMap(json["info"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "success": success,
        "info": info.toMap(),
      };
}

class ProfileInfo {
  final String id;
  final String userName;
  final String companyName;
  final String address;
  final String email;
  final int contact;
  final int whatsapp;

  ProfileInfo({
    required this.id,
    required this.userName,
    required this.companyName,
    required this.address,
    required this.email,
    required this.contact,
    required this.whatsapp,
  });

  ProfileInfo copyWith({
    String? id,
    String? userName,
    String? companyName,
    String? address,
    String? email,
    int? contact,
    int? whatsapp,
  }) =>
      ProfileInfo(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        companyName: companyName ?? this.companyName,
        address: address ?? this.address,
        email: email ?? this.email,
        contact: contact ?? this.contact,
        whatsapp: whatsapp ?? this.whatsapp,
      );

  factory ProfileInfo.fromMap(Map<String, dynamic> json) => ProfileInfo(
        id: json["_id"],
        userName: json["userName"],
        companyName: json["companyName"],
        address: json["address"],
        email: json["email"],
        contact: json["contact"],
        whatsapp: json["whatsapp"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "userName": userName,
        "companyName": companyName,
        "address": address,
        "email": email,
        "contact": contact,
        "whatsapp": whatsapp,
      };
}
