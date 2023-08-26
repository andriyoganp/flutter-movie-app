import 'package:json_annotation/json_annotation.dart';

part 'genre_dto.g.dart';

@JsonSerializable()
class GenreDto {
  GenreDto({this.id, this.name});

  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      _$GenreDtoFromJson(json);

  final int? id;
  final String? name;

  Map<String, dynamic> toJson() => _$GenreDtoToJson(this);
}
