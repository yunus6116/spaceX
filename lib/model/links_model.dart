import 'package:json_annotation/json_annotation.dart';
import 'package:spacex/model/patch_model.dart';

part 'links_model.g.dart';

@JsonSerializable()
class LinksModel {
  final String webcast;
  final PatchModel patch;

  LinksModel({
    required this.patch,
    required this.webcast,
  });
  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinksModelToJson(this);
}
