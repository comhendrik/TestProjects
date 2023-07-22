import '../entities/news.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../repositories/news_repository.dart';

class GetNews {
  final NewsRepository repository;


  GetNews(this.repository);

  Future<Either<Failure,List<News>>> execute() async {
    return await repository.getNews();
  }
}