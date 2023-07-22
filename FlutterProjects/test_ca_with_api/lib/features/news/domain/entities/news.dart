import 'package:equatable/equatable.dart';
import 'package:test_ca_with_api/features/news/domain/entities/source.dart';

class News extends Equatable {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
  });

  @override
  List<Object> get props => [source, author, title, description, url, urlToImage, publishedAt, content];
}