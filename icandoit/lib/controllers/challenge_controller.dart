import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';

const String keyAcces = "challengeList";
const String keyAccesSAve = "challengeListSAve";

class Challengecontroller extends ChangeNotifier {
  List<ChallengeModel> _challengeList = [];
  List<Challengemodel2> _challengeList2 = [];
  List<Challengemodel2> _challengeList3 = [];
  List<ChallengeModel> _challengeListSave = [];
  SharedPreferences _localData;
  SharedPreferences _localDataSave;
  int indexSave;
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
    }
    _localDataSave = await SharedPreferences.getInstance();
    // List<Map<String, dynamic>> tempListMap = [];
    List<Map<String, dynamic>> _jsonDecodeListSave;
    final List<String> _tempListSave =
        _localDataSave.getStringList(keyAccesSAve);
    if (_tempListSave != null) {
      _jsonDecodeListSave = _tempListSave
          .map((challengeEncoded) => jsonDecode(challengeEncoded))
          .toList()
          .cast<Map<String, dynamic>>();

      _challengeListSave = _jsonDecodeListSave
          .map((challenge) => ChallengeModel.fromJSON(challenge))
          .toList();
      _challengeListSave
          .sort((a, b) => a.unity.toString().compareTo(b.unity.toString()));
    }
    notifyListeners();
  }

  List<ChallengeModel> getChallenges2() {
    return _challengeListSave;
  }

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

  int getChallengesindex() {
    return indexSave;
  }

  List<int> indexSaveFunction(bool selected, int index) {
    if (selected) {
      indexSave = index;
    }
  }

  void addSlectSave() async {
    if (indexSave != 0) {
      for (var i = _challengeListSave.length - 1; i >= 0; i--) {
        if (i == indexSave) {
          _challengeList.add(
            ChallengeModel(
                listeDeTache: _challengeListSave[i].listeDeTache,
                name: _challengeListSave[i].name,
                description: _challengeListSave[i].description,
                totalChallenge: _challengeListSave[i].totalChallenge,
                unity: _challengeListSave[i].unity),
          );
          for (var j = _challengeListSave[i].listeDeTache.length - 1;
              j >= 0;
              j--) {
            for (var n = _challengeList.length - 1; n >= 0; n--) {
              if (_challengeList[n].name == _challengeListSave[i].name) {
                _challengeList[n].listeDeTache.add(
                      Challengemodel2(
                          name: _challengeListSave[i].listeDeTache[j].name,
                          tache: _challengeListSave[i].listeDeTache[j].tache,
                          description: _challengeListSave[i]
                              .listeDeTache[j]
                              .description),
                    );
              }
            }
          }
        }
      }
      await _save();
      _initChallengeList();
      notifyListeners();
    }
  }

  void addListChallengeSave(String namechallenge) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == namechallenge) {
        _challengeListSave.add(
          ChallengeModel(
              listeDeTache: _challengeList[i].listeDeTache,
              name: _challengeList[i].name,
              description: _challengeList[i].description,
              totalChallenge: _challengeList[i].totalChallenge,
              unity: _challengeList[i].unity),
        );
        for (var j = _challengeList[i].listeDeTache.length - 1; j >= 0; j--) {
          for (var n = _challengeList.length - 1; n >= 0; n--) {
            if (_challengeList[n].name == _challengeListSave[i].name) {
              _challengeListSave[n].listeDeTache.add(
                    Challengemodel2(
                        name: _challengeList[i].listeDeTache[j].name,
                        tache: _challengeList[i].listeDeTache[j].tache,
                        description:
                            _challengeList[i].listeDeTache[j].description),
                  );
            }
          }
        }
      }
    }
    await _saveSauvegarde();
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

  Future<bool> _saveSauvegarde({bool remove}) async {
    if (_challengeListSave.length < 1 && remove ?? false) {
      return _localData.setStringList(keyAccesSAve, []);
    }
    if (_challengeListSave.isNotEmpty) {
      List<String> _jsonList = _challengeListSave.map((challenge) {
        return jsonEncode(challenge.toJson());
      }).toList();
      return _localData.setStringList(keyAccesSAve, _jsonList);
    }

    return false;
  }

  void removeSave({@required int index}) async {
    _challengeListSave.removeAt(index);
    await _save(remove: true);
    _initChallengeList();
    notifyListeners();
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
