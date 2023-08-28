import 'package:dartz/dartz.dart';

import '../../core/interactor/use_case.dart';
import '../../core/model/failure.dart';
import '../../data/repository/movie_repository.dart';
import '../model/cast.dart';
import '../params/params_movie_detail.dart';

class GetCastListUseCase extends UseCase<List<Cast>, ParamsMovieDetail> {
  GetCastListUseCase(this._repository);

  final MovieRepository _repository;

  @override
  Future<Either<Failure, List<Cast>>> call(ParamsMovieDetail params) =>
      _repository.getCastMovie(params);
}
