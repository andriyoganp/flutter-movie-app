import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../objectbox.g.dart';
import '../entity/favorite_movie_entity.dart';
import 'objectbox.dart';

abstract class FavoriteMovieDao {
  int addToFavorite(FavoriteMovieEntity entity);

  bool deleteFromFavorite(int movieId);

  Stream<bool> isFavorite(int movieId);

  Stream<List<FavoriteMovieEntity>> getAllFavoriteMovies();
}

class FavoriteMovieDaoImpl extends FavoriteMovieDao {
  FavoriteMovieDaoImpl(this._objectBox);

  final ObjectBox _objectBox;

  Box<FavoriteMovieEntity> _getBoxFavoriteMovie() =>
      _objectBox.store.box<FavoriteMovieEntity>();

  @override
  int addToFavorite(FavoriteMovieEntity entity) {
    final int result = _getBoxFavoriteMovie().put(entity);
    debugPrint('DAO RESULT ADD $result');
    return result;
  }

  @override
  bool deleteFromFavorite(int movieId) {
    try {
      final Query<FavoriteMovieEntity> query = _getBoxFavoriteMovie()
          .query(FavoriteMovieEntity_.movieId.equals(movieId))
          .build();
      final List<FavoriteMovieEntity> results = query.find();
      final int favoriteId = results
          .firstWhere((FavoriteMovieEntity entity) => entity.movieId == movieId)
          .id;
      return _getBoxFavoriteMovie().remove(favoriteId);
    } catch (e) {
      return false;
    }
  }

  @override
  Stream<bool> isFavorite(int movieId) {
    final Stream<List<FavoriteMovieEntity>> streamQueryResult =
        _getBoxFavoriteMovie()
            .query(FavoriteMovieEntity_.movieId.equals(movieId))
            .watch(triggerImmediately: true)
            .map((Query<FavoriteMovieEntity> query) => query.find());

    final StreamTransformer<List<FavoriteMovieEntity>, bool> transformer =
        StreamTransformer<List<FavoriteMovieEntity>, bool>.fromHandlers(
      handleData: (List<FavoriteMovieEntity> data, EventSink<bool> sink) {
        final bool isFavorite =
            data.any((FavoriteMovieEntity entity) => entity.movieId == movieId);
        sink.add(isFavorite);
      },
      handleError: (Object error, StackTrace stacktrace, EventSink<bool> sink) {
        sink.addError('Something went wrong: $error');
      },
      handleDone: (EventSink<bool> sink) => sink.close(),
    );
    return transformer.bind(streamQueryResult);
  }

  @override
  Stream<List<FavoriteMovieEntity>> getAllFavoriteMovies() {
    return _getBoxFavoriteMovie()
        .query()
        .order(FavoriteMovieEntity_.id, flags: Order.descending)
        .watch(triggerImmediately: true)
        .map((Query<FavoriteMovieEntity> query) => query.find());
  }
}
