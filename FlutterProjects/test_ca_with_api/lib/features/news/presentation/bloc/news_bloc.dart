import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/domain/usecases/get_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;

  NewsBloc({required this.getNews}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      emit(NewsInitial());
      if (event is GetNewsEvent)  {
        emit(NewsLoading());
        final resultEither = await getNews.execute();
        resultEither.fold(
          (failure) async {
            emit(const NewsError(errorMsg: 'Server Failure'));
          },
          (news) {
            emit(NewsLoaded(newsList: news));
          }
        );
      }
    });
  }
}
