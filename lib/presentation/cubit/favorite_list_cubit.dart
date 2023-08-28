import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../core/interactor/use_case.dart';
import '../../domain/model/movie.dart';
import '../../domain/params/params_movie_detail.dart';
import '../../domain/use_case/delete_from_favorite_use_case.dart';
import '../../domain/use_case/get_favorite_movies_use_case.dart';
import '../state/favorite_list_state.dart';

class FavoriteListCubit extends Cubit<FavoriteListState> {
  FavoriteListCubit(
    this._getFavoriteMoviesUseCase,
    this._deleteFromFavoriteUseCase,
  ) : super(FavoriteListState());

  final GetFavoriteMoviesUseCase _getFavoriteMoviesUseCase;
  final DeleteFromFavoriteUseCase _deleteFromFavoriteUseCase;

  void fetchFavoriteMovies() {
    try {
      _getFavoriteMoviesUseCase.call(NoParams()).listen((List<Movie> movies) {
        if (isClosed) {
          return;
        }
        emit(state.copyWith(movies: movies, searchMovies: movies));
      });
    } catch (e) {
      debugPrint('check is favorite $e');
    }
  }

  void deleteFavoriteMovie(int movieId) {
    _deleteFromFavoriteUseCase.call(ParamsMovieDetail(id: movieId));
  }

  void searchFavoriteMovies(String query) {
    if (query.isNotEmpty) {
      final List<Movie> searchResult = state.movies.where((Movie element) {
        return element.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(
        state.copyWith(
          searchMovies: searchResult,
        ),
      );
    } else {
      emit(state.copyWith(searchMovies: state.movies));
    }
  }
}
