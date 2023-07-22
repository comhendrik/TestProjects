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

  setUpAll(() {
    httpClient = MockHttpClient();
    dataSource = NewsRemoteDataSourceImpl(httpClient: httpClient, apiKey: "b8e0661b556f45378ff40417ef14a697");
    apiKey = dataSource.apiKey;
  });


  void setUpMockHttpClientGetRequest(int statusCode, dynamic data) {
    final requestOptions = RequestOptions(path: '');
    final url = "https://newsapi.org/v2/everything?q=tesla&from=2023-06-22&sortBy=publishedAt&apiKey=$apiKey";
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
          setUpMockHttpClientGetRequest(200, data);
          dataSource.getNews();
          verify(() => httpClient.get("https://newsapi.org/v2/everything?q=tesla&from=2023-06-22&sortBy=publishedAt&apiKey=$apiKey"));
        }
    );
    test(
        'should perform a GET Request on a url and return right List of NewsModel when status code is 200',
            () async {
          setUpMockHttpClientGetRequest(200, data);
          final result = await dataSource.getNews();
          verify(() => httpClient.get("https://newsapi.org/v2/everything?q=tesla&from=2023-06-22&sortBy=publishedAt&apiKey=$apiKey"));
          expect(result, equals(tNewsModelList));
        }
    );
    test(
        'should perform a GET Request on a url  and throw a Server Exception when status code is not 200',
            () async {
          setUpMockHttpClientGetRequest(404, 'Something went wrong');
          expect(() => dataSource.getNews(), throwsA(TypeMatcher<ServerException>()));
        }
    );
  });
}