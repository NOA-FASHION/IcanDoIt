import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyAcces = "challengeList";

class Challengecontroller {
  List<ChallengeModel> _challengeList = [];
  List<Challengemodel2> _challengeList2 = [];
  SharedPreferences _localData;

  Future<List<ChallengeModel>> initChallengeList() async {
    _localData = await SharedPreferences.getInstance();
    final List<String> _tempList = _localData.getStringList(keyAcces);
    if (_tempList != null) {
      final List<Map<String, dynamic>> _jsonDecodeList = _tempList
          .map((challengeEncoded) => jsonDecode(challengeEncoded))
          .toList()
          .cast<Map<String, dynamic>>();

      _challengeList = _jsonDecodeList
          .map((challenge) => ChallengeModel.fromJSON(challenge))
          .toList();
    }
    return _challengeList;
  }

  choixDesciptionEnum(dynamic json) {
    unity_challenge1 unity;
    if (json == "evenement") {
      unity = unity_challenge1.evenement;
    } else if (json == "achat") {
      unity = unity_challenge1.achat;
    } else if (json == "tache") {
      unity = unity_challenge1.tache;
    } else if (json == "mission") {
      unity = unity_challenge1.mission;
    } else if (json == "vente") {
      unity = unity_challenge1.vente;
    } else if (json == "choix") {
      unity = unity_challenge1.choix;
    } else if (json == "essai") {
      unity = unity_challenge1.essai;
    } else if (json == "validation") {
      unity = unity_challenge1.validation;
    } else if (json == "url") {
      unity = unity_challenge1.url;
    }
    return unity;
  }

  Future<List<Challengemodel2>> addChallenge2({
    @required String name,
    @required String tache,
    @required String description,
  }) async {
    _challengeList2.add(Challengemodel2(
        name: name,
        tache: tache,
        description: choixDesciptionEnum(description)));

    await _save();

    return _challengeList2;
  }

  Future<List<ChallengeModel>> addChallenge1({
    @required String name,
    @required List<Challengemodel2> challengeListTest,
  }) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == name) {
        for (var i = challengeListTest.length - 1; i >= 0; i--) {
          _challengeList[i].listeDeTache.add(
                Challengemodel2(
                    name: challengeListTest[i].name,
                    tache: challengeListTest[i].tache,
                    description: challengeListTest[i].description),
              );
        }
      }
    }

    await _save();

    return _challengeList;
  }

  Future<List<ChallengeModel>> addChallenge(
      {@required String name,
      @required String description,
      @required String unity}) async {
    _challengeList.add(
      ChallengeModel(
          name: name,
          description: description,
          unity: unity == "haute"
              ? unity_challenge.haute
              : unity_challenge.normal),
    );
    await _save();

    return _challengeList;
  }

  Future<bool> _save({bool remove}) async {
    if (_challengeList.length < 1 && remove ?? false) {
      return _localData.setStringList(keyAcces, []);
    }
    if (_challengeList.isNotEmpty) {
      List<String> _jsonList = _challengeList.map((challenge) {
        return jsonEncode(challenge.toJson());
      }).toList();
      return _localData.setStringList(keyAcces, _jsonList);
    }
    return false;
  }

  void remove({@required int index}) async {
    _challengeList.removeAt(index);
    await _save(remove: true);
  }
}
