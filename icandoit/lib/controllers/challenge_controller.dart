import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';

const String keyAcces = "challengeList";

class Challengecontroller extends ChangeNotifier {
  List<ChallengeModel> _challengeList = [];
  List<Challengemodel2> _challengeList2 = [];
  List<Challengemodel2> _challengeList3 = [];
  SharedPreferences _localData;
  String something = "";
  String percent = "0";
  Challengecontroller() {
    _initChallengeList();
  }

  void _initChallengeList() async {
    _localData = await SharedPreferences.getInstance();
    // List<Map<String, dynamic>> tempListMap = [];
    List<Map<String, dynamic>> _jsonDecodeList;
    final List<String> _tempList = _localData.getStringList(keyAcces);
    if (_tempList != null) {
      _jsonDecodeList = _tempList
          .map((challengeEncoded) => jsonDecode(challengeEncoded))
          .toList()
          .cast<Map<String, dynamic>>();

      _challengeList = _jsonDecodeList
          .map((challenge) => ChallengeModel.fromJSON(challenge))
          .toList();
      _challengeList
          .sort((a, b) => a.unity.toString().compareTo(b.unity.toString()));
      print("challengeList");
      print(something);
      // for (var v in _jsonDecodeList) {
      //   if (v['name'] == something) {
      //     if (v['listeDeTache'] != null) {
      //       for (var i in (v['listeDeTache'])) {
      //         tempListMap.add({
      //           "name": i["name"],
      //           "tache": i["tache"],
      //           "description": i["description"],
      //         });
      //       }
      //     }
      //   }
      // }
      // if (tempListMap != null) {
      //   _challengeList2 = tempListMap
      //       .map((challenge) => Challengemodel2.fromJSON(challenge))
      //       .toList();
      // }

    }
    notifyListeners();
  }

  // Future<List<Challengemodel2>> initChallengeList1(String something) async {
  //   List<Challengemodel2> _challengeList4 = [];
  //   List<Map<String, dynamic>> tempListMap = [];
  //   _localData = await SharedPreferences.getInstance();
  //   final List<String> _tempList = _localData.getStringList(keyAcces);

  //   if (_tempList != null) {
  //     final List<Map<String, dynamic>> _jsonDecodeList = _tempList
  //         .map((challengeEncoded) => jsonDecode(challengeEncoded))
  //         .toList()
  //         .cast<Map<String, dynamic>>();
  //     for (var v in _jsonDecodeList) {
  //       if (v['name'] == something) {
  //         if (v['listeDeTache'] != null) {
  //           for (var i in (v['listeDeTache'])) {
  //             tempListMap.add({
  //               "name": i["name"],
  //               "tache": i["tache"],
  //               "description": i["description"],
  //             });
  //           }
  //         }
  //       }
  //     }
  //     if (tempListMap != null) {
  //       _challengeList4 = tempListMap
  //           .map((challenge) => Challengemodel2.fromJSON(challenge))
  //           .toList();
  //     }
  //   }
  //   return _challengeList4;
  // }

  List<ChallengeModel> getChallenges() {
    return _challengeList;
  }

  List<Challengemodel2> getChallenges1() {
    return UnmodifiableListView(_challengeList2);
  }

  double calulPercent(String name) {
    double resultat;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == name) {
        if (_challengeList[i].listeDeTache.length != null) {
          if (_challengeList[i].listeDeTache.length > 0 &&
              (_challengeList[i].listeDeTache.length ==
                  int.parse(_challengeList[i].totalChallenge))) {
            resultat = 0.00;
          } else if (_challengeList[i].listeDeTache.length != 0 &&
              (_challengeList[i].listeDeTache.length !=
                  int.parse(_challengeList[i].totalChallenge))) {
            resultat = (_challengeList[i].listeDeTache.length /
                int.parse(_challengeList[i].totalChallenge));
          } else {
            resultat = 0.00;
          }
        } else {
          resultat = 0.00;
        }
      }
      return resultat;
    }
  }

  List<Challengemodel2> challengelist2(String name) {
    List<Challengemodel2> additionchallenge = [];
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == name) {
        additionchallenge = _challengeList[i].listeDeTache;
        for (var n = _challengeList[i].listeDeTache.length - 1; n >= 0; n--) {
          _challengeList[i].listeDeTache[n].index = n.toString();
        }
      }
    }
    print("additionchallenge");
    print(additionchallenge);
    return additionchallenge;
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

  void addChallenge2({
    @required String totalChallenge,
    @required String nameListChallenge,
    @required String name,
    @required String tache,
    @required String description,
  }) async {
    // something = nameListChallenge;
    // for (var i = _challengeList.length - 1; i >= 0; i--) {}
    _challengeList3 = [];
    _challengeList3.add(Challengemodel2(
        name: name,
        tache: tache,
        description: choixDesciptionEnum(description)));

    addChallenge1(
      totalChallenge: totalChallenge,
      name: nameListChallenge,
      challengeListTest: _challengeList3,
    );
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void save() async {
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void addChallenge1({
    @required String totalChallenge,
    @required String name,
    @required List<Challengemodel2> challengeListTest,
  }) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == name) {
        var additionchallenge = _challengeList[i].totalChallenge;
        _challengeList[i].totalChallenge =
            (int.parse(additionchallenge) + 1).toString();

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
  }

  void addChallenge(
      {@required String name,
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
          unity: unity == "haute"
              ? unity_challenge.haute
              : unity_challenge.normal),
    );

    await _save();
    _initChallengeList();
    notifyListeners();
  }

  Future<bool> _save1({bool remove, String nameChallenge}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == nameChallenge) {
        if (_challengeList[i].listeDeTache.length < 1 && remove ?? false) {
          _challengeList[i].listeDeTache = [];
          List<String> _jsonList = _challengeList.map((challenge) {
            return jsonEncode(challenge.toJson());
          }).toList();
          return _localData.setStringList(keyAcces, _jsonList);
        }
      }
    }

    if (_challengeList.isNotEmpty) {
      List<String> _jsonList = _challengeList.map((challenge) {
        return jsonEncode(challenge.toJson());
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
    _initChallengeList();
    notifyListeners();
  }

  void remove2({@required int index, @required String nameChallenge}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == nameChallenge) {
        _challengeList[i].listeDeTache.removeAt(index);
      }
    }
    await _save1(remove: true, nameChallenge: nameChallenge);
    _initChallengeList();
    notifyListeners();
  }
}
