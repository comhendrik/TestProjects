import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_ca_with_api/core/error/exceptions.dart';
import 'package:test_ca_with_api/features/news/data/datasources/news_remote_data_source.dart';
import 'package:test_ca_with_api/features/news/data/models/news_model.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late MockHttpClient httpClient;
  late NewsRemoteDataSource dataSource;
  late String apiKey;
  late String url;

  setUpAll(() {
    httpClient = MockHttpClient();
    dataSource = NewsRemoteDataSourceImpl(httpClient: httpClient, apiKey: "");
    apiKey = dataSource.apiKey;

    //URL immer ändern, damit es funktioniert, dafür bessere Dinge finden
    url = "https://newsapi.org/v2/everything?q=tesla&from=2023-06-24&sortBy=publishedAt&apiKey=$apiKey";
  });


  void setUpMockHttpClientGetRequest(int statusCode, dynamic data, String url) {
    final requestOptions = RequestOptions(path: '');
    when(() => httpClient.get(url)).thenAnswer((_) async => Response(
      requestOptions: requestOptions,
      data: data,
      statusCode: statusCode,
    )
    );
  }

  group('getNews', () {

    final jsonMap = {
      'source': {
        'name': "Test source",
        'id' : "1"
      },
      'author': "Test author",
      'title': "Test title",
      'description': "test description",
      'url': "https://testNews/test",
      'urlToImage': "https://urlToImage/test",
      'publishedAt': "2023-07-22T17:20:03Z",
      'content': "test content",
    };
    final jsonMap2 = {
      'source': {
        'name': "Test source",
        'id' : "1"
      },
      'author': "Test author",
      'title': "Test title",
      'description': "test description",
      'url': "https://testNews/test",
      'urlToImage': "https://urlToImage/test",
      'publishedAt': "2023-07-22T17:20:03Z",
      'content': "test content",
    };
    final data = {
      "status":"ok",
      "totalResults":2,
      "articles":[
        jsonMap,
        jsonMap2
      ]
    };
    final tNewsModelList = [NewsModel.fromJson(jsonMap), NewsModel.fromJson(jsonMap2)];


    test(
        'should perform a GET Request on a url',
            () async {
          setUpMockHttpClientGetRequest(200, data, url);
          dataSource.getNews();
          verify(() => httpClient.get(url));
        }
    );
    test(
        'should perform a GET Request on a url and return right List of NewsModel when status code is 200',
            () async {
          setUpMockHttpClientGetRequest(200, data, url);
          final result = await dataSource.getNews();
          verify(() => httpClient.get(url));
          expect(result, equals(tNewsModelList));
        }
    );
    test(
        'should perform a GET Request on a url  and throw a Server Exception when status code is not 200',
            () async {
          setUpMockHttpClientGetRequest(404, 'Something went wrong', url);
          expect(() => dataSource.getNews(), throwsA(TypeMatcher<ServerException>()));
        }
    );
  });
}