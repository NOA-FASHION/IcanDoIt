import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Challengecontroller {
  List<ChallengeModel> _challengeList = [];

  List<ChallengeModel> getChallenges() {
    return _challengeList;
  }

  Future<List<ChallengeModel>> addChallenge(
      {@required String name,
      @required String target,
      @required String unity}) async {
    _challengeList.add(
      ChallengeModel(
          name: name,
          target: int.parse(target),
          unity: unity == "KG" ? unity_challenge.kg : unity_challenge.km),
    );
    final bool resultat = await _save();
    if (resultat) {
      print("sa marche");
    } else {
      print("sa bug $resultat");
    }
    return getChallenges();
  }

  Future<bool> _save() async {
    SharedPreferences localData = await SharedPreferences.getInstance();
    if (_challengeList.isNotEmpty) {
      List<String> _jsonList = _challengeList.map((challenge) {
        jsonEncode(challenge.toJson());
      }).toList();
      return localData.setStringList("challengeList", _jsonList);
    }
    return false;
  }
}
