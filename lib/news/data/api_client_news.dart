import 'package:dio/dio.dart';
import 'package:forex_290/const/strings.dart';
import 'package:forex_290/news/domain/model/news.dart';

class ApiClientNews {
  static Future<List<News>> getNews() async {
    try {
      final x =
          await Dio().get('https://$apiDomain/api/v2/news?token=$apiToken');
      if (x.statusCode == 200) {
        final data = x.data!['results'] as List<dynamic>;
        final newNews = data.map((e) => e as Map<String, dynamic>).toList();
        final news = newNews.map((e) => News.fromMap(e)).toList();
        return news;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
