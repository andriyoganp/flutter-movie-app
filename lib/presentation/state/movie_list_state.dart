import 'package:equatable/equatable.dart';

import '../../domain/model/movie.dart';

enum MovieListStateStatus { initial, loading, success, failure }

extension MovieListStateStatusX on MovieListStateStatus {
  bool get isInitial => this == MovieListStateStatus.initial;

  bool get isLoading => this == MovieListStateStatus.loading;

  bool get isSuccess => this == MovieListStateStatus.success;

  bool get isFailure => this == MovieListStateStatus.failure;
}

final class MovieListState extends Equatable {
  MovieListState({
    this.nowPlayingStateStatus = MovieListStateStatus.initial,
    this.popularStateStatus = MovieListStateStatus.initial,
    this.upcomingStateStatus = MovieListStateStatus.initial,
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? popularSearchMovies,
    List<Movie>? upcomingMovies,
  })  : nowPlayingMovies = nowPlayingMovies ?? <Movie>[],
        popularMovies = popularMovies ?? <Movie>[],
        popularSearchMovies = popularSearchMovies ?? <Movie>[],
        upcomingMovies = upcomingMovies ?? <Movie>[];

  final MovieListStateStatus nowPlayingStateStatus;
  final List<Movie> nowPlayingMovies;
  final MovieListStateStatus popularStateStatus;
  final List<Movie> popularMovies;
  final List<Movie> popularSearchMovies;
  final MovieListStateStatus upcomingStateStatus;
  final List<Movie> upcomingMovies;

  MovieListState copyWith({
    MovieListStateStatus? nowPlayingStateStatus,
    List<Movie>? nowPlayingMovies,
    MovieListStateStatus? popularStateStatus,
    List<Movie>? popularMovies,
    List<Movie>? popularSearchMovies,
    MovieListStateStatus? upcomingStateStatus,
    List<Movie>? upcomingMovies,
  }) {
    return MovieListState(
      nowPlayingStateStatus:
          nowPlayingStateStatus ?? this.nowPlayingStateStatus,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularStateStatus: popularStateStatus ?? this.popularStateStatus,
      popularMovies: popularMovies ?? this.popularMovies,
      popularSearchMovies: popularSearchMovies ?? this.popularSearchMovies,
      upcomingStateStatus: upcomingStateStatus ?? this.upcomingStateStatus,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
    );
  }

  @override
  List<Object?> get props => <Object>[
        nowPlayingStateStatus,
        nowPlayingMovies,
        popularStateStatus,
        popularMovies,
        popularSearchMovies,
        upcomingStateStatus,
        upcomingMovies,
      ];
}
