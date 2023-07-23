import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_ca_with_api/core/error/exceptions.dart';
import 'package:test_ca_with_api/core/error/failure.dart';
import 'package:test_ca_with_api/features/news/data/datasources/news_remote_data_source.dart';
import 'package:test_ca_with_api/features/news/data/models/news_model.dart';
import 'package:test_ca_with_api/features/news/data/repositories/news_repository_impl.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/domain/entities/source.dart';

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

void main() {
  late MockNewsRemoteDataSource remoteDataSource;
  late NewsRepositoryImpl repository;

  setUpAll(() {
    remoteDataSource = MockNewsRemoteDataSource();
    repository = NewsRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  group('getNews', () {
    final tNewsModel = NewsModel(source: Source(name: "Test source", id: "1"), author: "Test author", title: "Test title", description: "test description", url: "https://testNews/test", urlToImage: "https://urlToImage/test", publishedAt: "2023-07-22T17:20:03Z", content: "test content");
    final tNewsModel2 = NewsModel(source: Source(name: "Test source", id: "2"), author: "Test author", title: "Test title", description: "test description", url: "https://testNews/test", urlToImage: "https://urlToImage/test", publishedAt: "2023-07-22T17:20:03Z", content: "test content");
    final List<NewsModel> newsModelList = [tNewsModel,tNewsModel2];
    final List<News> newsList = newsModelList;

    test('should return data when call is successful', () async {
      when(() => remoteDataSource.getNews()).thenAnswer((_) async => newsModelList);
      final result = await repository.getNews();
      expect(result, equals(Right(newsList)));
    });

    test('should return ServerFailure when call is unseccesful', () async {
      when(() => remoteDataSource.getNews()).thenThrow(ServerException());
      final result = await repository.getNews();
      expect(result, equals(Left(ServerFailure())));
    });
  });
}