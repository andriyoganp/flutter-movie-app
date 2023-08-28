import 'package:equatable/equatable.dart';

import '../../domain/model/cast.dart';
import '../../domain/model/movie.dart';

enum MovieDetailStateStatus { initial, loading, success, failure }

enum CastStateStatus { initial, loading, success, failure }

extension MovieDetailStateStatusX on MovieDetailStateStatus {
  bool get isInitial => this == MovieDetailStateStatus.initial;

  bool get isLoading => this == MovieDetailStateStatus.loading;

  bool get isSuccess => this == MovieDetailStateStatus.success;

  bool get isFailure => this == MovieDetailStateStatus.failure;
}

extension CastStateStatusX on CastStateStatus {
  bool get isInitial => this == CastStateStatus.initial;

  bool get isLoading => this == CastStateStatus.loading;

  bool get isSuccess => this == CastStateStatus.success;

  bool get isFailure => this == CastStateStatus.failure;
}

class MovieDetailState extends Equatable {
  MovieDetailState({
    this.status = MovieDetailStateStatus.initial,
    this.castStateStatus = CastStateStatus.initial,
    Movie? movie,
    List<Cast>? casts,
    this.isFavorite = false,
  })  : movie = movie ??
            Movie(
              id: 0,
              backdropPath: '',
              genreNames: <String>[],
              overview: '',
              posterPath: '',
              releaseDate: '',
              runtime: 0,
              title: '',
            ),
        casts = casts ?? <Cast>[];

  final MovieDetailStateStatus status;
  final Movie movie;
  final CastStateStatus castStateStatus;
  final List<Cast> casts;
  final bool isFavorite;

  MovieDetailState copyWith({
    MovieDetailStateStatus? status,
    Movie? movie,
    CastStateStatus? castStateStatus,
    List<Cast>? casts,
    bool? isFavorite,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      castStateStatus: castStateStatus ?? this.castStateStatus,
      casts: casts ?? this.casts,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => <Object>[
        status,
        movie,
        castStateStatus,
        casts,
        isFavorite,
      ];
}
