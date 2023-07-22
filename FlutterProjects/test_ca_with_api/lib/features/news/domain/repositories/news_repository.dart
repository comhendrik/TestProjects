import '../entities/news.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
abstract class NewsRepository {
  Future<Either<Failure,List<News>>> getNews();
}