import 'package:get_it/get_it.dart';

import '../data/repository/movie_repository.dart';

void initRepository(GetIt getIt) {
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt(), getIt(), getIt()),
  );
}
