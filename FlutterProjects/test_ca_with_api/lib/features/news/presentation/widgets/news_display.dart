import 'package:flutter/material.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';

class NewsDisplay extends StatelessWidget {
  final List<News> newsList;

  const NewsDisplay({
    super.key,
    required this.newsList
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: newsList.map((article){
      return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        color: Colors.green[100],
        child: ListTile(
          title: Text(article.title),
          subtitle: Text(article.description),
        ),
      );
    }).toList());
  }
}