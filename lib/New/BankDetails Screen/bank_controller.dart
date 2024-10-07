import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Models/bank_details_model.dart';
import 'bank_repo.dart';

final bankControllerProvider = Provider(
  (ref) => BankController(bankRepo: ref.watch(bankRepoProvider)),
);
final bankDetailsProvider = FutureProvider(
  (ref) {
    return ref.watch(bankControllerProvider).getBankDetailsNew();
  },
);

class BankController {
  final BankRepo _bankRepo;
  BankController({required BankRepo bankRepo}) : _bankRepo = bankRepo;

  Future<BankDetailsModel?> getBankDetailsNew() async {
    BankDetailsModel? spotRateModel;
    final res = await _bankRepo.getBankDetailsNew();
    res.fold(
      (l) {
        print("###ERROR###");
        print(l.message);
      },
      (r) {
        spotRateModel = r;
      },
    );
    return spotRateModel;
  }

  Future requestBank() async {
    final repsd = await _bankRepo.requestBank();
    repsd.fold(
      (l) {
        print("Controller Error");
        print(l.message);
      },
      (r) {
        print("Successs");
      },
    );

    return _bankRepo.requestBank();
  }
}
