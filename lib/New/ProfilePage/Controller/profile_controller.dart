import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Models/get_profile.dart';
import '../Repo/profile_repo.dart';

final profileDetailsProvider = FutureProvider(
  (ref) {
    return ref.watch(profileController).getProfileDetailsNew();
  },
);

final profileController = Provider(
  (ref) => ProfileController(repo: ref.watch(profileRepo)),
);

class ProfileController {
  final ProfileRepo _profileRepo;
  ProfileController({required ProfileRepo repo}) : _profileRepo = repo;

  Future<GetProfile?> getProfileDetailsNew() async {
    GetProfile? spotRateModel;
    final res = await _profileRepo.getProfileDetailsNew();
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
}
