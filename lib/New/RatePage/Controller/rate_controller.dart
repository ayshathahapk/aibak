import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Core/Utils/snackbar_dialogs.dart';
import '../../../Models/alertValue_model.dart';
import '../Repoitory/rate_repository.dart';

final rateController = Provider(
  (ref) => RateController(repository: ref.watch(rateRepository)),
);
final allAlertStream = StreamProvider.family(
  (ref, String deviceId) =>
      ref.watch(rateController).getAllAlert(deviceId: deviceId),
);

class RateController {
  final RateRepository _repository;
  RateController({required RateRepository repository})
      : _repository = repository;

  setAlert(
      {required AlertValueModel model, required BuildContext context}) async {
    final res = await _repository.setAlert(model: model);
    res.fold(
      (l) {
        showSnackBarDialogue(context: context, message: "Cant set Alert");
      },
      (r) {
        showSnackBarDialogue(context: context, message: "Success");
      },
    );
  }

  deleteAlert(
      {required AlertValueModel model, required BuildContext context}) async {
    final res = await _repository.deleteAlert(model: model);
    res.fold(
      (l) {
        showSnackBarDialogue(context: context, message: "Cant Delete Alert");
      },
      (r) {
        showSnackBarDialogue(context: context, message: "Alert Deleted");
      },
    );
  }

  Stream<List<AlertValueModel>> getAllAlert({required String deviceId}) {
    return _repository.getAllAlert(deviceId: deviceId);
  }
}
