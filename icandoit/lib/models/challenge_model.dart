import 'package:flutter/foundation.dart';

enum unity_challenge { haute, normal }

class Challengemodel2 {
  final String name;
  final String tache;
  final String description;
  Challengemodel2(
      {@required this.name, @required this.tache, @required this.description});

  Challengemodel2.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        tache = json['tache'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {"name": name, "tache": tache, "description": description};
  }
}

class ChallengeModel {
  final String name;
  final String description;
  final unity_challenge unity;
  List<Challengemodel2> listeDeTache;

  ChallengeModel({this.name, this.description, this.unity, this.listeDeTache});

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
