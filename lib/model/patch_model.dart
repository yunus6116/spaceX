import 'package:json_annotation/json_annotation.dart';

part 'patch_model.g.dart';

@JsonSerializable()
class PatchModel {
  final String small;
  final String large;

  PatchModel({
    required this.small,
    required this.large,
  });
  @override
  String toString() => "$small $large";
  factory PatchModel.fromJson(Map<String, dynamic> json) =>
      _$PatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatchModelToJson(this);
}
