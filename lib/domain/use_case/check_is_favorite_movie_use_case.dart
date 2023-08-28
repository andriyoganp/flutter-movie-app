import '../../core/interactor/use_case.dart';
import '../../data/repository/movie_repository.dart';
import '../params/params_movie_detail.dart';

class CheckIsFavoriteMovieUseCase
    extends UseCaseStream<bool, ParamsMovieDetail> {
  CheckIsFavoriteMovieUseCase(this._repository);

  final MovieRepository _repository;

  @override
  Stream<bool> call(ParamsMovieDetail params) =>
      _repository.checkIsFavorite(params);
}
