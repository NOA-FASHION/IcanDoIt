import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
// import 'package:nanoid/async.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:icandoit/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share/share.dart';
import 'package:youtube_parser/youtube_parser.dart';

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// packages
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

  bool paiemtBool;
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
    initLocalNotification();
    _configureLocalTimeZone();
  }

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// initialisaton
  void _initChallengeList() async {
    _localData = await SharedPreferences.getInstance();
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
    paiemtBool = false;

    _initChallengeListStartChallenge();
    modifDtabaseFirebase();
    // getBoolActivation();

    notifyListeners();
  }

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// fin initialisaton
  ///
  ///
  // void initChallengeList() {
  //   _initChallengeList();
  // }

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// notification
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

  static const MethodChannel platform =
      MethodChannel('dexterx.dev/flutter_local_notifications_example');

  Future<int> getHighestNotificationId() async {
    List<PendingNotificationRequest> pendingNotifcationRequests =
        await flutterLocalNotificationsPlugin?.pendingNotificationRequests();
    int maxId = 0;
    pendingNotifcationRequests?.forEach((item) {
      if (item.id > maxId) maxId = item.id;
    });
    return maxId;
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
            Text('${pendingNotificationRequests.length} pending notification '
                'requests'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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

  getNotificationId1(String title) async {
    List<PendingNotificationRequest> pendingNotifcationRequests =
        await flutterLocalNotificationsPlugin?.pendingNotificationRequests();
    final notification = pendingNotifcationRequests?.firstWhere(
      (item) => item.title == title,
      orElse: () => null,
    );
    if (notification != null) print(notification.id);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName =
        await platform.invokeMethod<String>('getTimeZoneName');
    tz.setLocalLocation(tz.getLocation(timeZoneName));
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

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> showNotificationCustomVibrationIconLed() async {
    final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('other custom channel id',
            'other custom channel name', 'other custom channel description',
            // icon: 'secondary_icon',
            // largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
            vibrationPattern: vibrationPattern,
            enableLights: true,
            color: const Color.fromARGB(255, 255, 0, 0),
            ledColor: const Color.fromARGB(255, 255, 0, 0),
            ledOnMs: 1000,
            ledOffMs: 500);

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'title of notification with custom vibration pattern, LED and icon',
        'body of notification with custom vibration pattern, LED and icon',
        platformChannelSpecifics);
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

  tz.TZDateTime _nextInstanceOfTenAM(int hours) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hours);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM(int hours, String weekdays) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM(hours);
    while (scheduledDate.weekday != transformDate(weekdays)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  tz.TZDateTime _nextInstancDayeOfTenAM(int days, int hours) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, days, hours);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    // print(scheduledDate.toString());
    return scheduledDate;
  }

  tz.TZDateTime _nextInstancNotifeOfTenAM1(String dateNotif) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    final date2 = DateTime.now();

    tz.TZDateTime scheduledDate = tz.TZDateTime.parse(tz.local, dateNotif);
    var difference = scheduledDate.difference(date2).inDays + 1;
    scheduledDate = scheduledDate.add(Duration(
        days: difference,
        hours: tz.TZDateTime.parse(tz.local, dateNotif).hour,
        minutes: tz.TZDateTime.parse(tz.local, dateNotif).minute));
    print("difference : " + difference.toString());
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  tz.TZDateTime _nextInstancNotifeOfTenAM(String dateNotif) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.parse(tz.local, dateNotif);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  int transformDate(String days) {
    int daysFinal;
    if (days == "Lundi") {
      daysFinal = DateTime.monday;
      return daysFinal;
    } else if (days == "Mardi") {
      daysFinal = DateTime.tuesday;
      return daysFinal;
    } else if (days == "Mercredi") {
      daysFinal = DateTime.wednesday;
      return daysFinal;
    } else if (days == "Jeudi") {
      daysFinal = DateTime.thursday;
      return daysFinal;
    } else if (days == "Vendredi") {
      daysFinal = DateTime.friday;
      return daysFinal;
    } else if (days == "Samedi") {
      daysFinal = DateTime.saturday;
      return daysFinal;
    } else if (days == "Dimanche") {
      daysFinal = DateTime.sunday;
      return daysFinal;
    }
    return daysFinal;
  }

  Future<void> scheduledNotifNotification({
    @required String channelID,
    @required String channelName,
    @required String channelDesc,
    @required String notificationTitle,
    int notificationId,
    @required String notificationBody,
    @required String dateNotif,
  }) async {
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

    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        channelName,
        channelDesc,
        _nextInstancNotifeOfTenAM(dateNotif),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> scheduleMonthdNotification(
      {@required String channelID,
      @required String channelName,
      @required String channelDesc,
      @required String notificationTitle,
      int notificationId,
      @required String notificationBody,
      @required int days,
      @required int hours}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        channelName,
        channelDesc,
        _nextInstancDayeOfTenAM(days, hours),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'weekly notification channel id',
              'weekly notification channel name',
              'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> scheduleHebdodNotification(
      {@required String channelID,
      @required String channelName,
      @required String channelDesc,
      @required String notificationTitle,
      int notificationId,
      @required String notificationBody,
      @required int hours,
      @required String weekdays}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        channelName,
        channelDesc,
        _nextInstanceOfMondayTenAM(hours, weekdays),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'weekly notification channel id',
              'weekly notification channel name',
              'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> scheduleQuotidiendNotification(
      {@required String channelID,
      @required String channelName,
      @required String channelDesc,
      @required String notificationTitle,
      int notificationId,
      @required String notificationBody,
      @required int hours}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        channelName,
        channelDesc,
        _nextInstanceOfTenAM(hours),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> scheduleDailyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        _nextInstanceOfTenAM2(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfTenAM2() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  String translateDays(String days) {
    String daysFinal;
    if (days == "Lundi") {
      daysFinal = "Monday";
      return daysFinal;
    } else if (days == "Mardi") {
      daysFinal = "Tuesday";
      return daysFinal;
    } else if (days == "Mercredi") {
      daysFinal = "Wednesday";
      return daysFinal;
    } else if (days == "Jeudi") {
      daysFinal = "Thursday";
      return daysFinal;
    } else if (days == "Vendredi") {
      daysFinal = "Friday";
      return daysFinal;
    } else if (days == "Samedi") {
      daysFinal = "Saturday";
      return daysFinal;
    } else if (days == "Dimanche") {
      daysFinal = "Sunday";
      return daysFinal;
    }
    return null;
  }
/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// fin notification

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// active notif score
  void activeResultat(bool isSwitch) async {
    challengeDays.notifcationResultBool = isSwitch;
    await _saveChallendays();
    _initChallengeListStartChallenge();
    activeNotif();
  }

  void activeNotif() {
    if (challengeDays.notifcationResultBool) {
      scheduleQuotidiendNotification(
          channelID: "10098273",
          channelName: "ChallenDays",
          channelDesc: challengeDays.commentaire,
          notificationId: 10098273,
          notificationTitle: 'Date Tracker Test',
          notificationBody: 'We are showing notification!',
          hours: 19);
    } else if (!challengeDays.notifcationResultBool) {
      cancelNotificationById(10098273);
    }
  }

  void majMensuelSave(ChallengeModel challengeListSave) {
    DateTime today = new DateTime.now();
    DateTime lastDay =
        DateFormat('EEEE, d MMM, yyyy').parseStrict(challengeDays.date);
    if (today.month == lastDay.month &&
        lastDay.day < int.parse(challengeListSave.date) &&
        today.day > int.parse(challengeListSave.date)) {}
  }

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// maj auto des chalenges
  void mensuelSave() {
    DateTime today = new DateTime.now();
    DateTime lastDay =
        DateFormat('EEEE, d MMM, yyyy').parseStrict(challengeDays.date);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].date.isNotEmpty) {
        if (_challengeListSave[i].date == DateFormat('d').format(today)) {
          // removeEcheance();
          challegListSaveShedule(i);
        }
        if (today.month == lastDay.month &&
            lastDay.day < int.parse(_challengeListSave[i].date) &&
            today.day > int.parse(_challengeListSave[i].date)) {
          challegListSaveShedule(i);
          // removeEcheance();
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
            // removeEcheance();
            challegListSaveShedule(i);
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
          }
        }
      }
    }
  }

  void removeQuotidientSave() async {
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].quotidient == true) {
        print(_challengeList[i].name);

        _challengeList.removeAt(i);
      }
    }
  }

  void initialiseQuotidient() {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].quotidient == true) {
        // removeEcheance();
        challegListSaveShedule(i);
      }
    }
  }

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// fin maj auto des chalenges
  void challegListSaveShedule(int index) async {
    _challengeList.add(
      ChallengeModel(
          prelevementAutoBool: _challengeListSave[index].prelevementAutoBool,
          echeancierBoll: _challengeListSave[index].echeancierBoll,
          previsions: _challengeListSave[index].previsions,
          restePaiement: _challengeListSave[index].restePaiement,
          coutTotalBool: _challengeListSave[index].coutTotalBool,
          prixTotalBool: _challengeListSave[index].prixTotalBool,
          prixTotal: _challengeListSave[index].prixTotal,
          coutTotal: _challengeListSave[index].coutTotal,
          idChallenge: _challengeListSave[index].idChallenge,
          idNotif: _challengeListSave[index].idNotif,
          boolId: _challengeListSave[index].boolId,
          id: _challengeListSave[index].id,
          notification: _challengeListSave[index].notification,
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

/////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// initialisation score challenge
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
    if (challengeDays.date == null) {
      challengeDays.notifcationResultBool = false;
      challengeDays.date = DateFormat('EEEE, d MMM, yyyy').format(today);
      challengeDays.nbChallengeEnCours = "0";
      challengeDays.nbTacheEnCours = "0";
      challengeDays.commentaire = "";
      challengeDays.nbchallengeVallide = "0";
      challengeDays.nbtacheVallide = "0";

      await _saveChallendays();
      _initChallengeListStartChallenge();
    }
  }

  void startChallenyesterday() async {
    DateTime today = new DateTime.now();
    if (challengeyesterday.nbTacheEnCours != "false") {
      challengeyesterday.date = DateFormat('EEEE, d MMM, yyyy').format(today);
      challengeyesterday.nbChallengeEnCours = "false";
      challengeyesterday.nbTacheEnCours = "false";
      challengeyesterday.commentaire = "true";
      challengeyesterday.nbchallengeVallide = "false";
      challengeyesterday.nbtacheVallide = "de";
      await initialiseConnectionDatabase();
      await _saveChallenyesterday();
      _initChallengeListStartChallenge();
    }
  }

  void initChallengeyesterday() async {
    // getBoolActivation();
    // await modifDtabaseFirebase();
    DateTime today = new DateTime.now();
    DateTime lastDay =
        DateFormat('EEEE, d MMM, yyyy').parseStrict(challengeyesterday.date);
    if ((today.day >= (lastDay.day + 1)) || (today.month > lastDay.month)) {
      challengeyesterday.nbchallengeVallide = "true";
      await _saveChallenyesterday();
      _initChallengeListStartChallenge();
    }
  }

  void documentIdFirebase(String valueId) async {
    challengeyesterday.nbtacheVallide = valueId;
    await _saveChallenyesterday();
    _initChallengeListStartChallenge();
  }

  void switchTrueIntro(bool active) async {
    if (active) {
      challengeyesterday.nbChallengeEnCours = "false";
    } else {
      challengeyesterday.nbChallengeEnCours = "true";
    }

    await _saveChallenyesterday();
    _initChallengeListStartChallenge();
  }

  void initChallendays() async {
    // print(challengeyesterday.nbtacheVallide);
    DateTime today = new DateTime.now();
    if (challengeDays.date != DateFormat('EEEE, d MMM, yyyy').format(today)) {
      modifDtabaseFirebase();
      getBoolActivation();
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
      print("test");
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
          "Vous n'avez pas validé de challenge ou de tâche...";
      activeNotif();
    } else if (nbtacheVallide1 > 9) {
      challengeDays.commentaire = "Extraordinaire, rien ne vous arrête!";
      activeNotif();
    } else if (nbtacheVallide1 > 6) {
      challengeDays.commentaire = "Bravo, vos efforts ont été récompensés!";
      activeNotif();
    } else if (nbtacheVallide1 > 0) {
      challengeDays.commentaire =
          " Encore un effort et vos objectifs seront atteints!";
      activeNotif();
    }
    await _saveChallendays();
    _initChallengeListStartChallenge();
  }

  void addnbtacheVallide() async {
    challengeDays.nbtacheVallide =
        (int.parse(challengeDays.nbtacheVallide) + 1).toString();
    addCommentaireChallengeDay();
    await _saveChallendays();
    _initChallengeListStartChallenge();
  }

  void addnbChallengeVallide() async {
    challengeDays.nbchallengeVallide =
        (int.parse(challengeDays.nbchallengeVallide) + 1).toString();
    addCommentaireChallengeDay();
    await _saveChallendays();
    _initChallengeListStartChallenge();
  }

  Future<bool> _saveChallenyesterday() async {
    if (challengeyesterday != null) {
      print('save challengeyesterday ok');
      Map mapyesterday = challengeyesterday.toJson();
      String _jsonyesterday = jsonEncode(mapyesterday);
      return _localData.setString(keyAccesChallengeYesterday, _jsonyesterday);
    }

    return false;
  }

  Future<bool> _saveChallendays() async {
    if (challengeDays != null) {
      Map mapday = challengeDays.toJson();
      String _jsonDay = jsonEncode(mapday);
      return _localData.setString(keyAccesChallengeDay, _jsonDay);
    }

    return false;
  }

  switchIntro(String switchBoll) async {
    if (switchBoll == "true" || switchBoll == "") {
      challengeyesterday.commentaire = "false";
    } else {
      challengeyesterday.commentaire = "true";
    }
    await _saveChallenyesterday();
    _initChallengeListStartChallenge();
  }
  /////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// fin initialisation score challenge

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

  List<Challengemodel2> challengelist2(String id) {
    List<Challengemodel2> additionchallenge = [];
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == id) {
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
      return unity;
    } else if (json == "achat") {
      unity = unity_challenge1.achat;
      return unity;
    } else if (json == "tache") {
      unity = unity_challenge1.tache;
      return unity;
    } else if (json == "mission") {
      unity = unity_challenge1.mission;
      return unity;
    } else if (json == "youtube") {
      unity = unity_challenge1.youtube;
      return unity;
    } else if (json == "video") {
      unity = unity_challenge1.video;
      return unity;
    } else if (json == "commentaire") {
      unity = unity_challenge1.commentaire;
      return unity;
    } else if (json == "image") {
      unity = unity_challenge1.image;
      return unity;
    } else if (json == "url") {
      unity = unity_challenge1.url;
      return unity;
    } else if (json == "adresse") {
      unity = unity_challenge1.adresse;
      return unity;
    } else if (json == "formation") {
      unity = unity_challenge1.formation;
      return unity;
    } else if (json == "paiement") {
      unity = unity_challenge1.paiement;
      return unity;
    } else if (json == "echeancier") {
      unity = unity_challenge1.echeancier;
      return unity;
    } else if (json == "projet") {
      unity = unity_challenge1.projet;
      return unity;
    } else if (json == "information") {
      unity = unity_challenge1.information;
      return unity;
    }
    return null;
  }

  unity_challenge choixDesciptionEnum1(dynamic json) {
    unity_challenge unity;
    if (json == "haute") {
      unity = unity_challenge.haute;
      return unity;
    } else if (json == "normal") {
      unity = unity_challenge.normal;
      return unity;
    } else if (json == "quotidien") {
      unity = unity_challenge.quotidien;
      return unity;
    } else if (json == "hebdomadaire") {
      unity = unity_challenge.hebdomadaire;
      return unity;
    } else if (json == "mensuel") {
      unity = unity_challenge.mensuel;
      return unity;
    } else if (json == "notification") {
      unity = unity_challenge.notification;
      return unity;
    }
    return null;
  }

  /////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// module formation

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
            return;
          }
        }
      }
    }
  }

  /////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// module formation

  /////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// modification prix
  void modifAchat(
      {@required int indexChallenge,
      @required int index,
      @required double prix}) async {
    _challengeList[indexChallenge].previsions =
        _challengeList[indexChallenge].previsions -
            _challengeList[indexChallenge].listeDeTache[index].prix;
    _challengeList[indexChallenge].listeDeTache[index].prix = prix;
    _challengeList[indexChallenge].previsions =
        _challengeList[indexChallenge].previsions + prix;
    modifAchatPratique(
      idlistTache: _challengeList[indexChallenge].listeDeTache[index].id,
      id: _challengeList[indexChallenge].id,
      prix: prix,
    );
    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void modifAchatPratique({
    @required double prix,
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
            _challengeListSave[i].previsions =
                _challengeListSave[i].previsions -
                    _challengeListSave[i].listeDeTache[n].prix;
            _challengeListSave[i].listeDeTache[n].prix = prix;
            _challengeListSave[i].previsions =
                _challengeListSave[i].previsions + prix;
            await _saveSauvegarde();
            _initChallengeList();
            return;
          }
        }
      }
    }
  }

  /////////////////////////////////////// /////////////////////////////////////// /////////////////////////////////////// fin modification prix

  void prixTotalAdd(int index, double prix) {
    if (prix > 0) {
      _challengeList[index].prixTotal = _challengeList[index].prixTotal + prix;
    }
  }

  void previsionTotalAdd(int index, double prix, String idChallenge) async {
    if (prix > 0) {
      _challengeList[index].previsions =
          _challengeList[index].previsions + prix;
    }
  }

  void activePrixBool(double prix, int index) {
    if (prix > 0) {
      _challengeList[index].prixTotalBool = true;
      return;
    }
  }

  void addChallenge2({
    @required double cout,
    @required double prix,
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
    // coutTotalAdd(index, cout, idListChallenge);
    previsionTotalAdd(index, prix, idListChallenge);
    // restePaiementTotalAdd(index, cout);
    activePrixBool(prix, index);
    // activeCoutBool(cout, index);
    _challengeList3 = [];
    _challengeList3.add(Challengemodel2(
        id: id,
        name: name,
        tache: tache,
        description: choixDesciptionEnum(description),
        formation: formation,
        cout: cout,
        prix: prix));

    addChallenge1(
      id: id,
      index: index,
      formation: formation,
      totalChallenge: totalChallenge,
      challengeListTest: _challengeList3,
      cout: cout,
      prix: prix,
    );

    if (animatedpadding) {
      addChallengesave1(
        id: id,
        formation: formation,
        totalChallenge: totalChallenge,
        idChallenge: idListChallenge,
        challengeListTest: _challengeList3,
        cout: cout,
        prix: prix,
      );
    }

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
    @required double cout,
    @required double prix,
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
        if (cout > 0) {
          _challengeListSave[i].coutTotal =
              _challengeListSave[i].coutTotal + cout;
          _challengeListSave[i].coutTotalBool = true;
        }

        if (prix > 0) {
          _challengeListSave[i].previsions =
              _challengeListSave[i].previsions + prix;
          _challengeListSave[i].prixTotalBool = true;
        }

        for (var n = challengeListTest.length - 1; n >= 0; n--) {
          _challengeListSave[i].listeDeTache.add(
                Challengemodel2(
                    cout: cout,
                    prix: prix,
                    id: id,
                    name: challengeListTest[n].name,
                    tache: challengeListTest[n].tache,
                    description: challengeListTest[n].description,
                    formation: formation),
              );
        }
        await _saveSauvegarde();
        _initChallengeList();

        return;
      }
    }
  }

  void addChallenge1({
    @required double prix,
    @required double cout,
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
              prix: prix,
              cout: cout,
              id: id,
              name: challengeListTest[0].name,
              tache: challengeListTest[0].tache,
              description: challengeListTest[0].description,
              formation: formation),
        );
    // print('test unitaire addChallenge1');
  }

  void addChallenge(
      {@required bool prelevementAutoBool,
      @required bool echeancierBoll,
      @required double previsions,
      @required double restePaiement,
      @required bool coutTotalBool,
      @required bool prixTotalBool,
      @required double prixTotal,
      @required double coutTotal,
      @required List<String> idChallenge,
      @required List<String> idNotif,
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
          prelevementAutoBool: prelevementAutoBool,
          echeancierBoll: echeancierBoll,
          previsions: previsions,
          restePaiement: restePaiement,
          coutTotalBool: coutTotalBool,
          prixTotalBool: prixTotalBool,
          prixTotal: prixTotal,
          coutTotal: coutTotal,
          boolId: boolId,
          idChallenge: idChallenge,
          idNotif: idNotif,
          id: id,
          notification: notifiaction,
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
      await delay(200);
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
        return;
      }
    }
  }

  indexSaveFunction(bool selected, int index) {
    if (selected) {
      indexSave = index;
    }
  }

  void restaureSave(int index) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == _challengeList[index].id) {
        _challengeList.removeAt(index);
        _challengeList.add(
          ChallengeModel(
              prelevementAutoBool: _challengeListSave[i].prelevementAutoBool,
              echeancierBoll: _challengeListSave[i].echeancierBoll,
              previsions: _challengeListSave[i].previsions,
              restePaiement: _challengeListSave[i].restePaiement,
              coutTotalBool: _challengeListSave[i].coutTotalBool,
              prixTotalBool: _challengeListSave[i].prixTotalBool,
              prixTotal: _challengeListSave[i].prixTotal,
              coutTotal: _challengeListSave[i].coutTotal,
              idChallenge: _challengeListSave[i].idChallenge,
              idNotif: _challengeListSave[i].idNotif,
              boolId: _challengeListSave[i].boolId,
              id: _challengeListSave[i].id,
              notification: _challengeListSave[i].notification,
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
        // print('test unitaire addSlectSave');
        return;
      }
    }
  }

  void addSlectSave() async {
    if (indexSave != null) {
      for (var i = _challengeList.length - 1; i >= 0; i--) {
        if (_challengeList[i].id == _challengeListSave[indexSave].id) {
          _challengeList.removeAt(i);
        }
      }
      _challengeList.add(
        ChallengeModel(
            prelevementAutoBool:
                _challengeListSave[indexSave].prelevementAutoBool,
            echeancierBoll: _challengeListSave[indexSave].echeancierBoll,
            previsions: _challengeListSave[indexSave].previsions,
            restePaiement: _challengeListSave[indexSave].restePaiement,
            coutTotalBool: _challengeListSave[indexSave].coutTotalBool,
            prixTotalBool: _challengeListSave[indexSave].prixTotalBool,
            prixTotal: _challengeListSave[indexSave].prixTotal,
            coutTotal: _challengeListSave[indexSave].coutTotal,
            idChallenge: _challengeListSave[indexSave].idChallenge,
            idNotif: _challengeListSave[indexSave].idNotif,
            boolId: _challengeListSave[indexSave].boolId,
            id: _challengeListSave[indexSave].id,
            notification: _challengeListSave[indexSave].notification,
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

  void saveChallengelistId(int index) {
    if (_challengeList[index].notification.isEmpty) {
      for (var i = _challengeList[index].listeDeTache.length - 1; i >= 0; i--) {
        saveChallengelistRacourcci(index, i);
      }
    }
    print("2");
  }

  void saveChallengelistRacourcci(int index, int index2) {
    for (var n = _challengeList.length - 1; n >= 0; n--) {
      for (var i = _challengeList[n].idChallenge.length - 1; i >= 0; i--) {
        if (_challengeList[n].idChallenge[i] ==
            _challengeList[index].listeDeTache[index2].id) {
          addListChallengeSaveindex2(n);
        }
      }
    }
    print("1");
  }

  void addListChallengeSaveindex2(int index) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == _challengeList[index].id) {
        _challengeListSave.removeAt(i);
      }
    }
    _challengeListSave.add(
      ChallengeModel(
          prelevementAutoBool: _challengeList[index].prelevementAutoBool,
          echeancierBoll: _challengeList[index].echeancierBoll,
          previsions: _challengeList[index].previsions,
          restePaiement: _challengeList[index].restePaiement,
          coutTotalBool: _challengeList[index].coutTotalBool,
          prixTotalBool: _challengeList[index].prixTotalBool,
          prixTotal: _challengeList[index].prixTotal,
          coutTotal: _challengeList[index].coutTotal,
          idChallenge: _challengeList[index].idChallenge,
          idNotif: _challengeList[index].idNotif,
          boolId: _challengeList[index].boolId,
          id: _challengeList[index].id,
          notification: _challengeList[index].notification,
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
  }

  void addListChallengeSaveindex(int index) async {
    _challengeList[index].animatedpadding = true;
    await _save();
    _initChallengeList();
    notifyListeners();
    saveChallengelistId(index);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == _challengeList[index].id) {
        _challengeListSave.removeAt(i);
      }
    }
    _challengeListSave.add(
      ChallengeModel(
          prelevementAutoBool: _challengeList[index].prelevementAutoBool,
          echeancierBoll: _challengeList[index].echeancierBoll,
          previsions: _challengeList[index].previsions,
          restePaiement: _challengeList[index].restePaiement,
          coutTotalBool: _challengeList[index].coutTotalBool,
          prixTotalBool: _challengeList[index].prixTotalBool,
          prixTotal: _challengeList[index].prixTotal,
          coutTotal: _challengeList[index].coutTotal,
          idChallenge: _challengeList[index].idChallenge,
          idNotif: _challengeList[index].idNotif,
          boolId: _challengeList[index].boolId,
          id: _challengeList[index].id,
          notification: _challengeList[index].notification,
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
    if (_challengeList[index].previsions > 0) {
      for (var i = _challengeListSave.length - 1; i >= 0; i--) {
        if (_challengeListSave[i].id == _challengeList[index].id) {
          _challengeListSave[i].previsions = _challengeListSave[i].previsions -
              _challengeListSave[i].prixTotal;
          _challengeListSave[i].prixTotal = 0;
          _challengeListSave[i].totalChallenge =
              _challengeListSave[i].listeDeTache.length.toString();
        }
      }
    }
    if (_challengeList[index].coutTotal > 0) {
      for (var i = _challengeListSave.length - 1; i >= 0; i--) {
        if (_challengeListSave[i].id == _challengeList[index].id) {
          _challengeListSave[i].coutTotal = _challengeListSave[i].restePaiement;
          _challengeListSave[i].restePaiement =
              _challengeListSave[i].restePaiement;
          _challengeListSave[i].totalChallenge =
              _challengeListSave[i].listeDeTache.length.toString();
        }
      }
    }

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
              prelevementAutoBool: _challengeList[i].prelevementAutoBool,
              echeancierBoll: _challengeList[i].echeancierBoll,
              previsions: _challengeList[i].previsions,
              restePaiement: _challengeList[i].restePaiement,
              coutTotalBool: _challengeList[i].coutTotalBool,
              prixTotalBool: _challengeList[i].prixTotalBool,
              prixTotal: _challengeList[i].prixTotal,
              coutTotal: _challengeList[i].coutTotal,
              idChallenge: _challengeList[i].idChallenge,
              idNotif: _challengeList[i].idNotif,
              boolId: _challengeList[i].boolId,
              id: _challengeList[i].id,
              notification: _challengeList[i].notification,
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
        _initChallengeList();
        notifyListeners();
        return;
      }
    }
  }

  List<String> listeDeYoutube(int index) {
    List<String> youtubeList = [];
    print(_challengeList[index].id);
    for (var n = _challengeList[index].listeDeTache.length - 1; n >= 0; n--) {
      print(_challengeList[index]
          .listeDeTache[n]
          .description
          .toString()
          .replaceAll(unityPattern, ""));
      if (_challengeList[index]
              .listeDeTache[n]
              .description
              .toString()
              .replaceAll(unityPattern, "") ==
          "unity_challenge1.youtube") {
        youtubeList
            .add(getIdFromUrl(_challengeList[index].listeDeTache[n].name));
      }
    }
    return youtubeList;
  }

  int returnIndexForName(String id) {
    int index;
    for (var i = _challengeList.length - 1; i >= 0; i--) {
      if (_challengeList[i].id == id) {
        index = i;
        return index;
      }
    }
    return null;
  }

  void desactivAffichagePrinc(int index, bool boolId) async {
    _challengeList[index].boolId = boolId;
    if (_challengeList[index].animatedpadding) {
      desactivAffichagePrincAnimattingPaddind(index, boolId);
    }

    await _save();
    _initChallengeList();
    notifyListeners();
  }

  void desactivAffichagePrincAnimattingPaddind(int index, bool boolId) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == _challengeList[index].id) {
        _challengeListSave[i].boolId = boolId;
        await _saveSauvegarde();
        _initChallengeList();
        notifyListeners();
        return;
      }
    }
  }

  void raccourciChallengeSave(
      {List<String> raccourci, String name, String idChallenge}) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      for (var n = raccourci.length - 1; n >= 0; n--) {
        if (_challengeListSave[i].id == raccourci[n]) {
          _challengeListSave[i].idChallenge.add(idChallenge);
        }
      }
    }
    await _saveSauvegarde();
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
    }
    raccourciChallengeSave(
        raccourci: raccourci, name: name, idChallenge: idChallenge);
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
    if (_challengeListSave[index].idNotif.isNotEmpty) {
      for (var n = _challengeListSave[index].idNotif.length - 1; n >= 0; n--) {
        cancelNotificationById(int.parse(_challengeListSave[index].idNotif[n]));
      }
      for (var i = _challengeList.length - 1; i >= 0; i--) {
        if (_challengeList[i].id == _challengeListSave[index].id) {
          _challengeList[i].idNotif = [];
          _challengeList[i].animatedpadding = false;
          await _save();
        }
      }
    }
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

  void removeChallengelistId(int index) {
    if (!_challengeList[index].animatedpadding) {
      for (var i = _challengeList[index].listeDeTache.length - 1; i >= 0; i--) {
        removeChallengelistRacourcci(index, i);
      }
    }
  }

  void removeChallengelistRacourcci(int index, int index2) async {
    for (var n = _challengeList.length - 1; n >= 0; n--) {
      for (var i = _challengeList[n].idChallenge.length - 1; i >= 0; i--) {
        if (_challengeList[n].idChallenge[i] ==
            _challengeList[index].listeDeTache[index2].id) {
          _challengeList.removeAt(n);
        }
      }
    }
  }

  void remove(
      {@required int index,
      @required bool validate,
      String id,
      String idChallenge}) async {
    // await removeChallengelistId(index);
    _challengeList.removeAt(index);
    await _save(remove: true);
    _initChallengeList();
    notifyListeners();
    if (!validate) {
      for (var i = _challengeListSave.length - 1; i >= 0; i--) {
        if (_challengeListSave[i].id == id &&
            _challengeListSave[i].animatedpadding) {
          _challengeListSave.removeAt(i);
          await _saveSauvegarde(remove: true);
          return;
        }
      }
    }
  }

  voidremove2Save(
      {@required String unitChallenge,
      @required String id,
      @required double prix,
      @required double cout,
      @required int indexSave,
      @required int index,
      @required String idChallenge,
      bool validate}) async {
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == idChallenge) {
        var additionchallenge = _challengeListSave[i].totalChallenge;
        _challengeListSave[i].totalChallenge =
            (int.parse(additionchallenge) - 1).toString();
        if (prix > 0) {
          _challengeListSave[i].previsions =
              _challengeListSave[i].previsions - prix;
        }
        if (cout > 0 && unitChallenge != "echeancier") {
          _challengeListSave[i].coutTotal =
              _challengeListSave[i].coutTotal - cout;
          _challengeListSave[i].restePaiement = _challengeListSave[i].coutTotal;
        }
        if (cout > 0 && unitChallenge == "echeancier") {
          _challengeListSave[i].coutTotal =
              _challengeListSave[i].coutTotal - cout;
          _challengeListSave[i].restePaiement =
              _challengeListSave[i].restePaiement - cout;
        }

        for (var n = _challengeListSave[i].listeDeTache.length - 1;
            n >= 0;
            n--) {
          if (_challengeListSave[i].listeDeTache[n].id == id) {
            _challengeListSave[i].listeDeTache.removeAt(n);
            await _save1Sauvegarde(remove: true, idChallenge: idChallenge);
            return;
          }
        }
      }
    }
  }

  void remove2(
      {@required String id,
      @required String unitChallenge,
      @required double cout,
      @required double prix,
      @required int indexSave,
      @required int index,
      @required String idChallenge,
      @required bool validate}) async {
    if (validate) {
      prixTotalAdd(indexSave, prix);
      // restePaiementTotalRemove(indexSave, cout, unitChallenge, id, idChallenge);
    }
    if (!validate) {
      var additionchallenge = _challengeList[indexSave].totalChallenge;
      _challengeList[indexSave].totalChallenge =
          (int.parse(additionchallenge) - 1).toString();
      if (prix > 0) {
        _challengeList[indexSave].previsions =
            _challengeList[indexSave].previsions - prix;
      }
      if (cout > 0 && unitChallenge != "echeancier") {
        _challengeList[indexSave].coutTotal =
            _challengeList[indexSave].coutTotal - cout;
        _challengeList[indexSave].restePaiement =
            _challengeList[indexSave].coutTotal;
      } else if (cout > 0 && unitChallenge == "echeancier") {
        _challengeList[indexSave].coutTotal =
            _challengeList[indexSave].coutTotal - cout;
        _challengeList[indexSave].restePaiement =
            _challengeList[indexSave].restePaiement - cout;
      }

      await voidremove2Save(
          unitChallenge: unitChallenge,
          cout: cout,
          prix: prix,
          id: id,
          indexSave: indexSave,
          index: index,
          idChallenge: idChallenge,
          validate: validate);
    }

    _challengeList[indexSave].listeDeTache.removeAt(index);

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
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'Error!';
    }
  }

  void saveNotification(ChallengeModel listChallenge) {
    if (listChallenge.animatedpadding && listChallenge.quotidient == true) {
      scheduleQuotidiendNotification(
          channelID: listChallenge.idNotif[0],
          channelName: listChallenge.name,
          channelDesc: listChallenge.description,
          notificationId: int.parse(listChallenge.idNotif[0]),
          notificationTitle: 'Date Tracker Test',
          notificationBody: 'We are showing notification!',
          hours: int.parse(listChallenge.notification));
    } else if (listChallenge.animatedpadding &&
        listChallenge.totalDays.isNotEmpty) {
      for (var n = listChallenge.totalDays.length - 1; n >= 0; n--) {
        scheduleHebdodNotification(
            channelID: listChallenge.idNotif[n],
            channelName: listChallenge.name,
            channelDesc: listChallenge.description,
            notificationId: int.parse(listChallenge.idNotif[n]),
            notificationTitle: 'Date Tracker Test',
            notificationBody: 'We are showing notification!',
            weekdays: listChallenge.totalDays[n],
            hours: int.parse(listChallenge.notification));
      }
    } else if (listChallenge.animatedpadding && listChallenge.date.isNotEmpty) {
      scheduleMonthdNotification(
          channelID: listChallenge.idNotif[0],
          channelName: listChallenge.name,
          channelDesc: listChallenge.description,
          notificationId: int.parse(listChallenge.idNotif[0]),
          notificationTitle: 'Date Tracker Test',
          notificationBody: 'We are showing notification!',
          days: int.parse(listChallenge.date),
          hours: int.parse(listChallenge.notification));
    }
  }

  void uploadChallenge() async {
    ChallengeModel uploadFileChallenge;
    Map _jsonDecodeuploadFile;
    String uploadFile = await readContent();
    if (uploadFile != null) {
      _jsonDecodeuploadFile = jsonDecode(uploadFile);
      uploadFileChallenge = ChallengeModel.fromJSON(_jsonDecodeuploadFile);
      saveNotification(uploadFileChallenge);
      addChallenge(
          prelevementAutoBool: uploadFileChallenge.prelevementAutoBool,
          echeancierBoll: uploadFileChallenge.echeancierBoll,
          previsions: uploadFileChallenge.previsions,
          restePaiement: uploadFileChallenge.restePaiement,
          coutTotalBool: uploadFileChallenge.prixTotalBool,
          prixTotalBool: uploadFileChallenge.prixTotalBool,
          prixTotal: uploadFileChallenge.prixTotal,
          coutTotal: uploadFileChallenge.coutTotal,
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

  modifDtabaseFirebase() {
    DateTime today = new DateTime.now();
    String documentId = challengeyesterday.nbtacheVallide;
    final databaseReference = FirebaseFirestore.instance;
    // print("documentID:" + challengeyesterday.nbtacheVallide);
    try {
      databaseReference.collection("activation").doc(documentId).update({
        // "LastConnect": DateFormat('EEEE, d MMM, yyyy').format(today),
        "LastConnect": "date test",
      });
    } catch (e) {
      print(e.toString());
    }
  }

  initialiseConnectionDatabase() async {
    final databaseReference = FirebaseFirestore.instance;
    DateTime today = new DateTime.now();

    try {
      await databaseReference.collection("activation").add({
        "Achat": false,
        "activation": false,
        "IdCommade": "pas d'ID",
        "Installation": true,
        "LastConnect": DateFormat('EEEE, d MMM, yyyy').format(today),
        "Restor": false
      }).then((value) => challengeyesterday.nbtacheVallide = value.id);
    } catch (e) {
      print(e.toString());
    }
  }

  void getBoolActivation() async {
    String documentId = challengeyesterday.nbtacheVallide;
    // print('documentId:' + documentId);
    final databaseReference = FirebaseFirestore.instance;
    var a =
        await databaseReference.collection("activation").doc(documentId).get();
    if (a.exists) {
      final DocumentReference documentReference =
          databaseReference.collection("activation").doc(documentId);
      print(documentReference);
    }
  }
}
