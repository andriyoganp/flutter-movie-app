import 'package:objectbox/objectbox.dart';

@Entity()
class FavoriteMovieEntity {
  FavoriteMovieEntity({
    this.id = 0,
    this.movieId,
    this.movieJsonStr,
  });

  @Id()
  int id = 0;

  int? movieId;

  String? movieJsonStr;
}
