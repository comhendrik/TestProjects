import 'package:flutter/material.dart';
import 'features/news/presentation/pages/news_pages.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
      ),
      debugShowCheckedModeBanner: false,
      home: const NewsPage(),
    );
  }
}
