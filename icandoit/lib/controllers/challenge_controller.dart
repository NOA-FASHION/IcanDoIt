import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:nanoid/nanoid.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';
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
    // print(customAlphabet("0123456789", 4));
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
    paiemtBool = false;
    // print('test unitaire');
    _initChallengeListStartChallenge();

    notifyListeners();
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

  tz.TZDateTime _nextInstanceOfMondayTenAM(int hours, String Weekdays) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM(hours);
    while (scheduledDate.weekday != transformDate(Weekdays)) {
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
    print(scheduledDate.toString());
    return scheduledDate;
  }

  tz.TZDateTime _nextInstancNotifeOfTenAM(String dateNotif) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.parse(tz.local, dateNotif);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    // print(scheduledDate.toString());
    return scheduledDate;
  }

  int transformDate(String days) {
    int daysFinal = 1;
    if (days == "Lundi") {
      daysFinal = DateTime.monday;
    } else if (days == "Mardi") {
      daysFinal = DateTime.tuesday;
    } else if (days == "Mercredi") {
      daysFinal = DateTime.wednesday;
    } else if (days == "Jeudi") {
      daysFinal = DateTime.thursday;
    } else if (days == "Vendredi") {
      daysFinal = DateTime.friday;
    } else if (days == "Samedi") {
      daysFinal = DateTime.saturday;
    } else if (days == "Dimanche") {
      daysFinal = DateTime.sunday;
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
    // DateTime scheduledNotificationDateTime = notificationTime;

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
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
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
    // DateTime scheduledNotificationDateTime = notificationTime;

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
        _nextInstancDayeOfTenAM(days, hours),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
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
    // DateTime scheduledNotificationDateTime = notificationTime;

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
        _nextInstanceOfMondayTenAM(hours, weekdays),
        notificationDetails,
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
    // DateTime scheduledNotificationDateTime = notificationTime;

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
        _nextInstanceOfTenAM(hours),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
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
          coutTotalBool: _challengeListSave[index].coutTotalBool,
          prixTotalBool: _challengeListSave[index].prixTotalBool,
          prixTotal: _challengeListSave[index].prixTotal,
          coutTotal: _challengeListSave[index].coutTotal,
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

  double differenceCoutPaiement(int index) {
    double paiement = 0;
    for (var i = _challengeList[index].listeDeTache.length - 1; i >= 0; i--) {
      if (_challengeList[index].listeDeTache[i].description.toString() ==
          "unity_challenge1.paiement") {
        paiement = paiement + _challengeList[index].listeDeTache[i].cout;
      }
    }

    return paiement;
  }

  double totalPrevision(int index) {
    double prevision = 0;
    for (var i = _challengeList[index].listeDeTache.length - 1; i >= 0; i--) {
      print(_challengeList[index].listeDeTache[i].tache.toString());
      if (_challengeList[index].listeDeTache[i].tache.toString() ==
          "unity_challenge1.achat") {
        prevision = prevision + _challengeList[index].listeDeTache[i].prix;
      }
    }
    return prevision;
  }

  void prixTotalAdd(int index, double prix) {
    if (prix > 0) {
      _challengeList[index].prixTotal = _challengeList[index].prixTotal + prix;
    }
  }

  void coutTotalAdd(int index, double cout) {
    if (cout > 0) {
      _challengeList[index].coutTotal = _challengeList[index].coutTotal + cout;
    }
    print(_challengeList[index].name);
  }

  void activePrixBool(double prix, int index) {
    if (prix > 0) {
      _challengeList[index].prixTotalBool = true;
      return;
    } else {
      _challengeList[index].prixTotalBool = false;
    }
  }

  void activeCoutBool(double cout, int index) {
    if (cout > 0) {
      _challengeList[index].coutTotalBool = true;
      return;
    } else {
      _challengeList[index].coutTotalBool = false;
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
    // prixTotalAdd(index, prix);

    coutTotalAdd(index, cout);
    activePrixBool(prix, index);
    activeCoutBool(cout, index);
    // something = nameListChallenge;
    // for (var i = _challengeList.length - 1; i >= 0; i--) {}
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
      {@required bool coutTotalBool,
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
          coutTotalBool: coutTotalBool,
          prixTotalBool: prixTotalBool,
          prixTotal: prixTotal,
          coutTotal: coutTotal,
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
      }
      _challengeList.add(
        ChallengeModel(
            coutTotalBool: _challengeListSave[indexSave].coutTotalBool,
            prixTotalBool: _challengeListSave[indexSave].prixTotalBool,
            prixTotal: _challengeListSave[indexSave].prixTotal,
            coutTotal: _challengeListSave[indexSave].coutTotal,
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

  void saveChallengelistId(int index) {
    if (!_challengeList[index].animatedpadding) {
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
          coutTotalBool: _challengeList[index].coutTotalBool,
          prixTotalBool: _challengeList[index].prixTotalBool,
          prixTotal: _challengeList[index].prixTotal,
          coutTotal: _challengeList[index].coutTotal,
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
  }

  void addListChallengeSaveindex(int index) async {
    saveChallengelistId(index);
    for (var i = _challengeListSave.length - 1; i >= 0; i--) {
      if (_challengeListSave[i].id == _challengeList[index].id) {
        _challengeListSave.removeAt(i);
      }
    }
    _challengeListSave.add(
      ChallengeModel(
          coutTotalBool: _challengeList[index].coutTotalBool,
          prixTotalBool: _challengeList[index].prixTotalBool,
          prixTotal: _challengeList[index].prixTotal,
          coutTotal: _challengeList[index].coutTotal,
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
              coutTotalBool: _challengeList[i].coutTotalBool,
              prixTotalBool: _challengeList[i].prixTotalBool,
              prixTotal: _challengeList[i].prixTotal,
              coutTotal: _challengeList[i].coutTotal,
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

  //A tester demain
  void removeChallengelistId(int index) {
    if (!_challengeList[index].animatedpadding) {
      for (var i = _challengeList[index].listeDeTache.length - 1; i >= 0; i--) {
        removeChallengelistRacourcci(index, i);
      }
    }
  }

  void removeChallengelistRacourcci(int index, int index2) {
    for (var n = _challengeList.length - 1; n >= 0; n--) {
      for (var i = _challengeList[n].idChallenge.length - 1; i >= 0; i--) {
        if (_challengeList[n].idChallenge[i] ==
            _challengeList[index].listeDeTache[index2].id) {
          _challengeList.removeAt(n);
        }
      }
    }
  }

  void remove({@required int index, @required bool validate, String id}) async {
    removeChallengelistId(index);
    _challengeList.removeAt(index);
    await _save(remove: true);

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

//A tester demain
  void removeChallengelistRacourcci2(String idListeChallenge) {
    for (var n = _challengeList.length - 1; n >= 0; n--) {
      for (var i = _challengeList[n].idChallenge.length - 1; i >= 0; i--) {
        if (_challengeList[n].idChallenge[i] == idListeChallenge) {
          _challengeList.removeAt(n);
        }
      }
    }
  }

  void deActiveCoutBool(double prix, int index) {
    for (var i = _challengeList[index].listeDeTache.length - 1; i >= 0; i--) {
      if (_challengeList[index].listeDeTache[i].description.toString() ==
          "unity_challenge1.paiement") {
        _challengeList[index].coutTotalBool = true;
        return;
      } else {
        _challengeList[index].coutTotalBool = false;
      }
    }
  }

  void deActivePrixBool(double prix, int index) {
    for (var i = _challengeList[index].listeDeTache.length - 1; i >= 0; i--) {
      if (_challengeList[index].listeDeTache[i].description.toString() ==
          "unity_challenge1.achat") {
        _challengeList[index].prixTotalBool = true;
        return;
      } else {
        _challengeList[index].prixTotalBool = false;
      }
    }
  }

  void remove2(
      {@required String id,
      @required double prix,
      @required int indexSave,
      @required int index,
      @required String idChallenge,
      @required bool validate}) async {
    deActiveCoutBool(prix, index);
    deActivePrixBool(prix, index);
    prixTotalAdd(indexSave, prix);

    if (!validate) {}

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
        removeChallengelistRacourcci2(
            _challengeList[indexSave].listeDeTache[index].id);
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
}
