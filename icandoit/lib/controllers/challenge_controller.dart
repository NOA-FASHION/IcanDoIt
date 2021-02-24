import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyAcces = "challengeList";

class Challengecontroller {
  List<ChallengeModel> _challengeList = [];
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
    if (remove ?? false) {
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
