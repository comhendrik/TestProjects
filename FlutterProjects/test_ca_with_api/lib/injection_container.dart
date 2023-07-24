import 'package:dio/dio.dart';
import 'package:test_ca_with_api/features/news/data/datasources/news_remote_data_source.dart';
import 'package:test_ca_with_api/features/news/data/repositories/news_repository_impl.dart';
import 'package:test_ca_with_api/features/news/domain/repositories/news_repository.dart';
import 'package:test_ca_with_api/features/news/domain/usecases/get_news.dart';
import 'package:test_ca_with_api/features/news/presentation/bloc/news_bloc.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
        () => NewsBloc(
          getNews: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(httpClient: sl(), apiKey: ''),
  );
  //! Core
  //! External
  sl.registerLazySingleton(() => Dio());
}