import 'dart:async';

import 'package:forex_290/loading/domain/model/loading_model.dart';
import 'package:forex_290/news/data/api_client_news.dart';
import 'package:forex_290/news/domain/model/news.dart';

class NewsRepository {
  List<News>? news;
  Future<List<News>?> getNews({StreamController<VLoading>? controller}) async {
    if (news != null) return news;
    news = await ApiClientNews.getNews();
    controller?.add(VLoading.news);
    return news;
  }
}
