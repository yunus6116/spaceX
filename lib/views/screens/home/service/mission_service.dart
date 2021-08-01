import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:spacex/model/mission_model.dart';

const String url = "https://api.spacexdata.com/v4/launches/latest";

class MissionService {
  Future<MissionModel> fetchMission() async {
    Response response;
    response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var mission = MissionModel.fromJson(json);
      return mission;
    } else {
      throw Exception("Something gone wrong, ${response.statusCode}");
    }
  }
}
