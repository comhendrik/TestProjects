import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_ca/core/error/exceptions.dart';
import 'package:learn_tdd_ca/core/error/failure.dart';
import 'package:learn_tdd_ca/core/network/network_info.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:learn_tdd_ca/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main () {
  late NumberTriviaRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
    
  });
  
  group('getConcreteNumberTrivia', () {
    const tNumber =  1;
    final tNumberTriviaModel = const NumberTriviaModel(text: 'test trivia', number: tNumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online',
        () async {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);

          repository.getConcreteNumberTrivia(tNumber);

          verify(() =>  mockNetworkInfo.isConnected);


        }
    );
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when call to remote data source is succesfull',
          () async {
            when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getConcreteNumberTrivia(tNumber);
            expect(result, equals(Right(tNumberTrivia)));
          }
      );

      test(
          'should return server Failure when call to remote data source is unsuccesfull',
              () async {
            when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenThrow(ServerException());
            final result = await repository.getConcreteNumberTrivia(tNumber);
            expect(result, equals(Left(ServerFailure())));
          }
      );
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return no remote data when device is offline',
              () async {
            final result = await repository.getConcreteNumberTrivia(tNumber);
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(OnlineFailure())));
          }
      );
    });


  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = const NumberTriviaModel(text: 'test trivia', number: 123);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online',
            () async {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

          repository.getRandomNumberTrivia();

          verify(() =>  mockNetworkInfo.isConnected);


        }
    );
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when call to remote data source is succesfull',
              () async {
            when(() => mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getRandomNumberTrivia();
            expect(result, equals(Right(tNumberTrivia)));
          }
      );

      test(
          'should return server Failure when call to remote data source is unsuccesfull',
              () async {
            when(() => mockRemoteDataSource.getRandomNumberTrivia()).thenThrow(ServerException());
            final result = await repository.getRandomNumberTrivia();
            expect(result, equals(Left(ServerFailure())));
          }
      );
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return no remote data when device is offline',
              () async {
            final result = await repository.getRandomNumberTrivia();
            verifyZeroInteractions(mockRemoteDataSource);
            expect(result, equals(Left(OnlineFailure())));
          }
      );
    });


  });
}