import 'package:json_annotation/json_annotation.dart';
import 'package:spacex/model/links_model.dart';

part 'mission_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MissionModel {
  final String name;
  final String details;
  final LinksModel links;

  const MissionModel({
    required this.name,
    required this.details,
    required this.links,
  });
  @override
  String toString() => "$name $details";

  factory MissionModel.fromJson(Map<String, dynamic> json) =>
      _$MissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MissionModelToJson(this);
}

// {
//     "links": {
//         "patch": {
//             "small": "https://imgur.com/IJWn9pK.png",
//             "large": "https://imgur.com/u49XVx4.png"
//         },
//         "webcast": "https://youtu.be/sSiuW1HcGjA"
//     },
//     "rocket": "5e9d0d95eda69973a809d1ec",
//     "success": true,
//     "details": "Falcon 9 launches to sun-synchronous polar orbit from Florida as part of SpaceX's Rideshare program dedicated to smallsat customers. The mission lifts off from SLC-40, Cape Canaveral on a southward azimuth and performs a dogleg maneuver. The booster for this mission is expected to return to LZ-1 based on FCC communications filings. This rideshare takes approximately 90 satellites and hosted payloads into orbit on a variety of deployers including three free-flying spacecraft which dispense their customers' satellites after separation from the SpaceX stack.",
//     "flight_number": 132,
//     "name": "Transporter-2",
//     "id": "600f9b6d8f798e2a4d5f979f"
// }