import 'package:test_ca_with_api/features/news/data/datasources/news_remote_data_source.dart';
import 'package:test_ca_with_api/features/news/domain/entities/news.dart';
import 'package:test_ca_with_api/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:test_ca_with_api/core/error/failure.dart';
import 'package:test_ca_with_api/core/error/exceptions.dart';


class NewsRepositoryImpl implements NewsRepository {

  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure,List<News>>> getNews() async {
    try {
      return Right(await remoteDataSource.getNews());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}