import 'package:get_it/get_it.dart';

import '../data/service/movie_service.dart';

void initService(GetIt getIt) {
  getIt.registerLazySingleton<MovieService>(
    () => MovieService(
      getIt(),
    ),
  );
}
