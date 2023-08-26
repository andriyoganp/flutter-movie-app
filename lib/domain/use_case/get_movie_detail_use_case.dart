import 'package:dartz/dartz.dart';

import '../../core/interactor/use_case.dart';
import '../../core/model/failure.dart';
import '../../data/repository/movie_repository.dart';
import '../model/movie.dart';
import '../params/params_movie_detail.dart';

class GetMovieDetailUseCase extends UseCase<Movie, ParamsMovieDetail> {
  GetMovieDetailUseCase(this._repository);

  final MovieRepository _repository;

  @override
  Future<Either<Failure, Movie>> call(ParamsMovieDetail params) =>
      _repository.getMovieDetail(params);
}
