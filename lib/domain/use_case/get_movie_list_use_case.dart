import 'package:dartz/dartz.dart';

import '../../core/interactor/use_case.dart';
import '../../core/model/failure.dart';
import '../../data/repository/movie_repository.dart';
import '../model/movie.dart';
import '../params/params_movie_list.dart';

class GetMovieListUseCase extends UseCase<List<Movie>, ParamsMovieList> {
  GetMovieListUseCase(this._repository);

  final MovieRepository _repository;

  @override
  Future<Either<Failure, List<Movie>>> call(ParamsMovieList params) {
    return params.isUpcoming
        ? _repository.getMovies(params)
        : _repository.getUpcomingMovies(params);
  }
}
