import 'package:dartz/dartz.dart';
import 'package:learn_tdd_ca/core/error/exceptions.dart';
import 'package:learn_tdd_ca/core/error/failure.dart';
import 'package:learn_tdd_ca/core/platform/network_info.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTrivia> _getConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {

    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });



  }
  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _getConcreteOrRandomChooser getConcreteOrRandom
      ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await getConcreteOrRandom());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OnlineFailure());
    }
  }
}