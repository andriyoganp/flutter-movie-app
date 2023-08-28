import 'package:dartz/dartz.dart';

import '../../core/interactor/use_case.dart';
import '../../core/model/failure.dart';
import '../../data/repository/movie_repository.dart';
import '../params/params_movie_detail.dart';

class DeleteFromFavoriteUseCase extends UseCase<bool, ParamsMovieDetail> {
  DeleteFromFavoriteUseCase(this._repository);

  final MovieRepository _repository;

  @override
  Future<Either<Failure, bool>> call(ParamsMovieDetail params) =>
      _repository.deleteFromFavorite(params);
}
