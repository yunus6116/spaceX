// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionModel _$MissionModelFromJson(Map<String, dynamic> json) {
  return MissionModel(
    name: json['name'] as String,
    details: json['details'] as String,
    links: LinksModel.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MissionModelToJson(MissionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'details': instance.details,
      'links': instance.links.toJson(),
    };
