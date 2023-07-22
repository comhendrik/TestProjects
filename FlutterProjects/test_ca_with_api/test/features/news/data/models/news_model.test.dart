import 'package:flutter_test/flutter_test.dart';
import 'package:test_ca_with_api/features/news/data/models/news_model.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/domain/entities/source.dart';

void main() {
  const tNewsModel = NewsModel(source: Source(name: "Test source", id: "1"), author: "Test author", title: "Test title", description: "test description", url: "https://testNews/test", urlToImage: "https://urlToImage/test", publishedAt: "2023-07-22T17:20:03Z", content: "test content");
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

  test('should be a subclass of NumberTrivia',
          () async {
        expect(tNewsModel, isA<News>());
      }
  );

  group('fromJson', () {
    test(
        'return a valid model from JSON',
            () async {
          final result = NewsModel.fromJson(jsonMap);
          expect(result, tNewsModel);
        }
    );


  });

  group('toJson', () {
    test('should return a JSON map containing the proper data',
            () {
          final result = tNewsModel.toJson();
          expect(result, isA<Map<String, dynamic>>());
          final expectedMap = {
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
          expect(result, expectedMap);
        }
    );
  }
  );
}