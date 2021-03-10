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
    @required String totalChallenge,
    @required String nameListChallenge,
    @required String name,
    @required String tache,
    @required String description,
  }) async {
    Future<List<Challengemodel2>> addChallengeFinal;
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

    addChallengeFinal = addChallenge1(
        totalChallenge: totalChallenge,
        name: nameListChallenge,
        challengeListTest: _challengeList2,
        challengeList: _challengeList);
    await _save();
    _challengeList2 = [];
    return addChallengeFinal;
  }

  Future<List<Challengemodel2>> addChallenge1({
    @required String totalChallenge,
    @required String name,
    @required List<Challengemodel2> challengeListTest,
    List<ChallengeModel> challengeList,
  }) async {
    _challengeList = challengeList;
    List<Challengemodel2> challenliste2;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == name) {
        var additionchallenge = _challengeList[i].totalChallenge;
        _challengeList[i].totalChallenge =
            (int.parse(additionchallenge) + int.parse(totalChallenge))
                .toString();
        int additionCahllenge =
            (int.parse(additionchallenge) + int.parse(totalChallenge));
        int index = _challengeList[i].listeDeTache.length;
        if (index > 0) {
          if (index == additionCahllenge) {
            _challengeList[i].percent = "0";
          } else if (index != additionCahllenge)
            _challengeList[i].percent =
                ((index / additionCahllenge) * 100).toStringAsFixed(2);
        }

        challenliste2 = _challengeList[i].listeDeTache;
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

    return challenliste2;
  }

  String recupereTotalChallenge(String challenEnCours) {
    var challenge10;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == challenEnCours) {
        challenge10 = _challengeList[i].totalChallenge;
        print('toalchallenge2');
        print(challenge10);
      }
    }
    return challenge10;
  }

  int calculIndex(String name) {
    var calculindex;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == name) {
        calculindex = _challengeList[i].listeDeTache.length;
      }
    }
    return calculindex;
  }

  int calcuPercent(int index, int toalChallenge) {
    int percent;
    percent = ((index / toalChallenge) * 100) as int;
    return percent;
  }

  Future<List<ChallengeModel>> addChallenge(
      {@required String name,
      @required String percent,
      @required String totalChallenge,
      @required String description,
      @required String unity,
      @required List<Challengemodel2> challengeListTache}) async {
    _challengeList.add(
      ChallengeModel(
          listeDeTache: challengeListTache,
          name: name,
          description: description,
          totalChallenge: totalChallenge,
          percent: percent,
          unity: unity == "haute"
              ? unity_challenge.haute
              : unity_challenge.normal),
    );
    await _save();

    return _challengeList;
  }

  Future<bool> _save1({bool remove, String nameChallenge}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == nameChallenge) {
        if (_challengeList[i].listeDeTache.length < 1 && remove ?? false) {
          _challengeList[i].listeDeTache = [];
          return _localData.setStringList(keyAcces, []);
        }
      }
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
    await _save1(remove: true, nameChallenge: nameChallenge);
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
