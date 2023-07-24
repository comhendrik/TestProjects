import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/domain/entities/source.dart';

class NewsModel extends News {
  const NewsModel({
    required Source source,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content
  }) : super(
    source: source,
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        source: Source(name: json['source']['name']),
        author: json['author'] ?? 'no author',
        title: json['title'] ?? 'no title',
        description: json['description'] ?? 'no description',
        url: json['url'],
        urlToImage: json['urlToImage'] ?? 'no urlToImage',
        publishedAt: json['publishedAt'] ?? 'no publishedAt',
        content: json['content'] ?? 'no content'
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'source': {
        'name': source.name,
      },
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}