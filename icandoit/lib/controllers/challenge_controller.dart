import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyAcces = "challengeList";

class Challengecontroller {
  List<ChallengeModel> _challengeList = [];
  SharedPreferences _localData;

  List<ChallengeModel> getChallenges() {
    return _challengeList;
  }

  Future<List<ChallengeModel>> initChallengeList() async {
    _localData = await SharedPreferences.getInstance();
    final List<String> _tempList = _localData.getStringList(keyAcces);
    if (_tempList.isNotEmpty) {
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
    if (_challengeList.isNotEmpty) {
      List<String> _jsonList = _challengeList.map((challenge) {
        return jsonEncode(challenge.toJson());
      }).toList();
      return _localData.setStringList(keyAcces, _jsonList);
    }
    return false;
  }
}
