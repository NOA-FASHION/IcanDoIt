import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share/share.dart';

const String keyAcces = "challengeList";
const String keyAccesSAve = "challengeListSAve";
const String keyAccesChallengeDay = "challengeDay";
const String keyAccesChallengeYesterday = "ChallengeyesterDay";

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}

class Challengecontroller extends ChangeNotifier {
  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

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
    // print('test unitaire');
    _initChallengeListStartChallenge();

    notifyListeners();
    initLocalNotification();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  int pendingNotificationCount = 0;

  int get totalNotifcation => pendingNotificationCount;

  Future<void> updateNotificationCount() async {
    List<PendingNotificationRequest> pendingNotifcationRequests =
        await flutterLocalNotificationsPlugin?.pendingNotificationRequests();
  }

  Future<int> getHighestNotificationId() async {
    List<PendingNotificationRequest> pendingNotifcationRequests =
        await flutterLocalNotificationsPlugin?.pendingNotificationRequests();
    int maxId = 0;
    pendingNotifcationRequests?.forEach((item) {
      if (item.id > maxId) maxId = item.id;
    });
    return maxId;
  }

  Future<int> getNotificationId(String title) async {
    List<PendingNotificationRequest> pendingNotifcationRequests =
        await flutterLocalNotificationsPlugin?.pendingNotificationRequests();
    final notification = pendingNotifcationRequests?.firstWhere(
      (item) => item.title == title,
      orElse: () => null,
    );
    if (notification != null) return notification.id;
    return null;
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin?.cancelAll();
    await updateNotificationCount();
    notifyListeners();
  }

  Future<void> cancelNotificationById(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<dynamic> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return ReceivedNotification(
        id: id, title: title, body: body, payload: payload);
  }

  Future<dynamic> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    // do something with notification based on paylod
  }

  Future<void> initLocalNotification() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin?.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    await updateNotificationCount();
  }

  Future<void> showNotification(
      {@required String channelID,
      @required String channelName,
      @required String channelDesc,
      @required String notificationTitle,
      @required String notificationBody,
      String payload}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelID,
      channelName,
      channelDesc,
      priority: Priority.high,
      importance: Importance.max,
      ticker: channelName,
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin?.show(
        0, notificationTitle, notificationBody, notificationDetails,
        payload: 'item X');
  }

  Future<void> scheduledNotification(
      {@required String channelID,
      @required String channelName,
      @required String channelDesc,
      @required String notificationTitle,
      int notificationId,
      @required String notificationBody,
      @required DateTime notificationTime}) async {
    DateTime scheduledNotificationDateTime = notificationTime;

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelID,
      channelName,
      channelDesc,
      priority: Priority.high,
      importance: Importance.max,
      ticker: '$channelName',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin?.schedule(0, notificationTitle,
        notificationBody, scheduledNotificationDateTime, notificationDetails,
        payload: 'item X');
  }

  String translateDays(String days) {
    String daysFinal = "";
    if (days == "Lundi") {
      daysFinal = "Monday";
    } else if (days == "Mardi") {
      daysFinal = "Tuesday";
    } else if (days == "Mercredi") {
      daysFinal = "Wednesday";
    } else if (days == "Jeudi") {
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
    DateTime today = new DateTime.now();
    // print(DateFormat('d').format(today));
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].date.isNotEmpty) {
        if (_challengeListSave[i].date == DateFormat('d').format(today)) {
          challegListSaveShedule(i);
        }
      }
    }
  }

  void removeMensuel() async {
    DateTime today = new DateTime.now();
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].date.isNotEmpty) {
        if (_challengeList[i].date == DateFormat('d').format(today)) {
          _challengeList.removeAt(i);
        }
      }
    }
    await _save(remove: true);
  }

  void testSchedule() async {
    removeQuotidientSave();

    initialiseQuotidient();

    removeHebdo();

    hebdoSave();

    removeMensuel();

    mensuelSave();
  }

  void hebdoSave() {
    DateTime today = new DateTime.now();
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].totalDays.isNotEmpty) {
        for (var n = _challengeListSave[i].totalDays.length - 1; n >= 0; n--) {
          print(_challengeList[i].totalDays.length);
          if (translateDays(_challengeListSave[i].totalDays[n]) ==
              DateFormat('EEEE').format(today)) {
            challegListSaveShedule(i);
            // print('test unitaire save hebdo');
          }
        }
      }
    }
  }

  void removeHebdo() async {
    DateTime today = new DateTime.now();
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].totalDays.isNotEmpty) {
        for (var n = _challengeList[i].totalDays.length - 1; n >= 0; n--) {
          if (_challengeList[i].totalDays.length > 0 &&
              translateDays(_challengeList[i].totalDays[n]) ==
                  DateFormat('EEEE').format(today)) {
            _challengeList.removeAt(i);

            // notifyListeners();
            // remove(index: i, validate: true);

            // print('test unitaire remove hebdo');
          }
        }
      }
    }
    // await _save(remove: true);
  }

  void removeQuotidientSave() async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].quotidient == true) {
        print(_challengeList[i].name);
        // print(i);
        _challengeList.removeAt(i);
      }
    }
    // await _save(remove: true);
  }

  void initialiseQuotidient() {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].quotidient == true) {
        // print(_challengeListSave[i].name);
        // print(i);
        challegListSaveShedule(i);
        // print('test unitaire3');
      }
    }
  }

  void challegListSaveShedule(int index) async {
    _challengeList.add(
      ChallengeModel(
          idChallenge: _challengeListSave[index].idChallenge,
          idNotif: _challengeListSave[index].idNotif,
          boolId: _challengeListSave[index].boolId,
          id: _challengeListSave[index].id,
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
    // return;
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
      // print('test unitaire startchallengedays');
      // notifyListeners();
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
      // print('test unitaire startchallengeyestedays');
      // notifyListeners();
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
      // print('test unitaire initchallengeyestedays');
      await _saveChallenyesterday();
      _initChallengeListStartChallenge();
      // notifyListeners();
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
      // print('test unitaire initchallengedays');
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
    // print('test unitaire addCommentaireChallengeDay');
    await _saveChallendays();
    _initChallengeListStartChallenge();
    // notifyListeners();
  }

  void addnbtacheVallide() async {
    challengeDays.nbtacheVallide =
        (int.parse(challengeDays.nbtacheVallide) + 1).toString();
    addCommentaireChallengeDay();
    // print('test unitaire addnbtacheVallide');
    await _saveChallendays();
    _initChallengeListStartChallenge();
    // notifyListeners();
  }

  void addnbChallengeVallide() async {
    challengeDays.nbchallengeVallide =
        (int.parse(challengeDays.nbchallengeVallide) + 1).toString();
    addCommentaireChallengeDay();
    // print('test unitaire addnbChallengeVallide');
    await _saveChallendays();
    _initChallengeListStartChallenge();
    // notifyListeners();
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
    return _challengeList2;
  }

  // double calulPercent(String name) {
  //   double resultat;
  //   for (var i = _challengeList.length - 1; i >= 0; i--) {
  //     if (_challengeList[i].name == name) {
  //       if (_challengeList[i].listeDeTache.length != null) {
  //         if (_challengeList[i].listeDeTache.length > 0 &&
  //             (_challengeList[i].listeDeTache.length ==
  //                 int.parse(_challengeList[i].totalChallenge))) {
  //           resultat = 0.00;
  //         } else if (_challengeList[i].listeDeTache.length != 0 &&
  //             (_challengeList[i].listeDeTache.length !=
  //                 int.parse(_challengeList[i].totalChallenge))) {
  //           resultat = (_challengeList[i].listeDeTache.length /
  //               int.parse(_challengeList[i].totalChallenge));
  //         } else {
  //           resultat = 0.00;
  //         }
  //       } else {
  //         resultat = 0.00;
  //       }
  //     }
  //     return resultat;
  //   }
  // }

  List<Challengemodel2> challengelist2(String id) {
    List<Challengemodel2> additionchallenge = [];
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == id) {
        additionchallenge = _challengeList[i].listeDeTache;
        for (var n = _challengeList[i].listeDeTache.length - 1; n >= 0; n--) {
          _challengeList[i].listeDeTache[n].index = n.toString();
        }
        // print('test unitaire challengelist2');
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

  void addformationChapitre(
      {@required int indexChallenge,
      @required int index,
      @required String chapitre}) async {
    _challengeList[indexChallenge].listeDeTache[index].formation.chapitre =
        chapitre;
    addChallengesaveChapitre(
      idlistTache: _challengeList[indexChallenge].listeDeTache[index].id,
      id: _challengeList[indexChallenge].id,
      chapitre: chapitre,
    );
    // print('test unitaire addformationChapitre');
    // await _saveSauvegarde();
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void addformationDuree(
      {@required int indexChallenge,
      @required int index,
      @required String duree}) async {
    _challengeList[indexChallenge].listeDeTache[index].formation.duree = duree;
    addChallengesaveDuree(
      idlistTache: _challengeList[indexChallenge].listeDeTache[index].id,
      id: _challengeList[indexChallenge].id,
      duree: duree,
    );
    // print('test unitaire addformationDuree');
    // await _saveSauvegarde();
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void addformationTheoriePratique(
      {@required int indexChallenge,
      @required int index,
      @required String theoriePratique}) async {
    _challengeList[indexChallenge]
        .listeDeTache[index]
        .formation
        .theoriePratique = theoriePratique;
    addChallengesavetheoriePratique(
      idlistTache: _challengeList[indexChallenge].listeDeTache[index].id,
      id: _challengeList[indexChallenge].id,
      theoriePratique: theoriePratique,
    );
    // print('test unitaire addformationTheoriePratique');
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void addChallengesavetheoriePratique({
    @required String theoriePratique,
    @required String idlistTache,
    @required String id,
  }) async {
    await delay(500);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == id) {
        for (var n = _challengeListSave[i].listeDeTache.length - 1;
            n >= 0;
            n--) {
          if (_challengeListSave[i].listeDeTache[n].id == idlistTache) {
            _challengeListSave[i].listeDeTache[n].formation.theoriePratique =
                theoriePratique;
            // print('test unitaire addChallengesavetheoriePratique');
            await _saveSauvegarde();
            _initChallengeList();
            return;
          }
        }
      }
    }
  }

  void addChallengesaveChapitre({
    @required String chapitre,
    @required String idlistTache,
    @required String id,
  }) async {
    await delay(500);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == id) {
        for (var n = _challengeListSave[i].listeDeTache.length - 1;
            n >= 0;
            n--) {
          if (_challengeListSave[i].listeDeTache[n].id == idlistTache) {
            _challengeListSave[i].listeDeTache[n].formation.chapitre = chapitre;
            await _saveSauvegarde();
            _initChallengeList();
            // print('test unitaire addChallengesaveChapitre');
            return;
          }
        }
      }
    }
  }

  void addChallengesaveDuree({
    @required String duree,
    @required String idlistTache,
    @required String id,
  }) async {
    await delay(500);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == id) {
        for (var n = _challengeListSave[i].listeDeTache.length - 1;
            n >= 0;
            n--) {
          if (_challengeListSave[i].listeDeTache[n].id == idlistTache) {
            _challengeListSave[i].listeDeTache[n].formation.duree = duree;
            await _saveSauvegarde();
            _initChallengeList();
            // print('test unitaire addChallengesaveDuree');
            return;
          }
        }
      }
    }
  }

  void addChallenge2({
    @required String id,
    @required int index,
    @required Formation formation,
    @required bool animatedpadding,
    @required String totalChallenge,
    @required String idListChallenge,
    @required String name,
    @required String tache,
    @required String description,
  }) async {
    // something = nameListChallenge;
    // for (var i = _challengeList.length - 1; i >= 0; i--) {}
    _challengeList3 = [];
    _challengeList3.add(Challengemodel2(
        id: id,
        name: name,
        tache: tache,
        description: choixDesciptionEnum(description),
        formation: formation));

    addChallenge1(
      id: id,
      index: index,
      formation: formation,
      totalChallenge: totalChallenge,
      challengeListTest: _challengeList3,
    );

    if (animatedpadding) {
      addChallengesave1(
        id: id,
        formation: formation,
        totalChallenge: totalChallenge,
        idChallenge: idListChallenge,
        challengeListTest: _challengeList3,
      );
    }
    // print('test unitaire addChallenge2');
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void save() async {
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void addChallengesave1({
    @required String id,
    @required Formation formation,
    @required String totalChallenge,
    @required String idChallenge,
    @required List<Challengemodel2> challengeListTest,
  }) async {
    await delay(500);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == idChallenge) {
        var additionchallenge = _challengeListSave[i].totalChallenge;
        _challengeListSave[i].totalChallenge =
            (int.parse(additionchallenge) + 1).toString();

        for (var n = challengeListTest.length - 1; n >= 0; n--) {
          _challengeListSave[i].listeDeTache.add(
                Challengemodel2(
                    id: id,
                    name: challengeListTest[n].name,
                    tache: challengeListTest[n].tache,
                    description: challengeListTest[n].description,
                    formation: formation),
              );
          // print('test unitaire addChallengesave0');
        }
        await _saveSauvegarde();
        _initChallengeList();
        // notifyListeners();
        // print('test unitaire addChallengesave1');
        return;
      }
    }
  }

  void addChallenge1({
    @required String id,
    @required int index,
    @required Formation formation,
    @required String totalChallenge,
    @required List<Challengemodel2> challengeListTest,
  }) async {
    var additionchallenge = _challengeList[index].totalChallenge;
    _challengeList[index].totalChallenge =
        (int.parse(additionchallenge) + 1).toString();

    _challengeList[index].listeDeTache.add(
          Challengemodel2(
              id: id,
              name: challengeListTest[0].name,
              tache: challengeListTest[0].tache,
              description: challengeListTest[0].description,
              formation: formation),
        );
    // print('test unitaire addChallenge1');
  }

  void addChallenge(
      {@required List<String> idChallenge,
      @required String idNotif,
      @required bool boolId,
      @required String id,
      @required String name,
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
          boolId: boolId,
          idChallenge: idChallenge,
          idNotif: idNotif,
          id: id,
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
      addListChallengeSave(id);
    }

    await _save();
    _initChallengeList();
    notifyListeners();
  }

  int getChallengesindex() {
    return indexSave;
  }

  void deplacelistSAve(int index, String id) async {
    await delay(200);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == id &&
          _challengeListSave[i].listeDeTache.length ==
              _challengeList[index].listeDeTache.length) {
        removeSave2(id: id);
        addListChallengeSaveindex(index);
        // print('test unitaire deplacelistSAve');
        return;
      }
    }
  }

  indexSaveFunction(bool selected, int index) {
    if (selected) {
      indexSave = index;
    }
  }

  void addSlectSave() async {
    if (indexSave != null) {
      for (var i = _challengeList.length - 1; i >= 0; i--) {
        if (_challengeList[i].id == _challengeListSave[indexSave].id) {
          _challengeList.removeAt(i);
        }
        _challengeList.add(
          ChallengeModel(
              idChallenge: _challengeListSave[indexSave].idChallenge,
              idNotif: _challengeListSave[indexSave].idNotif,
              boolId: _challengeListSave[indexSave].boolId,
              id: _challengeListSave[indexSave].id,
              notifiaction: _challengeListSave[indexSave].notification,
              date: _challengeListSave[indexSave].date,
              quotidient: _challengeListSave[indexSave].quotidient,
              animatedpadding: _challengeListSave[indexSave].animatedpadding,
              totalDays: _challengeListSave[indexSave].totalDays,
              listeDeTache: _challengeListSave[indexSave].listeDeTache,
              name: _challengeListSave[indexSave].name,
              description: _challengeListSave[indexSave].description,
              totalChallenge: _challengeListSave[indexSave].totalChallenge,
              unity: _challengeListSave[indexSave].unity),
        );

        await _save();
        _initChallengeList();
        notifyListeners();
        // print('test unitaire addSlectSave');
        return;
      }
    }
  }

  // void addSlectSave() async {
  //   if (indexSave != null) {
  //     for (var i = _challengeListSave.length - 1; i >= 0; i--) {
  //       if (i == indexSave) {
  //         _challengeList.add(
  //           ChallengeModel(
  //               idChallenge: _challengeListSave[i].idChallenge,
  //               idNotif: _challengeListSave[i].idNotif,
  //               boolId: _challengeListSave[i].boolId,
  //               id: _challengeListSave[i].id,
  //               notifiaction: _challengeListSave[i].notification,
  //               date: _challengeListSave[i].date,
  //               quotidient: _challengeListSave[i].quotidient,
  //               animatedpadding: _challengeListSave[i].animatedpadding,
  //               totalDays: _challengeListSave[i].totalDays,
  //               listeDeTache: _challengeListSave[i].listeDeTache,
  //               name: _challengeListSave[i].name,
  //               description: _challengeListSave[i].description,
  //               totalChallenge: _challengeListSave[i].totalChallenge,
  //               unity: _challengeListSave[i].unity),
  //         );

  //         await _save();
  //         _initChallengeList();
  //         notifyListeners();
  //         // print('test unitaire addSlectSave');
  //         return;
  //       }
  //     }
  //   }
  // }

  void addListChallengeSaveindex(int index) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == _challengeList[index].id) {
        _challengeListSave.removeAt(i);
      }
    }
    _challengeListSave.add(
      ChallengeModel(
          idChallenge: _challengeList[index].idChallenge,
          idNotif: _challengeList[index].idNotif,
          boolId: _challengeList[index].boolId,
          id: _challengeList[index].id,
          notifiaction: _challengeList[index].notification,
          date: _challengeList[index].date,
          quotidient: _challengeList[index].quotidient,
          animatedpadding: _challengeList[index].animatedpadding,
          totalDays: _challengeList[index].totalDays,
          listeDeTache: _challengeList[index].listeDeTache,
          name: _challengeList[index].name,
          description: _challengeList[index].description,
          totalChallenge: _challengeList[index].totalChallenge,
          unity: _challengeList[index].unity),
    );
    // print('test unitaire addListChallengeSaveindex');
    await _saveSauvegarde();
    _initChallengeList();
    notifyListeners();
    return;
  }

  void addListChallengeSave(String id) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == id) {
        _challengeListSave.add(
          ChallengeModel(
              idChallenge: _challengeList[i].idChallenge,
              idNotif: _challengeList[i].idNotif,
              boolId: _challengeList[i].boolId,
              id: _challengeList[i].id,
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
        // print('test unitaire addListChallengeSave');
        await _saveSauvegarde();
        _initChallengeList();
        notifyListeners();
        return;
      }
    }
  }

  int returnIndexForName(String id) {
    int index;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == id) {
        index = i;
      }
      // print('test unitaire returnIndexForName');
    }
    return index;
  }

  void desactivAffichagePrinc(int index, bool boolId) async {
    _challengeList[index].boolId = boolId;
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void raccourciChallenge(
      {List<String> raccourci, String name, String idChallenge}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      for (var n = raccourci.length - 1; n >= 0; n--) {
        if (_challengeList[i].id == raccourci[n]) {
          _challengeList[i].idChallenge.add(idChallenge);
        }
      }
      // print('test unitaire raccourciChallenge');
    }
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  Future<bool> _save1({bool remove, String idChallenge}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == idChallenge) {
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

  Future<bool> _save1Sauvegarde({bool remove, String idChallenge}) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == idChallenge) {
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

  void removeSave2({@required String id}) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == id) {
        _challengeListSave.removeAt(i);
        await _saveSauvegarde(remove: true);
        return;
      }
    }
  }

  void remove({@required int index, @required bool validate, String id}) async {
    _challengeList.removeAt(index);
    await _save(remove: true);

    if (!validate) {
      for (var i = _challengeListSave.length - 1; i >= 0; i--) {
        if (_challengeListSave[i].id == id) {
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
      {@required String id,
      @required int indexSave,
      @required int index,
      @required String idChallenge,
      bool validate}) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == idChallenge) {
        var additionchallenge = _challengeListSave[i].totalChallenge;
        _challengeListSave[i].totalChallenge =
            (int.parse(additionchallenge) - 1).toString();

        for (var n = _challengeListSave[i].listeDeTache.length - 1;
            n >= 0;
            n--) {
          if (_challengeListSave[i].listeDeTache[n].id == id) {
            _challengeListSave[i].listeDeTache.removeAt(n);
            await _save1Sauvegarde(remove: true, idChallenge: idChallenge);
            // print('test unitaire voidremove2Save');
            // _initChallengeList();
            // notifyListeners();
            return;
          }
        }
      }
    }
  }

  void remove2(
      {@required String id,
      @required int indexSave,
      @required int index,
      @required String idChallenge,
      @required bool validate}) async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == idChallenge) {
        if (!validate) {
          var additionchallenge = _challengeList[i].totalChallenge;
          _challengeList[i].totalChallenge =
              (int.parse(additionchallenge) - 1).toString();

          await voidremove2Save(
              id: id,
              indexSave: indexSave,
              index: index,
              idChallenge: idChallenge,
              validate: validate);
        }
        _challengeList[i].listeDeTache.removeAt(index);
        // print('test unitaire remove2');
      }
    }
    await _save1(remove: true, idChallenge: idChallenge);

    _initChallengeList();
    notifyListeners();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
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
          idNotif: uploadFileChallenge.idNotif,
          boolId: uploadFileChallenge.boolId,
          idChallenge: uploadFileChallenge.idChallenge,
          notifiaction: uploadFileChallenge.notification,
          totalDays: uploadFileChallenge.totalDays,
          quotidient: uploadFileChallenge.quotidient,
          animatedpadding: uploadFileChallenge.animatedpadding,
          date: uploadFileChallenge.date,
          challengeListTache: uploadFileChallenge.listeDeTache,
          name: uploadFileChallenge.name,
          description: uploadFileChallenge.description,
          totalChallenge: uploadFileChallenge.totalChallenge,
          unity:
              uploadFileChallenge.unity.toString().replaceAll(unityPattern, ""),
          id: uploadFileChallenge.id);
    }
  }

  void writeContent({String id}) async {
    final file = await _localFile;
    // Write the file
    await file.writeAsString(_saveLocalData(id: id));
    Share.shareFiles([patchData], text: "Challenges");
  }

  String _saveLocalData({String id}) {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == id) {
        if (_challengeList[i] != null) {
          Map mapChallengeList = _challengeList[i].toJson();
          _jsonChallengeList = jsonEncode(mapChallengeList);
        }
      }
    }
    return _jsonChallengeList;
  }
}
