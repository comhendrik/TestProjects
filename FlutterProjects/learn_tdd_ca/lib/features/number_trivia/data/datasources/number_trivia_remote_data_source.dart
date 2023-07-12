import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:learn_tdd_ca/core/error/exceptions.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Dio client;

  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getTriviaFromUrl('http://numbersapi.com/$number?json');
  }
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return _getTriviaFromUrl('http://numbersapi.com/random?json');
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final result = await client.get(url);

    if (result.statusCode == 200) {
      return NumberTriviaModel.fromJson(result.data);
    } else {
      throw ServerException();
    }
  }
}