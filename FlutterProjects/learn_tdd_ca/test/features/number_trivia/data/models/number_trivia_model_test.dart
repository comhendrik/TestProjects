import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = const NumberTriviaModel(text: 'Test text', number: 1);

  test('should be a subclass of NumberTrivia',
      () async {
        expect(tNumberTriviaModel, isA<NumberTrivia>());
      }
  );

  group('fromJson', () {
    test(
      'return a valid model when the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
        final result = NumberTriviaModel.fromJson(jsonMap);
        expect(result, tNumberTriviaModel);
      }
    );

    test(
        'return a valid model when the JSON number is regarded as an double',
            () async {
          final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
          final result = NumberTriviaModel.fromJson(jsonMap);
          expect(result, tNumberTriviaModel);
        }
    );

  });

  group('toJson', () {
    test('should return a JSON map containing the proper data',
            () {
          final result = tNumberTriviaModel.toJson();
          expect(result, isA<Map<String, dynamic>>());
          final expectedMap = {
            "text": "Test text",
            "number": 1
          };
          expect(result, expectedMap);
        }
      );
    }
  );
}