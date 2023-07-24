import 'package:test_ca_with_api/core/error/exceptions.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/data/models/news_model.dart';
import 'package:dio/dio.dart';

abstract class NewsRemoteDataSource {
  final String apiKey;

  NewsRemoteDataSource({required this.apiKey});

  Future<List<News>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {

  final Dio httpClient;

  @override
  final String apiKey;

  NewsRemoteDataSourceImpl({
    required this.httpClient,
    required this.apiKey
  });



  @override
  Future<List<NewsModel>> getNews() async {
    final url = 'https://newsapi.org/v2/everything?q=tesla&from=2023-06-24&sortBy=publishedAt&apiKey=$apiKey';
    final result = await httpClient.get(url);
    if (result.statusCode == 200) {
      List<NewsModel> newsList = [];
      for (final article in result.data['articles']) {
        newsList.add(NewsModel.fromJson(article));
      }
      return newsList;
    } else {
      throw ServerException();
    }
  }

}