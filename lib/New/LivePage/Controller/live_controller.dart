import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Models/commodities_model.dart';
import '../../../Models/news_model.dart';
import '../../../Models/spread_document_model.dart';
import '../Repository/live_repository_new.dart';

final liveControllerProvider = Provider(
  (ref) => LiveController(liveRepository: ref.watch(liveRepositoryNewProvider)),
);
final spreadDataProvider = FutureProvider<SpreadDocumentModel>(
  (ref) {
    return ref.watch(liveControllerProvider).getSpread();
  },
);
final commoditiesStream = StreamProvider(
  (ref) {
    return ref.watch(liveControllerProvider).commodities();
  },
);
final newsStream = StreamProvider(
  (ref) {
    return ref.watch(liveControllerProvider).getNews();
  },
);

class LiveController {
  final LiveRepositoryNew _liveRepositoryNew;
  LiveController({required LiveRepositoryNew liveRepository})
      : _liveRepositoryNew = liveRepository;

  Future<SpreadDocumentModel> getSpread() async {
    return _liveRepositoryNew.getSpread();
  }

  Stream<List<CommoditiesModel>> commodities() {
    return _liveRepositoryNew.commodities();
  }

  Stream<NewsModel> getNews() {
    return _liveRepositoryNew.getNews();
  }
}
