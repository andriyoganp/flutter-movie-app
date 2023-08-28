import 'package:get_it/get_it.dart';

import '../domain/use_case/add_to_favorite_movie_use_case.dart';
import '../domain/use_case/check_is_favorite_movie_use_case.dart';
import '../domain/use_case/delete_from_favorite_use_case.dart';
import '../domain/use_case/get_cast_list_use_case.dart';
import '../domain/use_case/get_favorite_movies_use_case.dart';
import '../domain/use_case/get_movie_detail_use_case.dart';
import '../domain/use_case/get_movie_list_use_case.dart';

void initUseCase(GetIt getIt) {
  getIt
    ..registerLazySingleton(() => GetMovieListUseCase(getIt()))
    ..registerLazySingleton(() => GetMovieDetailUseCase(getIt()))
    ..registerLazySingleton(() => GetCastListUseCase(getIt()))
    ..registerLazySingleton(() => AddToFavoriteMovieUseCase(getIt()))
    ..registerLazySingleton(() => DeleteFromFavoriteUseCase(getIt()))
    ..registerLazySingleton(() => CheckIsFavoriteMovieUseCase(getIt()))
    ..registerLazySingleton(() => GetFavoriteMoviesUseCase(getIt()));
}
