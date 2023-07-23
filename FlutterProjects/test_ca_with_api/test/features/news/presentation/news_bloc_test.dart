import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_ca_with_api/core/error/failure.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/domain/entities/source.dart';
import 'package:test_ca_with_api/features/news/domain/usecases/get_news.dart';
import 'package:test_ca_with_api/features/news/presentation/bloc/news_bloc.dart';


class MockGetNews extends Mock implements GetNews {}

void main() {
  late GetNews getNews;
  late NewsBloc bloc;

  setUpAll(() {
    getNews = MockGetNews();
    bloc = NewsBloc(getNews: getNews);
  });


  group('getNews', () {
    const tNews = News(
        source: Source(name: "Test source", id: "1"),
        author: "Test author",
        title: "Test title",
        description: "test description",
        url: "https://testNews/test",
        urlToImage: "https://urlToImage/test",
        publishedAt: "2023-07-22T17:20:03Z",
        content: "test content"
    );

    const tNews2 = News(
        source: Source(name: "Test source", id: "2"),
        author: "Test author",
        title: "Test title",
        description: "test description",
        url: "https://testNews/test",
        urlToImage: "https://urlToImage/test",
        publishedAt: "2023-07-22T17:20:03Z",
        content: "test content"
    );

    const tNewsList = [tNews,tNews2];
    test(
        'should get data from getNews use case',
            () async {
          when(() => getNews.execute()).thenAnswer((_) async => Right(tNewsList));

          bloc.add(GetNewsEvent());

          await untilCalled(() => getNews.execute());

          verify(() => getNews.execute());


        }
    );

    test(
        'should emit [Initial(), Loading(), Loaded()] when the server request is succesful',
            () async {

          when(() => getNews.execute()).thenAnswer((_) async => Right(tNewsList));


          expectLater(bloc.stream, emitsInOrder(
              [
                NewsInitial(),
                NewsLoading(),
                NewsLoaded(newsList: tNewsList)
              ]
          ));

          bloc.add(GetNewsEvent());

        }
    );

    test(
        'should emit [Initial(), Loading(), Error()] when the request is unsuccessful',
            () async {

          when(() => getNews.execute()).thenAnswer((_) async => Left(ServerFailure()));


          expectLater(bloc.stream, emitsInOrder(
              [
                NewsInitial(),
                NewsLoading(),
                NewsError(errorMsg: 'Server Failure')
              ]
          ));

          bloc.add(GetNewsEvent());

        }
    );
  });
}