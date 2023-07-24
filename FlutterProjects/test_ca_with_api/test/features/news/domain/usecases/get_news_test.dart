import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/domain/entities/source.dart';
import 'package:test_ca_with_api/features/news/domain/repositories/news_repository.dart';
import 'package:test_ca_with_api/features/news/domain/usecases/get_news.dart';


class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late GetNews usecase;
  late MockNewsRepository mockNewsRepository;

  setUpAll(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNews(mockNewsRepository);
  });

  const tNews = News(
      source: Source(name: "Test source"),
      author: "Test author",
      title: "Test title",
      description: "test description",
      url: "https://testNews/test",
      urlToImage: "https://urlToImage/test",
      publishedAt: "2023-07-22T17:20:03Z",
      content: "test content"
  );

  const tNews2 = News(
      source: Source(name: "Test source"),
      author: "Test author",
      title: "Test title",
      description: "test description",
      url: "https://testNews/test",
      urlToImage: "https://urlToImage/test",
      publishedAt: "2023-07-22T17:20:03Z",
      content: "test content"
  );

  const tNewsList = [tNews,tNews2];

  test("should get News from repository", () async {
    when(() => mockNewsRepository.getNews()).thenAnswer((_) async => const Right(tNewsList));

    final result = await usecase.execute();

    expect(result, equals(const Right(tNewsList)));

    verify(() => mockNewsRepository.getNews());

    verifyNoMoreInteractions(mockNewsRepository);
  });
}