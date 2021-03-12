import 'package:flutter/foundation.dart';

enum unity_challenge { haute, normal }
enum unity_challenge1 {
  evenement,
  achat,
  tache,
  mission,
  vente,
  choix,
  essai,
  validation,
  url
}
choixDesciptionEnum(dynamic json) {
  unity_challenge1 unity;
  if (json['description'] == "unity_challenge1.evenement") {
    unity = unity_challenge1.evenement;
  } else if (json['description'] == "unity_challenge1.achat") {
    unity = unity_challenge1.achat;
  } else if (json['description'] == "unity_challenge1.tache") {
    unity = unity_challenge1.tache;
  } else if (json['description'] == "unity_challenge1.mission") {
    unity = unity_challenge1.mission;
  } else if (json['description'] == "unity_challenge1.vente") {
    unity = unity_challenge1.vente;
  } else if (json['description'] == "unity_challenge1.choix") {
    unity = unity_challenge1.choix;
  } else if (json['description'] == "unity_challenge1.essai") {
    unity = unity_challenge1.essai;
  } else if (json['description'] == "unity_challenge1.validation") {
    unity = unity_challenge1.validation;
  } else if (json['description'] == "unity_challenge1.url") {
    unity = unity_challenge1.url;
  }
  return unity;
}

class Challengemodel2 {
  String index;
  final String name;
  final String tache;
  final unity_challenge1 description;
  Challengemodel2(
      {@required this.name,
      @required this.tache,
      @required this.description,
      this.index});

  Challengemodel2.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        tache = json['tache'],
        index = json['index'],
        description = choixDesciptionEnum(json);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "tache": tache,
      "index": index,
      "description": description.toString()
    };
  }
}

class ChallengeModel {
  final String name;
  final String description;
  final unity_challenge unity;
  List<Challengemodel2> listeDeTache;
  String totalChallenge;

  ChallengeModel({
    this.name,
    this.description,
    this.unity,
    this.listeDeTache,
    this.totalChallenge,
  });

  factory ChallengeModel.fromJSON(Map<String, dynamic> json) => ChallengeModel(
        name: json['name'],
        description: json['description'],
        totalChallenge: json['totalChallenge'],
        unity: json['unity'] == "unity_challenge.haute"
            ? unity_challenge.haute
            : unity_challenge.normal,
        listeDeTache: List<Challengemodel2>.from(json["listeDeTache"]
            .map((x) => Challengemodel2.fromJSON(x))
            .toList()),
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "totalChallenge": totalChallenge,
      "unity": unity.toString(),
      "listeDeTache": List<dynamic>.from(listeDeTache.map((x) => x.toJson())),
    };
  }

  // Map<String, dynamic> toJson1() {
  //   return {
  //     "name": name,
  //     "percent": percent,
  //     "description": description,
  //     "totalChallenge": totalChallenge,
  //     "unity": unity.toString(),
  //     "listeDeTache": [],

  //   };
  // }

  //  ChallengeModel.fromJSON(Map<String, dynamic> json)
  //     : name = json['name'],
  //       description = json['description'],
  //       unity = json['unity'] == "unity_challenge.haute"
  //           ? unity_challenge.haute
  //           : unity_challenge.normal;

  // Map<String, dynamic> toJson() {
  //   return {
  //     "name": name,
  //     "description": description,
  //     "unity": unity.toString()
  //   };
  // }
  // List<String> toJSON() {
  //   var listeDETACHE;
  //   if (this.listeDeTache.length < 1) {
  //     listeDETACHE = [];
  //   } else {
  //     listeDETACHE =
  //         List<Challengemodel2>.from(listeDeTache.map((x) => x.toJson()));
  //   }
  //   return listeDETACHE;
  // }
}
