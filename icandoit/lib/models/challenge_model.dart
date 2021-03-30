import 'package:flutter/foundation.dart';

enum unity_challenge { haute, normal }
enum unity_challenge1 {
  evenement,
  achat,
  tache,
  mission,
  youtube,
  video,
  commentaire,
  image,
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
  } else if (json['description'] == "unity_challenge1.youtube") {
    unity = unity_challenge1.youtube;
  } else if (json['description'] == "unity_challenge1.video") {
    unity = unity_challenge1.video;
  } else if (json['description'] == "unity_challenge1.commentaire") {
    unity = unity_challenge1.commentaire;
  } else if (json['description'] == "unity_challenge1.image") {
    unity = unity_challenge1.image;
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
}

class ChallengeDays {
  String date;
  String nbTacheEnCours;
  String nbChallengeEnCours;
  String commentaire;
  String nbchallengeVallide;
  String nbtacheVallide;
  ChallengeDays(
      {this.date,
      this.nbChallengeEnCours,
      this.commentaire,
      this.nbchallengeVallide,
      this.nbTacheEnCours,
      this.nbtacheVallide});

  ChallengeDays.fromJSON(Map<String, dynamic> json)
      : date = json['date'],
        nbChallengeEnCours = json['nbChallengeEnCours'],
        nbchallengeVallide = json['nbchallengeVallide'],
        nbtacheVallide = json['nbtacheVallide'],
        nbTacheEnCours = json['nbTacheEnCours'],
        commentaire = json['commentaire'];

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "nbchallengeVallide": nbchallengeVallide,
      "nbtacheVallide": nbtacheVallide,
      "nbTacheEnCours": nbTacheEnCours,
      "nbChallengeEnCours": nbChallengeEnCours,
      "commentaire": commentaire
    };
  }
}

class Challengeyesterday {
  String date;
  String nbChallengeEnCours;
  String nbTacheEnCours;
  String commentaire;
  String nbchallengeVallide;
  String nbtacheVallide;

  Challengeyesterday(
      {this.date,
      this.nbChallengeEnCours,
      this.commentaire,
      this.nbchallengeVallide,
      this.nbTacheEnCours,
      this.nbtacheVallide});

  Challengeyesterday.fromJSON(Map<String, dynamic> json)
      : date = json['date'],
        nbChallengeEnCours = json['nbChallengeEnCours'],
        nbTacheEnCours = json['nbTacheEnCours'],
        nbchallengeVallide = json['nbchallengeVallide'],
        nbtacheVallide = json['nbtacheVallide'],
        commentaire = json['commentaire'];

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "nbchallengeVallide": nbchallengeVallide,
      "nbTacheEnCours": nbTacheEnCours,
      "nbtacheVallide": nbtacheVallide,
      "nbChallengeEnCours": nbChallengeEnCours,
      "commentaire": commentaire
    };
  }
}
