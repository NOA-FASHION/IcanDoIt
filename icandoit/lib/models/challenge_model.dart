import 'package:flutter/foundation.dart';

enum unity_challenge { haute, normal }

class ChallengeModel {
  final String name;
  final String description;
  final unity_challenge unity;

  ChallengeModel(
      {@required this.name, @required this.description, @required this.unity});
  ChallengeModel.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        unity = json['unity'] == "unity_challenge.haute"
            ? unity_challenge.haute
            : unity_challenge.normal;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "unity": unity.toString()
    };
  }
}
