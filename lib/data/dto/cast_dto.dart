import 'package:json_annotation/json_annotation.dart';

import '../../core/extension/int_ext.dart';
import '../../core/extension/string_ext.dart';
import '../../domain/model/cast.dart';

part 'cast_dto.g.dart';

@JsonSerializable()
class CastDto {
  CastDto({
    this.id,
    this.name,
    this.originalName,
    this.profilePath,
  });

  factory CastDto.fromJson(Map<String, dynamic> json) =>
      _$CastDtoFromJson(json);

  final int? id;
  final String? name;
  @JsonKey(name: 'original_name')
  final String? originalName;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  Map<String, dynamic> toJson() => _$CastDtoToJson(this);

  Cast get asModel => Cast(
        id: id.orZero,
        name: name.orEmpty,
        profilePath: profilePath.orEmpty,
      );
}
