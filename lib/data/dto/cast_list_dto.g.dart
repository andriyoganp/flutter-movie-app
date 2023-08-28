// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastListDto _$CastListDtoFromJson(Map<String, dynamic> json) => CastListDto(
      id: json['id'] as int?,
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => CastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CastListDtoToJson(CastListDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
    };
