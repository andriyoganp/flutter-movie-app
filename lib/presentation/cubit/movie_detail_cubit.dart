import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../core/model/failure.dart';
import '../../domain/model/cast.dart';
import '../../domain/model/movie.dart';
import '../../domain/params/params_movie_detail.dart';
import '../../domain/use_case/get_cast_list_use_case.dart';
import '../../domain/use_case/get_movie_detail_use_case.dart';
import '../state/movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this._getMovieDetailUseCase, this._getCastListUseCase)
      : super(MovieDetailState());

  final GetMovieDetailUseCase _getMovieDetailUseCase;
  final GetCastListUseCase _getCastListUseCase;

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
}
