import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/model/failure.dart';
import '../../domain/model/movie.dart';
import '../../domain/params/params_movie_list.dart';
import '../../domain/use_case/get_movie_list_use_case.dart';
import '../state/movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit(this._getMovieListUseCase) : super(MovieListState());

  final GetMovieListUseCase _getMovieListUseCase;

  Future<void> fetchNowPlayingMovies() async {
    if (state.nowPlayingStateStatus.isLoading) {
      return;
    }

    emit(state.copyWith(nowPlayingStateStatus: MovieListStateStatus.loading));
    try {
      final Either<Failure, List<Movie>> result =
          await _getMovieListUseCase.call(ParamsMovieList());
      result.fold((Failure failure) {
        emit(
          state.copyWith(
            nowPlayingStateStatus: MovieListStateStatus.failure,
            nowPlayingFailure: failure,
          ),
        );
      }, (List<Movie> list) {
        emit(
          state.copyWith(
            nowPlayingStateStatus: MovieListStateStatus.success,
            nowPlayingMovies: list.sublist(0, 3),
          ),
        );
      });
    } catch (e) {
      emit(state.copyWith(nowPlayingStateStatus: MovieListStateStatus.failure));
    }
  }

  Future<void> fetchPopularMovies() async {
    if (state.popularStateStatus.isLoading) {
      return;
    }

    emit(state.copyWith(popularStateStatus: MovieListStateStatus.loading));
    try {
      final Either<Failure, List<Movie>> result = await _getMovieListUseCase
          .call(ParamsMovieList(contentType: MovieContentType.popular));
      result.fold((Failure failure) {
        emit(
          state.copyWith(
            popularStateStatus: MovieListStateStatus.failure,
            popularFailure: failure,
          ),
        );
      }, (List<Movie> list) {
        emit(
          state.copyWith(
            popularStateStatus: MovieListStateStatus.success,
            popularMovies: list.sublist(0, 10),
            popularSearchMovies: list.sublist(0, 10),
          ),
        );
      });
    } catch (e) {
      emit(state.copyWith(popularStateStatus: MovieListStateStatus.failure));
    }
  }

  Future<void> fetchUpcomingMovies() async {
    if (state.upcomingStateStatus.isLoading) {
      return;
    }

    emit(state.copyWith(upcomingStateStatus: MovieListStateStatus.loading));
    try {
      final Either<Failure, List<Movie>> result = await _getMovieListUseCase
          .call(ParamsMovieList(contentType: MovieContentType.upcoming));
      result.fold((Failure failure) {
        emit(
          state.copyWith(
            upcomingStateStatus: MovieListStateStatus.failure,
            upcomingFailure: failure,
          ),
        );
      }, (List<Movie> list) {
        emit(
          state.copyWith(
            upcomingStateStatus: MovieListStateStatus.success,
            upcomingMovies: list.sublist(0, 10),
          ),
        );
      });
    } catch (e) {
      emit(state.copyWith(upcomingStateStatus: MovieListStateStatus.failure));
    }
  }

  void searchPopularMovies(String query) {
    if (query.isNotEmpty) {
      final List<Movie> searchResult =
          state.popularSearchMovies.where((Movie element) {
        return element.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(
        state.copyWith(
          popularSearchMovies: searchResult,
        ),
      );
    } else {
      emit(state.copyWith(popularSearchMovies: state.popularMovies));
    }
  }
}
