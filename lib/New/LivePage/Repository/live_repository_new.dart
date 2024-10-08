import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:aibak/Core/Utils/firebase_constants.dart';

import '../../../../Core/Utils/failure.dart';
import '../../../../Core/Utils/type_def.dart';
import '../../../Models/spot_rate_model.dart';

final liveRepoNewProvider = Provider<LiveRepositoryNew>(
  (ref) => LiveRepositoryNew(),
);

class LiveRepositoryNew {
  FutureEither<SpotRateModel> getSpotRate() async {
    try {
      final responce = await Dio().get(
        "${FirebaseConstants.baseUrl}get-spotrates/${FirebaseConstants.adminId}",
        options: Options(headers: FirebaseConstants.headers, method: "GET"),
      );
      if (responce.statusCode == 200) {
        final spotRateModel = SpotRateModel.fromMap(responce.data);
        return right(spotRateModel);
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
