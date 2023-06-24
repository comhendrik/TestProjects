import 'dart:io';

import 'package:dio/dio.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:convert/convert.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late NumberTriviaRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);

  });

  group('getConcreteNumbeTrivia', () {
    final tNumber = 1;
    final requestOptions = RequestOptions(path: '');
    test(
        'should perform a GET Request on a url with number being the endpoint and application/json header',
        () async {
          when(() => mockHttpClient.get('http://numbersapi.com/$tNumber')).thenAnswer((_) async => Response(requestOptions: requestOptions));
          dataSource.getConcreteNumberTrivia(tNumber);
          verify(() => mockHttpClient.get('http://numbersapi.com/$tNumber'));




      }
    );
  });
}