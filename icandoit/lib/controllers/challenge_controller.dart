import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';

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
  }
}
