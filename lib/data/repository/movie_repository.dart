import 'package:dartz/dartz.dart';

import '../../core/extension/iterable_ext.dart';
import '../../core/model/failure.dart';
import '../../domain/model/cast.dart';
import '../../domain/model/movie.dart';
import '../../domain/params/params_movie_detail.dart';
import '../../domain/params/params_movie_list.dart';
import '../dto/cast_dto.dart';
import '../dto/cast_list_dto.dart';
import '../dto/movie_dto.dart';
import '../dto/movie_list_dto.dart';
import '../service/movie_service.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies(ParamsMovieList params);

  Future<Either<Failure, List<Movie>>> getUpcomingMovies(
      ParamsMovieList params);

  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(
      ParamsMovieList params);

  Future<Either<Failure, Movie>> getMovieDetail(ParamsMovieDetail params);

  Future<Either<Failure, List<Cast>>> getCastMovie(ParamsMovieDetail params);
}

class MovieRepositoryImpl extends MovieRepository {
  MovieRepositoryImpl(this._service);

  final MovieService _service;

  @override
  Future<Either<Failure, List<Movie>>> getMovies(ParamsMovieList params) async {
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
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(
      ParamsMovieList params) async {
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
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies(
      ParamsMovieList params) async {
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
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetail(
      ParamsMovieDetail params) async {
    try {
      final MovieDto result = await _service.getMovieDetail(id: params.id);
      final Movie movie = result.asModel;
      return Right<Failure, Movie>(movie);
    } catch (e) {
      return Left<Failure, Movie>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Cast>>> getCastMovie(
      ParamsMovieDetail params) async {
    try {
      final CastListDto result = await _service.getMovieCredits(params.id);
      final List<Cast> casts = result.cast.orEmpty
          .map((CastDto castDto) => castDto.asModel)
          .toList();
      return Right<Failure, List<Cast>>(casts);
    } catch (e) {
      return Left<Failure, List<Cast>>(ServerFailure(message: e.toString()));
    }
  }
}
