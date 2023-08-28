import 'package:json_annotation/json_annotation.dart';

import 'cast_dto.dart';

part 'cast_list_dto.g.dart';

@JsonSerializable()
class CastListDto {
  CastListDto({
    this.id,
    this.cast,
  });

  factory CastListDto.fromJson(Map<String, dynamic> json) =>
      _$CastListDtoFromJson(json);

  final int? id;
  final List<CastDto>? cast;

  Map<String, dynamic> toJson() => _$CastListDtoToJson(this);
}
