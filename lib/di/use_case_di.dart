import 'package:get_it/get_it.dart';

import '../domain/use_case/get_cast_list_use_case.dart';
import '../domain/use_case/get_movie_detail_use_case.dart';
import '../domain/use_case/get_movie_list_use_case.dart';

void initUseCase(GetIt getIt) {
  getIt
    ..registerLazySingleton(() => GetMovieListUseCase(getIt()))
    ..registerLazySingleton(() => GetMovieDetailUseCase(getIt()))
    ..registerLazySingleton(() => GetCastListUseCase(getIt()));
}
