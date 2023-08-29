import 'package:equatable/equatable.dart';

import '../../core/model/failure.dart';
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
    this.nowPlayingFailure,
    this.popularFailure,
    this.upcomingFailure,
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
  final Failure? nowPlayingFailure;
  final MovieListStateStatus popularStateStatus;
  final List<Movie> popularMovies;
  final List<Movie> popularSearchMovies;
  final Failure? popularFailure;
  final MovieListStateStatus upcomingStateStatus;
  final List<Movie> upcomingMovies;
  final Failure? upcomingFailure;

  MovieListState copyWith({
    MovieListStateStatus? nowPlayingStateStatus,
    List<Movie>? nowPlayingMovies,
    Failure? nowPlayingFailure,
    MovieListStateStatus? popularStateStatus,
    List<Movie>? popularMovies,
    List<Movie>? popularSearchMovies,
    Failure? popularFailure,
    MovieListStateStatus? upcomingStateStatus,
    List<Movie>? upcomingMovies,
    Failure? upcomingFailure,
  }) {
    return MovieListState(
      nowPlayingStateStatus:
          nowPlayingStateStatus ?? this.nowPlayingStateStatus,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingFailure: nowPlayingFailure ?? this.nowPlayingFailure,
      popularStateStatus: popularStateStatus ?? this.popularStateStatus,
      popularMovies: popularMovies ?? this.popularMovies,
      popularSearchMovies: popularSearchMovies ?? this.popularSearchMovies,
      popularFailure: popularFailure ?? this.popularFailure,
      upcomingStateStatus: upcomingStateStatus ?? this.upcomingStateStatus,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      upcomingFailure: upcomingFailure ?? this.upcomingFailure,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        nowPlayingStateStatus,
        nowPlayingMovies,
        nowPlayingFailure,
        popularStateStatus,
        popularMovies,
        popularSearchMovies,
        popularFailure,
        upcomingStateStatus,
        upcomingMovies,
        upcomingFailure
      ];
}
