import '../../core/interactor/use_case.dart';
import '../../data/repository/movie_repository.dart';
import '../model/movie.dart';

class GetFavoriteMoviesUseCase extends UseCaseStream<List<Movie>, NoParams> {
  GetFavoriteMoviesUseCase(this._repository);

  final MovieRepository _repository;

  @override
  Stream<List<Movie>> call(NoParams params) => _repository.getFavoriteMovies();
}
