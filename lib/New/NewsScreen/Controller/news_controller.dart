import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Models/news_model.dart';
import '../Repository/news_repository.dart';

final newsControllerProvider = NotifierProvider<NewsController, bool>(
  () => NewsController(),
);
final newsProvider = FutureProvider(
  (ref) {
    return ref.watch(newsControllerProvider.notifier).getNews();
  },
);

class NewsController extends Notifier<bool> {
  @override
  bool build() {
    // TODO: implement build
    return false;
  }

  NewsRepository _repositoryNew() {
    return ref.read(liveRepoNewProvider);
  }

  Future<NewsModel?> getNews() async {
    NewsModel? newsModel;
    final res = await _repositoryNew().getNews();
    res.fold(
      (l) {
        print(l.message);
      },
      (r) {
        newsModel = r;
      },
    );
    return newsModel;
  }
}
