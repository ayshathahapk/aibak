import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../Core/Utils/failure.dart';
import '../../../Core/Utils/firebase_constants.dart';
import '../../../Core/Utils/type_def.dart';
import '../../../Models/get_profile.dart';

final profileRepo = Provider<ProfileRepo>(
  (ref) => ProfileRepo(),
);

class ProfileRepo {
  FutureEither<GetProfile?> getProfileDetailsNew() async {
    try {
      final responce = await Dio().get(
        "${FirebaseConstants.baseUrl}get-profile/${FirebaseConstants.adminId}",
        options: Options(headers: FirebaseConstants.headers, method: "GET"),
      );
      if (responce.statusCode == 200) {
        final profileModel = GetProfile.fromMap(responce.data);
        return right(profileModel);
      } else {
        return left(Failure(responce.statusCode.toString()));
      }
    } on DioException catch (e) {
      print(e.error);
      print(e.stackTrace);
      print(e.message);
      print(e.response);
      return left(Failure("Dio EXCEPTION"));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return left(Failure(e.toString()));
    }
  }
}
