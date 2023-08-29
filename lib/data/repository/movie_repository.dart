import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../core/extension/iterable_ext.dart';
import '../../core/extension/string_ext.dart';
import '../../core/model/failure.dart';
import '../../core/network/network_checker.dart';
import '../../domain/model/cast.dart';
import '../../domain/model/movie.dart';
import '../../domain/params/params_favorite_movie.dart';
import '../../domain/params/params_movie_detail.dart';
import '../../domain/params/params_movie_list.dart';
import '../database/movie_dao.dart';
import '../dto/cast_dto.dart';
import '../dto/cast_list_dto.dart';
import '../dto/movie_dto.dart';
import '../dto/movie_list_dto.dart';
import '../entity/favorite_movie_entity.dart';
import '../service/movie_service.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies(ParamsMovieList params);

  Future<Either<Failure, List<Movie>>> getUpcomingMovies(
      ParamsMovieList params);

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(
      ParamsMovieList params);

  Future<Either<Failure, Movie>> getMovieDetail(ParamsMovieDetail params);

  Future<Either<Failure, List<Cast>>> getCastMovie(ParamsMovieDetail params);

  Future<Either<Failure, bool>> addToFavorite(ParamsFavoriteMovie params);

  Future<Either<Failure, bool>> deleteFromFavorite(ParamsMovieDetail params);

  Stream<bool> checkIsFavorite(ParamsMovieDetail params);

  Stream<List<Movie>> getFavoriteMovies();
}

class MovieRepositoryImpl extends MovieRepository {
  MovieRepositoryImpl(
    this._service,
    this._favoriteMovieDao,
    this._networkChecker,
  );

  final MovieService _service;
  final FavoriteMovieDao _favoriteMovieDao;
  final NetworkChecker _networkChecker;

  @override
  Future<Either<Failure, List<Movie>>> getMovies(ParamsMovieList params) async {
    if (await _networkChecker.hasConnection()) {
      try {
        final MovieListDto result = await _service.getMovies(
          queries: params.queries,
        );
        final List<Movie> movies = result.results.orEmpty
            .map((MovieDto movieDto) => movieDto.asModel)
            .toList();
        return Right<Failure, List<Movie>>(movies);
      } catch (e) {
        return Left<Failure, List<Movie>>(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left<Failure, List<Movie>>(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(
      ParamsMovieList params) async {
    if (await _networkChecker.hasConnection()) {
      try {
        final MovieListDto result =
            await _service.getNowPlayingMovies(page: params.page);
        final List<Movie> movies = result.results.orEmpty
            .map((MovieDto movieDto) => movieDto.asModel)
            .toList();
        return Right<Failure, List<Movie>>(movies);
      } catch (e) {
        return Left<Failure, List<Movie>>(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left<Failure, List<Movie>>(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(
      ParamsMovieList params) async {
    if (await _networkChecker.hasConnection()) {
      try {
        final MovieListDto result =
            await _service.getUpcomingMovies(page: params.page);
        final List<Movie> movies = result.results.orEmpty
            .map((MovieDto movieDto) => movieDto.asModel)
            .toList();
        return Right<Failure, List<Movie>>(movies);
      } catch (e) {
        return Left<Failure, List<Movie>>(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left<Failure, List<Movie>>(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetail(
      ParamsMovieDetail params) async {
    if (await _networkChecker.hasConnection()) {
      try {
        final MovieDto result = await _service.getMovieDetail(id: params.id);
        final Movie movie = result.asModel;
        return Right<Failure, Movie>(movie);
      } catch (e) {
        return Left<Failure, Movie>(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left<Failure, Movie>(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Cast>>> getCastMovie(
      ParamsMovieDetail params) async {
    if (await _networkChecker.hasConnection()) {
      try {
        final CastListDto result = await _service.getMovieCredits(params.id);
        final List<Cast> casts = result.cast.orEmpty
            .map((CastDto castDto) => castDto.asModel)
            .toList();
        return Right<Failure, List<Cast>>(casts);
      } catch (e) {
        return Left<Failure, List<Cast>>(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left<Failure, List<Cast>>(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addToFavorite(
      ParamsFavoriteMovie params) async {
    try {
      final int result = _favoriteMovieDao.addToFavorite(FavoriteMovieEntity(
          movieId: params.movie.id, movieJsonStr: jsonEncode(params.movie)));
      return Right<Failure, bool>(result == 0);
    } catch (e) {
      return Left<Failure, bool>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFromFavorite(
      ParamsMovieDetail params) async {
    try {
      final bool result = _favoriteMovieDao.deleteFromFavorite(params.id);
      return Right<Failure, bool>(result);
    } catch (e) {
      return Left<Failure, bool>(CacheFailure(message: e.toString()));
    }
  }

  @override
  Stream<bool> checkIsFavorite(ParamsMovieDetail params) =>
      _favoriteMovieDao.isFavorite(params.id);

  @override
  Stream<List<Movie>> getFavoriteMovies() {
    return _favoriteMovieDao
        .getAllFavoriteMovies()
        .map((List<FavoriteMovieEntity> list) => list
            .map((FavoriteMovieEntity entity) => Movie.fromJson(
                  jsonDecode(entity.movieJsonStr.orEmpty),
                ))
            .toList());
  }
}
