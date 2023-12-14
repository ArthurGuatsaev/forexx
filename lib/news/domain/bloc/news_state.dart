// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_bloc.dart';

class NewsState {
  final List<News> news;
  const NewsState({this.news = const []});

  NewsState copyWith({
    List<News>? news,
  }) {
    return NewsState(
      news: news ?? this.news,
    );
  }
}
