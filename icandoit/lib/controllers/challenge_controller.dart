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

  Future<List<Challengemodel2>> initChallengeList1(String something) async {
    List<Challengemodel2> _challengeList4 = [];
    List<Map<String, dynamic>> tempListMap = [];
    _localData = await SharedPreferences.getInstance();
    final List<String> _tempList = _localData.getStringList(keyAcces);
    print(_tempList);
    if (_tempList != null) {
      final List<Map<String, dynamic>> _jsonDecodeList = _tempList
          .map((challengeEncoded) => jsonDecode(challengeEncoded))
          .toList()
          .cast<Map<String, dynamic>>();
      for (var v in _jsonDecodeList) {
        if (v['name'] == something) {
          if (v['listeDeTache'] != null) {
            print(v['listeDeTache']);
            for (var i in (v['listeDeTache'])) {
              tempListMap.add({
                "name": i["name"],
                "tache": i["tache"],
                "description": i["description"],
              });
            }
          }
        }
      }
      if (tempListMap != null) {
        _challengeList4 = tempListMap
            .map((challenge) => Challengemodel2.fromJSON(challenge))
            .toList();
        print(_challengeList4);
      }
    }
    return _challengeList4;
  }

  unity_challenge1 choixDesciptionEnum(dynamic json) {
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
    @required String nameListChallenge,
    @required String name,
    @required String tache,
    @required String description,
  }) async {
    print(nameListChallenge);
    print(name);
    print(tache);
    print(description);
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      print(_challengeList[i]);
    }
    _challengeList2.add(Challengemodel2(
        name: name,
        tache: tache,
        description: choixDesciptionEnum(description)));

    addChallenge1(
        name: nameListChallenge,
        challengeListTest: _challengeList2,
        challengeList: _challengeList);
    await _save();
    return _challengeList2;
  }

  Future<List<ChallengeModel>> addChallenge1({
    @required String name,
    @required List<Challengemodel2> challengeListTest,
    List<ChallengeModel> challengeList,
  }) async {
    _challengeList = challengeList;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == name) {
        for (var n = challengeListTest.length - 1; n >= 0; n--) {
          _challengeList[i].listeDeTache.add(
                Challengemodel2(
                    name: challengeListTest[n].name,
                    tache: challengeListTest[n].tache,
                    description: challengeListTest[n].description),
              );
        }
      }
    }

    return _challengeList;
  }

  Future<List<ChallengeModel>> addChallenge(
      {@required String name,
      @required String description,
      @required String unity,
      @required List<Challengemodel2> challengeListTache}) async {
    _challengeList.add(
      ChallengeModel(
          name: name,
          description: description,
          unity: unity == "haute"
              ? unity_challenge.haute
              : unity_challenge.normal),
    );
    await _save1();

    return _challengeList;
  }

  Future<bool> _save1({bool remove}) async {
    if (_challengeList.length < 1 && remove ?? false) {
      return _localData.setStringList(keyAcces, []);
    }
    if (_challengeList.isNotEmpty) {
      List<String> _jsonList = _challengeList.map((challenge) {
        return jsonEncode(challenge.toJson1());
      }).toList();
      return _localData.setStringList(keyAcces, _jsonList);
    }
    return false;
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

  void remove2({@required int index, @required String nameChallenge}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == nameChallenge) {
        _challengeList[i].listeDeTache.removeAt(index);
      }
    }
    await _save(remove: true);
  }

  // List<ChallengeModel> removesuper(
  //     Future<List<ChallengeModel>> challengeListSuper) {
  //   List<ChallengeModel> _listProducts;
  //   challengeListSuper.then((value) {
  //     if (value != null) value.forEach((item) => _listProducts.add(item));
  //   });
  //   return _listProducts;
  // }

}
