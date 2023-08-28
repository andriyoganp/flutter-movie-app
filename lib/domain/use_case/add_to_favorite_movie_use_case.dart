import 'package:dartz/dartz.dart';

import '../../core/interactor/use_case.dart';
import '../../core/model/failure.dart';
import '../../data/repository/movie_repository.dart';
import '../params/params_favorite_movie.dart';

class AddToFavoriteMovieUseCase extends UseCase<bool, ParamsFavoriteMovie> {
  AddToFavoriteMovieUseCase(this._repository);

  final MovieRepository _repository;

  @override
  Future<Either<Failure, bool>> call(ParamsFavoriteMovie params) =>
      _repository.addToFavorite(params);
}
