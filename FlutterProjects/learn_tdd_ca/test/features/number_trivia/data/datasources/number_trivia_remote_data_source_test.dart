import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:learn_tdd_ca/core/error/exceptions.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late NumberTriviaRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);

  });

  void setUpMockHttpClientGetRequest(int statusCode, dynamic data, int? tNumber) {
    final requestOptions = RequestOptions(path: '');
    var url = '';
    if (tNumber == null) {
      url = 'http://numbersapi.com/random?json';
    } else {
      url = 'http://numbersapi.com/$tNumber?json';
    }
    when(() => mockHttpClient.get(url)).thenAnswer((_) async => Response(
      requestOptions: requestOptions,
      data: data,
      statusCode: statusCode,
    )
    );
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final jsonMap = {
      "text": "Test text",
      "number": 1,
      "found": true,
      "type": "trivia"
    };
    final tNumberTriviaModel = NumberTriviaModel.fromJson(jsonMap);


    test(
      'should perform a GET Request on a url with number being the endpoint and application/json header',
      () async {
        setUpMockHttpClientGetRequest(200, jsonMap, tNumber);
        dataSource.getConcreteNumberTrivia(tNumber);
        verify(() => mockHttpClient.get('http://numbersapi.com/$tNumber?json'));
      }
    );
    test(
      'should perform a GET Request on a url with number being the endpoint and application/json header and return the right TNumberTriviaModel when status code is 200',
        () async {
          setUpMockHttpClientGetRequest(200, jsonMap, tNumber);
          final result = await dataSource.getConcreteNumberTrivia(tNumber);
          verify(() => mockHttpClient.get('http://numbersapi.com/$tNumber?json'));
          expect(result, equals(tNumberTriviaModel));
      }
    );
    test(
        'should perform a GET Request on a url with number being the endpoint and application/json header and throw a Server Exception when status code is not 200',
        () async {
          setUpMockHttpClientGetRequest(404, 'Something went wrong', tNumber);
          expect(() => dataSource.getConcreteNumberTrivia(tNumber), throwsA(TypeMatcher<ServerException>()));
        }
    );
  });

  group('getRandomNumberTrivia', () {
    final jsonMap = {
      "text": "Test text",
      "number": 1,
      "found": true,
      "type": "trivia"
    };
    final tNumberTriviaModel = NumberTriviaModel.fromJson(jsonMap);

    test(
        'should perform a GET Request on a url with number being the endpoint and application/json header',
        () async {
          setUpMockHttpClientGetRequest(200, jsonMap, null);
          dataSource.getRandomNumberTrivia();
          verify(() => mockHttpClient.get('http://numbersapi.com/random?json'));
        }
    );
    test(
        'should perform a GET Request on a url with number being the endpoint and application/json header and return the right TNumberTriviaModel when status code is 200',
            () async {
          setUpMockHttpClientGetRequest(200, jsonMap, null);
          final result = await dataSource.getRandomNumberTrivia();
          verify(() => mockHttpClient.get('http://numbersapi.com/random?json'));
          expect(result, equals(tNumberTriviaModel));
        }
    );
    test(
        'should perform a GET Request on a url with number being the endpoint and application/json header and throw a Server Exception when status code is not 200',
            () async {
          setUpMockHttpClientGetRequest(404, 'Something went wrong', null);
          expect(() => dataSource.getRandomNumberTrivia(), throwsA(const TypeMatcher<ServerException>()));
        }
    );
  });
}