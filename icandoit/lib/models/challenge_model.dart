import 'package:flutter/foundation.dart';

enum unity_cahllenge { kg, km }

class ChallengeModel {
  final String name;
  final int target;
  final unity_cahllenge unity;

  ChallengeModel(
      {@required this.name, @required this.target, @required this.unity});
  ChallengeModel.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        target = json['target'],
        unity = json['unity'];

  Map<String, dynamic> toJson() {
    return {"name": name, "target": target, "unity": unity.toString()};
  }
}
