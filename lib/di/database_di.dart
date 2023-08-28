import 'package:get_it/get_it.dart';

import '../data/database/movie_dao.dart';
import '../data/database/objectbox.dart';

Future<void> initDatabase(GetIt getIt) async {
  final ObjectBox objectBox = await ObjectBox.create();
  getIt
    ..registerSingleton<ObjectBox>(objectBox)
    ..registerLazySingleton<FavoriteMovieDao>(
        () => FavoriteMovieDaoImpl(objectBox));
}
