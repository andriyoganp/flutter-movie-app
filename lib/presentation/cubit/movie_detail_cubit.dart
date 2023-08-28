import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../core/model/failure.dart';
import '../../domain/model/cast.dart';
import '../../domain/model/movie.dart';
import '../../domain/params/params_favorite_movie.dart';
import '../../domain/params/params_movie_detail.dart';
import '../../domain/use_case/add_to_favorite_movie_use_case.dart';
import '../../domain/use_case/check_is_favorite_movie_use_case.dart';
import '../../domain/use_case/delete_from_favorite_use_case.dart';
import '../../domain/use_case/get_cast_list_use_case.dart';
import '../../domain/use_case/get_movie_detail_use_case.dart';
import '../state/movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(
    this._getMovieDetailUseCase,
    this._getCastListUseCase,
    this._addToFavoriteMovieUseCase,
    this._deleteFromFavoriteUseCase,
    this._checkIsFavoriteMovieUseCase,
  ) : super(MovieDetailState());

  final GetMovieDetailUseCase _getMovieDetailUseCase;
  final GetCastListUseCase _getCastListUseCase;
  final AddToFavoriteMovieUseCase _addToFavoriteMovieUseCase;
  final DeleteFromFavoriteUseCase _deleteFromFavoriteUseCase;
  final CheckIsFavoriteMovieUseCase _checkIsFavoriteMovieUseCase;

  Future<void> fetchMovieDetail(int movieId) async {
    if (state.status.isLoading) {
      return;
    }

    emit(state.copyWith(status: MovieDetailStateStatus.loading));
    try {
      final Either<Failure, Movie> result =
          await _getMovieDetailUseCase.call(ParamsMovieDetail(id: movieId));
      result.fold(_setFailure, (Movie movie) {
        emit(state.copyWith(
          status: MovieDetailStateStatus.success,
          movie: movie,
        ));
      });
    } catch (e) {
      emit(state.copyWith(status: MovieDetailStateStatus.failure));
    }
  }

  void _setFailure(Failure l) {
    emit(state.copyWith(status: MovieDetailStateStatus.failure));
  }

  Future<void> fetchCast(int movieId) async {
    if (state.castStateStatus.isLoading) {
      return;
    }

    emit(state.copyWith(castStateStatus: CastStateStatus.loading));
    try {
      final Either<Failure, List<Cast>> result =
          await _getCastListUseCase.call(ParamsMovieDetail(id: movieId));
      result.fold((Failure failure) {
        emit(state.copyWith(castStateStatus: CastStateStatus.failure));
      }, (List<Cast> casts) {
        emit(state.copyWith(
          castStateStatus: CastStateStatus.success,
          casts:
              casts.where((Cast cast) => cast.profilePath.isNotEmpty).toList(),
        ));
      });
    } catch (e) {
      emit(state.copyWith(castStateStatus: CastStateStatus.failure));
    }
  }

  void addOrDeleteFavorite(bool isAdd) {
    if (isAdd) {
      _addToFavoriteMovieUseCase.call(ParamsFavoriteMovie(state.movie));
    } else {
      _deleteFromFavoriteUseCase.call(ParamsMovieDetail(id: state.movie.id));
    }
  }

  void checkIsFavorite(int movieId) {
    try {
      _checkIsFavoriteMovieUseCase
          .call(ParamsMovieDetail(id: movieId))
          .listen((bool isFavorite) {
        if (isClosed) {
          return;
        }
        emit(state.copyWith(isFavorite: isFavorite));
      });
    } catch (e) {
      debugPrint('check is favorite $e');
    }
  }
}
