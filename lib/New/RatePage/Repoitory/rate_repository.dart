import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:aibak/Core/Utils/failure.dart';
import 'package:aibak/Core/Utils/firebase_constants.dart';
import 'package:aibak/Core/Utils/firebase_provider.dart';
import 'package:aibak/Core/Utils/type_def.dart';
import 'package:aibak/Models/alertValue_model.dart';

final rateRepository = Provider(
  (ref) {
    return RateRepository(firestore: ref.watch(firestoreProvider));
  },
);

class RateRepository {
  final FirebaseFirestore _firestore;
  RateRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureEither<AlertValueModel> setAlert(
      {required AlertValueModel model}) async {
    try {
      await _firestore
          .collection(FirebaseConstants.user)
          .doc(FirebaseConstants.userDoc)
          .collection(FirebaseConstants.alert)
          .add(model.toMap())
          .then(
        (value) {
          value.update({"docId": value.id});
        },
      );

      return right(model);
    } on FirebaseException catch (e) {
      print(e.stackTrace);
      print(e.code);
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Futurevoid deleteAlert({required AlertValueModel model}) async {
    try {
      return right(await _firestore
          .collection(FirebaseConstants.user)
          .doc(FirebaseConstants.userDoc)
          .collection(FirebaseConstants.alert)
          .doc(model.docId)
          .delete());
    } on FirebaseException catch (e) {
      print(e.stackTrace);
      print(e.code);
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<AlertValueModel>> getAllAlert({required String deviceId}) {
    return _firestore
        .collection(FirebaseConstants.user)
        .doc(FirebaseConstants.userDoc)
        .collection(FirebaseConstants.alert)
        .where("uniqueId", isEqualTo: deviceId)
        .snapshots()
        .map(
          (event) => event.docs.map(
            (e) {
              AlertValueModel res = AlertValueModel.fromMap(e.data());
              return res;
            },
          ).toList(),
        );
  }
}
