import 'package:json_annotation/json_annotation.dart';

import 'movie_dto.dart';

part 'movie_list_dto.g.dart';

@JsonSerializable()
class MovieListDto {
  MovieListDto({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieListDto.fromJson(Map<String, dynamic> json) =>
      _$MovieListDtoFromJson(json);

  final int? page;
  final List<MovieDto>? results;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'total_results')
  final int? totalResults;

  Map<String, dynamic> toJson() => _$MovieListDtoToJson(this);
}
