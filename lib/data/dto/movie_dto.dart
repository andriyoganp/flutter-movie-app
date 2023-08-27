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
    this.adult,
    this.backdropPath,
    this.genres,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.runtime,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final List<GenreDto>? genres;
  final int? id;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final int? runtime;
  final String? title;
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);

  Movie get asModel => Movie(
        id: id.orZero,
        title: title.orEmpty,
        genreNames: genres.orEmpty
            .map((GenreDto genreDto) => genreDto.name.orEmpty)
            .toList(),
        overview: overview.orEmpty,
        posterPath: posterPath.orEmpty,
        runtime: runtime.orZero,
      );
}
