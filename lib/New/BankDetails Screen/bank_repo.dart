import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../Core/Utils/failure.dart';
import '../../../../Core/Utils/firebase_constants.dart';
import '../../../../Core/Utils/firebase_provider.dart';
import '../../../../Core/Utils/type_def.dart';
import '../../../../Models/bank_details_model.dart';

final bankRepoProvider = Provider(
  (ref) => BankRepo(firestore: ref.watch(firestoreProvider)),
);

class BankRepo {
  final FirebaseFirestore _firestore;
  BankRepo({required FirebaseFirestore firestore}) : _firestore = firestore;

  // Stream<List<BankDetailsModel?>> getBankDetails() {
  //   return _firestore
  //       .collection(FirebaseConstants.user)
  //       .doc(FirebaseConstants.userDoc)
  //       .collection(FirebaseConstants.bank)
  //       .snapshots()
  //       .map(
  //         (event) => event.docs.map(
  //           (e) {
  //             if (e.exists) {
  //               BankDetailsModel res = BankDetailsModel.fromMap(e.data());
  //               return res;
  //             } else {
  //               return null;
  //             }
  //           },
  //         ).toList(),
  //       );
  // }

  FutureEither<BankDetailsModel?> getBankDetailsNew() async {
    try {
      final responce = await Dio().get(
        "${FirebaseConstants.baseUrl}get-banks/${FirebaseConstants.adminId}",
        options: Options(headers: FirebaseConstants.headers, method: "GET"),
      );
      if (responce.statusCode == 200) {
        final spotRateModel = BankDetailsModel.fromMap(responce.data);
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

  FutureEither<String> requestBank() async {
    try {
      var data = json.encode({"request": "Request for bankDetails"});
      final response = await Dio().request(
        "${FirebaseConstants.baseUrl}get-banks/${FirebaseConstants.adminId}",
        options: Options(
          headers: FirebaseConstants.headers,
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return right("Success");
      } else {
        print("#####Status Code########");
        print(response.statusCode);
        return left(Failure(response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print("Dio Error ########");
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
