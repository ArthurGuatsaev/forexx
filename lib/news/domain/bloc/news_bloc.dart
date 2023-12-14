import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forex_290/news/domain/model/news.dart';
import 'package:forex_290/news/domain/repository/news_repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(const NewsState()) {
    on<GetNewsEvent>(getNews);
  }
  getNews(GetNewsEvent event, Emitter<NewsState> emit) async {
    final news = await newsRepository.getNews();
    emit(state.copyWith(news: news));
  }
}
