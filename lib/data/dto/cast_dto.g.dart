// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastDto _$CastDtoFromJson(Map<String, dynamic> json) => CastDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$CastDtoToJson(CastDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'profile_path': instance.profilePath,
    };
