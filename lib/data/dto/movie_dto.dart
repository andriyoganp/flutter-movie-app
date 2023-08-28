import 'package:json_annotation/json_annotation.dart';

import '../../core/extension/int_ext.dart';
import '../../core/extension/iterable_ext.dart';
import '../../core/extension/string_ext.dart';
import '../../domain/model/movie.dart';
import 'genre_dto.dart';

part 'movie_dto.g.dart';

@JsonSerializable()
class MovieDto {
  MovieDto({
    this.backdropPath,
    this.genres,
    this.id,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.runtime,
    this.title,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final List<GenreDto>? genres;
  final int? id;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final int? runtime;
  final String? title;

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);

  Movie get asModel => Movie(
        id: id.orZero,
        backdropPath: backdropPath.orEmpty,
        title: title.orEmpty,
        genreNames: genres.orEmpty
            .map((GenreDto genreDto) => genreDto.name.orEmpty)
            .toList(),
        overview: overview.orEmpty,
        posterPath: posterPath.orEmpty,
        releaseDate: releaseDate.orEmpty,
        runtime: runtime.orZero,
      );
}
