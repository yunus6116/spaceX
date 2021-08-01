// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinksModel _$LinksModelFromJson(Map<String, dynamic> json) {
  return LinksModel(
    patch: PatchModel.fromJson(json['patch'] as Map<String, dynamic>),
    webcast: json['webcast'] as String,
  );
}

Map<String, dynamic> _$LinksModelToJson(LinksModel instance) =>
    <String, dynamic>{
      'webcast': instance.webcast,
      'patch': instance.patch,
    };
