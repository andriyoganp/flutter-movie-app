import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/movie_dto.dart';
import '../dto/movie_list_dto.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService {
  factory MovieService(Dio dio, {String baseUrl}) = _MovieService;

  @GET('discover/movie')
  Future<MovieListDto> getMovies({
    @Query('page') int? page,
    @Query('include_adult') bool? includeAdult,
    @Query('include_video') bool? includeVideo,
    @Query('sort_by') String? sortBy,
  });

  @GET('movie/upcoming')
  Future<MovieListDto> getUpcomingMovies({
    @Query('page') int? page,
  });

  @GET('movie/{id}')
  Future<MovieDto> getMovieDetail({
    @Query('id') int? id,
  });
}
