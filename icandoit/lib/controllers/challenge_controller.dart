import 'package:flutter/foundation.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share/share.dart';

const String keyAcces = "challengeList";
const String keyAccesSAve = "challengeListSAve";
const String keyAccesChallengeDay = "challengeDay";
const String keyAccesChallengeYesterday = "ChallengeyesterDay";

class Challengecontroller extends ChangeNotifier {
  String unityPattern = "unity_challenge.";
  List<ChallengeModel> _challengeList = [];
  List<Challengemodel2> _challengeList2 = [];
  List<Challengemodel2> _challengeList3 = [];
  List<ChallengeModel> _challengeListSave = [];
  SharedPreferences _localData;
  SharedPreferences _localDataSave;
  SharedPreferences _localDataChallengeDay;
  SharedPreferences _localDataChallengeyesterday;
  ChallengeDays challengeDays = ChallengeDays();
  Challengeyesterday challengeyesterday = Challengeyesterday();
  int indexSave;
  String something = "";
  String percent = "0";
  String data;
  String _jsonChallengeList;
  String patchData;
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
    }

    _initChallengeListStartChallenge();

    notifyListeners();
  }

  String translateDays(String days) {
    String daysFinal = "";
    if (days == "Lundi") {
      daysFinal = "Monday";
    } else if (days == "Mardi") {
      daysFinal = "Tueday";
    } else if (days == "Mercredi") {
      daysFinal = "Wednesday";
    } else if (days == "jeudi") {
      daysFinal = "Thursday";
    } else if (days == "Vendredi") {
      daysFinal = "Friday";
    } else if (days == "Samedi") {
      daysFinal = "Saturday";
    } else if (days == "Dimanche") {
      daysFinal = "Sunday";
    }
    return daysFinal;
  }

  void mensuelSave() {
    print("mensuelsave");
    DateTime today = new DateTime.now();
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].date.isNotEmpty) {
        if (_challengeListSave[i].date == DateFormat('d').format(today)) {
          challegListSaveShedule(i);
        }
      }
    }
  }

  void removeMensuel() {
    print("removesuelsave");
    DateTime today = new DateTime.now();
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].date.isNotEmpty) {
        if (_challengeList[i].date == DateFormat('d').format(today)) {
          remove(index: i, validate: true);
        }
      }
    }
  }

  void hebdoSave() {
    print("hebdosave");
    DateTime today = new DateTime.now();
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].totalDays.isNotEmpty) {
        for (var n = _challengeListSave[i].totalDays.length - 1; n >= 0; n--) {
          if (_challengeListSave[i].totalDays[n] ==
              translateDays(DateFormat('EEEE').format(today))) {
            challegListSaveShedule(i);
          }
        }
      }
    }
  }

  void removeHebdo() {
    print("removehebdosave");
    DateTime today = new DateTime.now();
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].totalDays.isNotEmpty) {
        for (var n = _challengeList[i].totalDays.length - 1; n >= 0; n--) {
          if (_challengeList[i].totalDays[n] ==
              translateDays(DateFormat('EEEE').format(today))) {
            remove(index: i, validate: true);
          }
        }
      }
    }
  }

  void removeQuotidientSave() async {
    print("quotidiensave");
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].quotidient == true) {
        remove(index: i, validate: true);
      }
    }
  }

  void initialiseQuotidient() async {
    print("removequotidien");
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].quotidient == true) {
        challegListSaveShedule(i);
      }
    }
  }

  void challegListSaveShedule(int index) async {
    _challengeList.add(
      ChallengeModel(
          notifiaction: _challengeListSave[index].notification,
          date: _challengeListSave[index].date,
          quotidient: _challengeListSave[index].quotidient,
          animatedpadding: _challengeListSave[index].animatedpadding,
          totalDays: _challengeListSave[index].totalDays,
          listeDeTache: _challengeListSave[index].listeDeTache,
          name: _challengeListSave[index].name,
          description: _challengeListSave[index].description,
          totalChallenge: _challengeListSave[index].totalChallenge,
          unity: _challengeListSave[index].unity),
    );

    await _save();
    _initChallengeList();
    notifyListeners();
    return;
  }

  void _initChallengeListStartChallenge() async {
    _localDataChallengeDay = await SharedPreferences.getInstance();
    Map _jsonDecodeListChallenge;
    final String _tempListChallenge =
        _localDataChallengeDay.getString(keyAccesChallengeDay);
    if (_tempListChallenge != null) {
      _jsonDecodeListChallenge = jsonDecode(_tempListChallenge);
      challengeDays = ChallengeDays.fromJSON(_jsonDecodeListChallenge);
    }
    challengeDays.nbChallengeEnCours = (_challengeList.length).toString();

    _localDataChallengeyesterday = await SharedPreferences.getInstance();
    Map _jsonDecodeListchallengeyesterday;
    final String _tempListchallengeyesterday =
        _localDataChallengeyesterday.getString(keyAccesChallengeYesterday);
    if (_tempListchallengeyesterday != null) {
      _jsonDecodeListchallengeyesterday =
          jsonDecode(_tempListchallengeyesterday);
      challengeyesterday =
          Challengeyesterday.fromJSON(_jsonDecodeListchallengeyesterday);
      // DateTime today = new DateTime.now();
      // print(DateFormat('EEEE, d MMM, yyyy').format(today));

      print(challengeyesterday.date);
      print(challengeyesterday.nbchallengeVallide);
    }
    startChallendays();
    startChallenyesterday();
    initChallengeyesterday();
    initChallendays();
    notifyListeners();
  }

  void startChallendays() async {
    DateTime today = new DateTime.now();
    if (challengeDays == null) {
      challengeDays.date = DateFormat('EEEE, d MMM, yyyy').format(today);
      challengeDays.nbChallengeEnCours = "0";
      challengeDays.nbTacheEnCours = "0";
      challengeDays.commentaire = "";
      challengeDays.nbchallengeVallide = "0";
      challengeDays.nbtacheVallide = "0";
      await _saveChallendays();
      _initChallengeListStartChallenge();

      notifyListeners();
    }
  }

  void startChallenyesterday() async {
    DateTime today = new DateTime.now();
    if (challengeyesterday == null) {
      challengeyesterday.date = DateFormat('EEEE, d MMM, yyyy').format(today);
      challengeyesterday.nbChallengeEnCours = "0";
      challengeyesterday.nbTacheEnCours = "0";
      challengeyesterday.commentaire = "";
      challengeyesterday.nbchallengeVallide = "0";
      challengeyesterday.nbtacheVallide = "0";
      await _saveChallenyesterday();
      _initChallengeListStartChallenge();

      notifyListeners();
    }
  }

  void initChallengeyesterday() async {
    DateTime today = new DateTime.now();
    if (challengeyesterday.date !=
        DateFormat('EEEE, d MMM, yyyy').format(today)) {
      // removeQuotidientSave();
      // initialiseQuotidient();
      // removeHebdo();
      // hebdoSave();
      // removeMensuel();
      // mensuelSave();
      challengeyesterday.date = DateFormat('EEEE, d MMM, yyyy').format(today);
      challengeyesterday.nbChallengeEnCours = challengeDays.nbChallengeEnCours;
      challengeyesterday.nbTacheEnCours = challengeDays.nbTacheEnCours;
      challengeyesterday.commentaire = challengeDays.commentaire;
      challengeyesterday.nbchallengeVallide = challengeDays.nbchallengeVallide;
      challengeyesterday.nbtacheVallide = challengeDays.nbtacheVallide;
      await _saveChallenyesterday();
      _initChallengeListStartChallenge();
      notifyListeners();
    }
  }

  void initChallendays() async {
    DateTime today = new DateTime.now();
    if (challengeDays.date != DateFormat('EEEE, d MMM, yyyy').format(today)) {
      removeQuotidientSave();
      initialiseQuotidient();
      removeHebdo();
      hebdoSave();
      removeMensuel();
      mensuelSave();
      challengeDays.date = DateFormat('EEEE, d MMM, yyyy').format(today);
      challengeDays.nbtacheVallide = "0";
      challengeDays.nbchallengeVallide = "0";
      challengeDays.commentaire = "";
      await _saveChallendays();
      _initChallengeListStartChallenge();
      notifyListeners();
    }
  }

  void addCommentaireChallengeDay() async {
    var nbtacheVallide1 = int.parse(challengeDays.nbtacheVallide) +
        int.parse(challengeDays.nbchallengeVallide);
    if (nbtacheVallide1 == 0) {
      challengeDays.commentaire =
          "Vous n'avez pas valide de challenge ou de tache";
    } else if (nbtacheVallide1 > 9) {
      challengeDays.commentaire = "extraordinaire, rien ne vous arretes.";
    } else if (nbtacheVallide1 > 6) {
      challengeDays.commentaire = "Bravo, vos effort ont ete recompense";
    } else if (nbtacheVallide1 > 0) {
      challengeDays.commentaire =
          " encore un effort et vos objectifs seront atteint";
    }
    await _saveChallendays();
    _initChallengeListStartChallenge();
    notifyListeners();
  }

  void addnbtacheVallide() async {
    challengeDays.nbtacheVallide =
        (int.parse(challengeDays.nbtacheVallide) + 1).toString();
    addCommentaireChallengeDay();
    await _saveChallendays();
    _initChallengeListStartChallenge();
    notifyListeners();
  }

  void addnbChallengeVallide() async {
    challengeDays.nbchallengeVallide =
        (int.parse(challengeDays.nbchallengeVallide) + 1).toString();
    addCommentaireChallengeDay();
    await _saveChallendays();
    _initChallengeListStartChallenge();
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
    // challengeDays.nbChallengeEnCours = (_challengeList.length).toString();
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
    } else if (json == "youtube") {
      unity = unity_challenge1.youtube;
    } else if (json == "video") {
      unity = unity_challenge1.video;
    } else if (json == "commentaire") {
      unity = unity_challenge1.commentaire;
    } else if (json == "image") {
      unity = unity_challenge1.image;
    } else if (json == "url") {
      unity = unity_challenge1.url;
    } else if (json == "formation") {
      unity = unity_challenge1.formation;
    } else if (json == "paiement") {
      unity = unity_challenge1.paiement;
    } else if (json == "projet") {
      unity = unity_challenge1.projet;
    }
    return unity;
  }

  unity_challenge choixDesciptionEnum1(dynamic json) {
    unity_challenge unity;
    if (json == "haute") {
      unity = unity_challenge.haute;
    } else if (json == "normal") {
      unity = unity_challenge.normal;
    } else if (json == "quotidien") {
      unity = unity_challenge.quotidien;
    } else if (json == "hebdomadaire") {
      unity = unity_challenge.hebdomadaire;
    } else if (json == "mensuel") {
      unity = unity_challenge.mensuel;
    } else if (json == "notification") {
      unity = unity_challenge.notification;
    }
    return unity;
  }

  void addChallenge2({
    @required bool animatedpadding,
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
    if (animatedpadding) {
      addChallengesave1(
        totalChallenge: totalChallenge,
        name: nameListChallenge,
        challengeListTest: _challengeList3,
      );
    }

    await _save();
    _initChallengeList();
    notifyListeners();
    // for (var i = _challengeList.length - 1; i >= 0; i--) {
    //   if (_challengeList[i].name == nameListChallenge &&
    //       _challengeList[i].animatedpadding == true) {
    //     addListChallengeSave(nameListChallenge);
    //     return;
    //   }
    // }
  }

  void save() async {
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void addChallengesave1({
    @required String totalChallenge,
    @required String name,
    @required List<Challengemodel2> challengeListTest,
  }) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].name == name) {
        // var additionchallenge = _challengeList[i].totalChallenge;
        // _challengeList[i].totalChallenge =
        //     (int.parse(additionchallenge) + 1).toString();

        for (var n = challengeListTest.length - 1; n >= 0; n--) {
          _challengeListSave[i].listeDeTache.add(
                Challengemodel2(
                    name: challengeListTest[n].name,
                    tache: challengeListTest[n].tache,
                    description: challengeListTest[n].description),
              );
        }
      }
    }
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
      @required String notifiaction,
      @required String date,
      @required bool quotidient,
      @required bool animatedpadding,
      @required List<String> totalDays,
      @required String totalChallenge,
      @required String description,
      @required String unity,
      @required List<Challengemodel2> challengeListTache}) async {
    _challengeList.add(
      ChallengeModel(
          notifiaction: notifiaction,
          date: date,
          quotidient: quotidient,
          animatedpadding: animatedpadding,
          totalDays: totalDays,
          listeDeTache: challengeListTache,
          name: name,
          description: description,
          totalChallenge: totalChallenge,
          unity: choixDesciptionEnum1(unity)),
    );
    if (animatedpadding == true) {
      addListChallengeSave(name);
    }

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
    // print('index save');
    // print(indexSave);
    if (indexSave != null) {
      for (var i = _challengeListSave.length - 1; i >= 0; i--) {
        if (i == indexSave) {
          _challengeList.add(
            ChallengeModel(
                notifiaction: _challengeListSave[i].notification,
                date: _challengeListSave[i].date,
                quotidient: _challengeListSave[i].quotidient,
                animatedpadding: _challengeListSave[i].animatedpadding,
                totalDays: _challengeListSave[i].totalDays,
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
    // for (var i = _challengeListSave.length - 1; i >= 0; i--) {
    //   if (_challengeListSave[i].name == namechallenge) {
    //     _challengeListSave.removeAt(i);
    //   }
    // }
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      print('challengelistname');
      print(namechallenge);
      if (_challengeList[i].name == namechallenge) {
        _challengeListSave.add(
          ChallengeModel(
              notifiaction: _challengeList[i].notification,
              date: _challengeList[i].date,
              quotidient: _challengeList[i].quotidient,
              animatedpadding: _challengeList[i].animatedpadding,
              totalDays: _challengeList[i].totalDays,
              listeDeTache: _challengeList[i].listeDeTache,
              name: _challengeList[i].name,
              description: _challengeList[i].description,
              totalChallenge: _challengeList[i].totalChallenge,
              unity: _challengeList[i].unity),
        );

        await _saveSauvegarde();
        // _initChallengeList();
        // notifyListeners();
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

  Future<bool> _save1Sauvegarde({bool remove, String nameChallenge}) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].name == nameChallenge) {
        if (_challengeListSave[i].listeDeTache.length < 1 && remove ?? false) {
          _challengeListSave[i].listeDeTache = [];
          List<String> _jsonList = _challengeListSave.map((challenge) {
            return jsonEncode(challenge.toJson());
          }).toList();
          return _localData.setStringList(keyAccesSAve, _jsonList);
        }
      }
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

  void remove(
      {@required int index, @required bool validate, String name}) async {
    _challengeList.removeAt(index);
    await _save(remove: true);

    if (!validate) {
      for (var i = _challengeListSave.length - 1; i >= 0; i--) {
        if (_challengeListSave[i].name == name) {
          _challengeListSave.removeAt(i);
          await _saveSauvegarde(remove: true);
          return;
        }
      }
    }

    _initChallengeList();
    notifyListeners();
  }

  voidremove2Save(
      {@required int index,
      @required String nameChallenge,
      bool validate}) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].name == nameChallenge) {
        if (!validate) {
          var additionchallenge = _challengeListSave[i].totalChallenge;
          _challengeListSave[i].totalChallenge =
              (int.parse(additionchallenge) - 1).toString();
          _challengeListSave[i].listeDeTache.removeAt(index);
        }
      }
    }
    await _save1Sauvegarde(remove: true, nameChallenge: nameChallenge);

    _initChallengeList();
    notifyListeners();
  }

  void remove2(
      {@required int index,
      @required String nameChallenge,
      @required bool validate}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == nameChallenge) {
        if (!validate) {
          var additionchallenge = _challengeList[i].totalChallenge;
          _challengeList[i].totalChallenge =
              (int.parse(additionchallenge) - 1).toString();
          _challengeList[i].listeDeTache.removeAt(index);
        }
      }
    }
    await _save1(remove: true, nameChallenge: nameChallenge);

    _initChallengeList();
    notifyListeners();
    if (validate) {
      voidremove2Save(
          index: index, nameChallenge: nameChallenge, validate: validate);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    patchData = '$path/challengeList.txt';
    return File('$path/challengeList.txt');
  }

  Future<String> readContent() async {
    try {
      final path = await FlutterDocumentPicker.openDocument();
      final file = File(path);
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  void uploadChallenge() async {
    ChallengeModel uploadFileChallenge;
    Map _jsonDecodeuploadFile;
    String uploadFile = await readContent();
    if (uploadFile != null) {
      _jsonDecodeuploadFile = jsonDecode(uploadFile);
      uploadFileChallenge = ChallengeModel.fromJSON(_jsonDecodeuploadFile);
      addChallenge(
          notifiaction: uploadFileChallenge.notification,
          totalDays: uploadFileChallenge.totalDays,
          quotidient: uploadFileChallenge.quotidient,
          animatedpadding: uploadFileChallenge.animatedpadding,
          date: uploadFileChallenge.date,
          challengeListTache: uploadFileChallenge.listeDeTache,
          name: uploadFileChallenge.name,
          description: uploadFileChallenge.description,
          totalChallenge: uploadFileChallenge.totalChallenge,
          unity: uploadFileChallenge.unity
              .toString()
              .replaceAll(unityPattern, ""));
    }
  }

  void writeContent({String nameChallenge}) async {
    final file = await _localFile;
    // Write the file
    await file.writeAsString(_saveLocalData(nameChallenge: nameChallenge));
    Share.shareFiles([patchData], text: "Challenges");
  }

  String _saveLocalData({String nameChallenge}) {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].name == nameChallenge) {
        if (_challengeList[i] != null) {
          Map mapChallengeList = _challengeList[i].toJson();
          _jsonChallengeList = jsonEncode(mapChallengeList);
        }
      }
    }
    print(_jsonChallengeList);
    return _jsonChallengeList;
  }
}
