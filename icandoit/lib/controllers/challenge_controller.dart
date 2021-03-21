import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';

const String keyAcces = "challengeList";
const String keyAccesSAve = "challengeListSAve";
const String keyAccesChallengeDay = "challengeDay";
const String keyAccesChallengeYesterday = "ChallengeyesterDay";

class Challengecontroller extends ChangeNotifier {
  List<ChallengeModel> _challengeList = [];
  List<Challengemodel2> _challengeList2 = [];
  List<Challengemodel2> _challengeList3 = [];
  List<ChallengeModel> _challengeListSave = [];
  SharedPreferences _localData;
  SharedPreferences _localDataSave;
  SharedPreferences _localDataChallengeDay;
  SharedPreferences _localDataChallengeyesterday;
  ChallengeDays challengeDays;
  Challengeyesterday challengeyesterday;
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
      // _challengeListSave
      //     .sort((a, b) => a.unity.toString().compareTo(b.unity.toString()));
    }
    _localDataChallengeDay = await SharedPreferences.getInstance();
    // List<Map<String, dynamic>> tempListMap = [];
    Map _jsonDecodeListChallenge;
    final String _tempListChallenge =
        _localDataChallengeDay.getString(keyAccesChallengeDay);
    if (_tempListChallenge != null) {
      _jsonDecodeListChallenge = jsonDecode(_tempListChallenge);
      challengeDays = ChallengeDays.fromJSON(_jsonDecodeListChallenge);
    }
    _localDataChallengeyesterday = await SharedPreferences.getInstance();
    // List<Map<String, dynamic>> tempListMap = [];
    Map _jsonDecodeListchallengeyesterday;
    final String _tempListchallengeyesterday =
        _localDataChallengeyesterday.getString(keyAccesChallengeYesterday);
    if (_tempListchallengeyesterday != null) {
      _jsonDecodeListchallengeyesterday =
          jsonDecode(_tempListchallengeyesterday);
      challengeyesterday =
          Challengeyesterday.fromJSON(_jsonDecodeListchallengeyesterday);
    }
    startChallendays();
    startChallenyesterday();
    addChallengeyesterday();
    initChallendays();

    notifyListeners();
  }

  void addChallengeyesterday() async {
    DateTime today = new DateTime.now();
    if (challengeyesterday.date != today.toString()) {
      challengeyesterday.date = today.toString();
      challengeyesterday.nbChallengeEnCours = challengeDays.nbChallengeEnCours;
      challengeyesterday.nbTacheEnCours = challengeDays.nbTacheEnCours;
      challengeyesterday.commentaire = challengeDays.commentaire;
      challengeyesterday.nbchallengeVallide = challengeDays.nbchallengeVallide;
      challengeyesterday.nbtacheVallide = challengeDays.nbtacheVallide;
    }
    await _saveChallenyesterday();
    _initChallengeList();
    notifyListeners();
  }

  void startChallendays() async {
    DateTime today = new DateTime.now();
    if (challengeyesterday == null) {
      challengeyesterday.date = today.toString();
      challengeyesterday.nbChallengeEnCours = "0";
      challengeyesterday.nbTacheEnCours = "0";
      challengeyesterday.commentaire = "";
      challengeyesterday.nbchallengeVallide = "0";
      challengeyesterday.nbtacheVallide = "0";
    }
    await _saveChallendays();
    _initChallengeList();
    notifyListeners();
  }

  void startChallenyesterday() async {
    DateTime today = new DateTime.now();
    if (challengeyesterday == null) {
      challengeyesterday.date = today.toString();
      challengeyesterday.nbChallengeEnCours = "0";
      challengeyesterday.nbTacheEnCours = "0";
      challengeyesterday.commentaire = "";
      challengeyesterday.nbchallengeVallide = "0";
      challengeyesterday.nbtacheVallide = "0";
    }
    await _saveChallenyesterday();
    _initChallengeList();
    notifyListeners();
  }

  void initChallendays() async {
    DateTime today = new DateTime.now();
    if (challengeDays.date != today.toString()) {
      challengeDays.date = today.toString();
      challengeDays.nbtacheVallide = "0";
      challengeDays.nbchallengeVallide = "0";
      challengeDays.commentaire = "";
    }
    await _saveChallendays();
    _initChallengeList();
    notifyListeners();
  }

  void addCommentaireChallengeDay() async {
    var nbtacheVallide1 = int.parse(challengeDays.nbtacheVallide) +
        int.parse(challengeDays.nbchallengeVallide);
    if (nbtacheVallide1 == 0) {
      challengeDays.commentaire =
          "Vous n'avez pas valide de challenge ou de tache";
    } else if (nbtacheVallide1 > 3) {
      challengeDays.commentaire =
          "pas mal, encore un effort et vous atteindrez vos objectifs";
    } else if (nbtacheVallide1 > 6) {
      challengeDays.commentaire = "Bravo, vos effort ont ete recompense";
    } else if (nbtacheVallide1 > 9) {
      challengeDays.commentaire = "extraordinaire, rien ne vous arretes.";
    }
  }

  void addnbtacheVallide() async {
    challengeDays.nbtacheVallide =
        (int.parse(challengeDays.nbtacheVallide) + 1).toString();
    addCommentaireChallengeDay();
    await _saveChallendays();
    _initChallengeList();
    notifyListeners();
  }

  void addnbChallengeVallide() async {
    challengeDays.nbchallengeVallide =
        (int.parse(challengeDays.nbchallengeVallide) + 1).toString();
    addCommentaireChallengeDay();
    await _saveChallendays();
    _initChallengeList();
    notifyListeners();
  }

  Future<bool> _saveChallenyesterday() async {
    if (challengeyesterday != null) {
      Map mapyesterday = challengeyesterday.toJson();
      String _jsonyesterday = jsonEncode(mapyesterday);
      return _localData.setString(keyAccesChallengeYesterday, _jsonyesterday);
    }

    return false;
  }

  Future<bool> _saveChallendays() async {
    challengeDays.nbChallengeEnCours = (_challengeList.length).toString();
    if (challengeDays != null) {
      Map mapday = challengeDays.toJson();
      String _jsonDay = jsonEncode(mapday);
      return _localData.setString(keyAccesChallengeDay, _jsonDay);
    }

    return false;
  }

  List<ChallengeModel> getChallenges2() {
    return _challengeListSave;
  }

  Challengeyesterday getChallengeyesterday() {
    return challengeyesterday;
  }

  ChallengeDays getChallengeDays() {
    return challengeDays;
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
    print('index save');
    print(indexSave);
    if (indexSave != null) {
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

          await _save();
          _initChallengeList();
          notifyListeners();
          return;
        }
      }
    }
  }

  void addListChallengeSave(String namechallenge) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      print('challengelistname');
      print(namechallenge);
      if (_challengeList[i].name == namechallenge) {
        _challengeListSave.add(
          ChallengeModel(
              listeDeTache: _challengeList[i].listeDeTache,
              name: _challengeList[i].name,
              description: _challengeList[i].description,
              totalChallenge: _challengeList[i].totalChallenge,
              unity: _challengeList[i].unity),
        );

        await _saveSauvegarde();
        _initChallengeList();
        notifyListeners();
        return;
      }
    }
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
    await _saveSauvegarde(remove: true);
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
