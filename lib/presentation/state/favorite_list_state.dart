import 'package:equatable/equatable.dart';

import '../../domain/model/movie.dart';

class FavoriteListState extends Equatable {
  FavoriteListState({
    List<Movie>? movies,
    List<Movie>? searchMovies,
  })  : movies = movies ?? <Movie>[],
        searchMovies = searchMovies ?? <Movie>[];

  final List<Movie> movies;
  final List<Movie> searchMovies;

  FavoriteListState copyWith({
    List<Movie>? movies,
    List<Movie>? searchMovies,
  }) =>
      FavoriteListState(
        movies: movies ?? this.movies,
        searchMovies: searchMovies ?? this.searchMovies,
      );

  @override
  List<Object?> get props => <Object>[movies, searchMovies];
}
