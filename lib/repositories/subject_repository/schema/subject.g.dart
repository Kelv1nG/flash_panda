// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SubjectCreateDTO _$SubjectCreateDTOFromJson(Map<String, dynamic> json) =>
    SubjectCreateDTO(
      json['name'] as String,
    );

Map<String, dynamic> _$SubjectCreateDTOToJson(SubjectCreateDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

SubjectUpdateDTO _$SubjectUpdateDTOFromJson(Map<String, dynamic> json) =>
    SubjectUpdateDTO(
      json['name'] as String,
    );

Map<String, dynamic> _$SubjectUpdateDTOToJson(SubjectUpdateDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
