import 'package:date_time_picker/date_time_picker.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/build_challenge_list.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/screens/components/home_screen1.dart';
import 'package:icandoit/screens/components/purchase_app.dart';
import 'package:icandoit/screens/inn_app_purchase.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:nanoid/nanoid.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:lottie/lottie.dart';

import 'components/challenge_list_save.dart';
import 'components/resultat_challenge.dart';

class Home extends StatefulWidget {
  final String id;
  final String namechallenge;
  final String idChallenge1;
  final bool returnRaccourci;
  Home(
      {@required this.returnRaccourci,
      @required this.namechallenge,
      @required this.id,
      @required this.idChallenge1});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  String heureTotal;
  bool dateBool;
  bool notificationBool;
  bool hebdoBool;
  List<String> idChallenge = [];
  bool boolid = true;
  List<String> idNotif = [];
  String dateQuotidien;
  String notification = "";
  bool animatedpadding = false;
  bool quotidient = false;
  List<String> totalDays = [];
  String date = "";
  String date1;
  String heure;
  List<String> totalChangeListChal = [];
  List _changeLiatChall;
  String _myChangeListChall;
  List _myActivities;
  String _myActivitiesResult;
  bool visibility = false;
  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myChangeListChall = _changeLiatChall.toString();
        _myActivitiesResult = _myActivities.toString();
        totalChangeListChal = _changeLiatChall.toString() as List<String>;
        totalDays = _myActivities.toString() as List<String>;
      });
    }
  }

  List<String> idCHallengeFirat(String idChalleneString) {
    List<String> idchal = [];
    if (idChalleneString.isNotEmpty) {
      idchal.add(idChalleneString);
    }

    return idchal;
  }

  void saveNotification(String nom, String description, List<String> idNotif) {
    Challengecontroller variable1 =
        Provider.of<Challengecontroller>(context, listen: false);
    if (quotidient) {
      // print("quotidien:" + quotidient.toString());
      // print(nom);
      // print(description);
      // print(dateQuotidien);
      variable1.scheduleQuotidiendNotification(
          channelID: idNotif[0],
          channelName: nom,
          channelDesc: description,
          notificationId: int.parse(idNotif[0]),
          notificationTitle: 'Date Tracker Test',
          notificationBody: 'We are showing notification!',
          hours: int.parse(dateQuotidien));
    } else if (hebdoBool) {
      // print("hebdoBool:" + hebdoBool.toString());
      // print(nom);
      // print(description);
      // print(heure);
      for (var n = totalDays.length - 1; n >= 0; n--) {
        print(totalDays[n]);
        print(idNotif[n]);
      }
      for (var n = totalDays.length - 1; n >= 0; n--) {
        variable1.scheduleHebdodNotification(
            channelID: idNotif[n],
            channelName: nom,
            channelDesc: description,
            notificationId: int.parse(idNotif[n]),
            notificationTitle: 'Date Tracker Test',
            notificationBody: 'We are showing notification!',
            weekdays: totalDays[n],
            hours: int.parse(heure));
      }
    } else if (dateBool) {
      print("dateBool:" + dateBool.toString());
      variable1.scheduleMonthdNotification(
          channelID: idNotif[0],
          channelName: nom,
          channelDesc: description,
          notificationId: int.parse(idNotif[0]),
          notificationTitle: 'Date Tracker Test',
          notificationBody: 'We are showing notification!',
          days: int.parse(date),
          hours: int.parse(dateQuotidien));
    } else if (notificationBool) {
      print("notificationBool:" + notificationBool.toString());
      variable1.scheduledNotifNotification(
          channelID: idNotif[0],
          channelName: nom,
          channelDesc: description,
          notificationId: int.parse(idNotif[0]),
          notificationTitle: 'Date Tracker Test',
          notificationBody: 'We are showing notification!',
          dateNotif: notification);
    }
  }

  Widget selectraccourci() {
    Widget raccourci = SizedBox(width: 1);
    if (widget.idChallenge1.isNotEmpty) {
      raccourci = Row(
        children: [
          Icon(
            Icons.update,
            size: 30.0,
          ),
          SizedBox(width: 10),
          Text("Raccourci"),
        ],
      );
    }
    return raccourci;
  }

  Widget selectdropdown(String resultat, List<ChallengeModel> challengesList) {
    Widget documentJoint = SizedBox(width: 1.0);

    if (widget.idChallenge1.isNotEmpty && resultat == "raccourci") {
      updateController1(true);
      List<ChallengeModel> _challengesList =
          challengesList.where((c) => c.id != widget.id).toList();
      documentJoint = Column(
        children: [
          MultiSelectFormField(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            title: Text("Choix"),
            autovalidate: AutovalidateMode.disabled,
            validator: (value) {
              if (value.isEmpty) {
                return "Merci d'entrer un nom pour le challenge";
              }
              return null;
            },
            dataSource: [
              for (var i = _challengesList.length - 1; i >= 0; i--)
                {
                  "display": _challengesList[i].name,
                  "value": _challengesList[i].id,
                },
            ],
            textField: 'display',
            valueField: 'value',
            okButtonLabel: 'OK',
            cancelButtonLabel: 'CANCEL',
            initialValue: _changeLiatChall,
            onSaved: (value) {
              if (value == null) return;
              setState(() {
                _changeLiatChall = value;
                for (var i = _changeLiatChall.length - 1; i >= 0; i--) {
                  totalChangeListChal.add(_changeLiatChall[i].toString());
                }
              });
            },
          ),
        ],
      );
    } else if (resultat == "raccourci") {
      retour();
    } else if (resultat == "quotidien") {
      visibility = false;
      documentJoint = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent,
            ),
            margin: EdgeInsets.only(left: 15.0),
            child: Text(
              'Heure',
              style: TextStyle(fontSize: 17),
            ),
          ),
          SizedBox(width: 15.0),
          Container(
            width: 150,
            child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(15.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.0, color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(15.0)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                isExpanded: true,
                value: dateQuotidien,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 30,
                onChanged: (String newValue) {
                  setState(() {
                    dateQuotidien = newValue;
                    heureTotal = newValue;
                  });
                },
                items: <String>[
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                  '11',
                  '12',
                  '13',
                  '14',
                  '15',
                  '16',
                  '17',
                  '18',
                  '19',
                  '20',
                  '21',
                  '22',
                  '23',
                  '24',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ),
        ],
      );
    } else if (resultat == "hebdomadaire") {
      visibility = false;
      documentJoint = Column(
        children: [
          MultiSelectFormField(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            title: Text("Choix"),
            autovalidate: AutovalidateMode.disabled,
            validator: (value) {
              if (value.isEmpty) {
                return "Merci d'entrer un nom pour le challenge";
              }
              return null;
            },
            dataSource: [
              {
                "display": "Lundi",
                "value": "Lundi",
              },
              {
                "display": "Mardi",
                "value": "Mardi",
              },
              {
                "display": "Mercredi",
                "value": "Mercredi",
              },
              {
                "display": "Jeudi",
                "value": "Jeudi",
              },
              {
                "display": "Vendredi",
                "value": "Vendredi",
              },
              {
                "display": "Samedi",
                "value": "Samedi",
              },
              {
                "display": "Dimanche",
                "value": "Dimanche",
              },
            ],
            textField: 'display',
            valueField: 'value',
            okButtonLabel: 'OK',
            cancelButtonLabel: 'CANCEL',
            initialValue: _myActivities,
            onSaved: (value) {
              if (value == null) return;
              setState(() {
                idNotif = [];
                date = "";
                totalDays = [];
                _myActivities = value;
                for (var i = _myActivities.length - 1; i >= 0; i--) {
                  totalDays.add(_myActivities[i].toString());
                }
                notificationBool = false;
                quotidient = false;
                dateBool = false;
                hebdoBool = true;
                animatedpadding = true;
              });
            },
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(_myActivitiesResult),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Heure',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(width: 15.0),
              Container(
                width: 150,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15.0)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    isExpanded: true,
                    value: heure,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 30,
                    onChanged: (String newValue) {
                      setState(() {
                        heure = newValue;
                        heureTotal = newValue;
                      });
                    },
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '16',
                      '17',
                      '18',
                      '19',
                      '20',
                      '21',
                      '22',
                      '23',
                      '24',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
            ],
          ),
        ],
      );
    } else if (resultat == "mensuel") {
      visibility = false;
      documentJoint = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Date',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(width: 15.0),
              Container(
                width: 150,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15.0)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    isExpanded: true,
                    value: date1,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 30,
                    onChanged: (String newValue) {
                      setState(() {
                        idNotif = [];
                        totalDays = [];
                        date = newValue;
                        notificationBool = false;
                        quotidient = false;
                        hebdoBool = false;
                        dateBool = true;
                        animatedpadding = true;
                      });
                    },
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '16',
                      '17',
                      '18',
                      '19',
                      '20',
                      '21',
                      '22',
                      '23',
                      '24',
                      '25',
                      '26',
                      '27',
                      '28',
                      '29',
                      '30',
                      '31',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Heure',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(width: 15.0),
              Container(
                width: 150,
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15.0)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    isExpanded: true,
                    value: dateQuotidien,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 30,
                    onChanged: (String newValue) {
                      setState(() {
                        dateQuotidien = newValue;
                        heureTotal = newValue;
                        print(dateQuotidien);
                      });
                    },
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12',
                      '13',
                      '14',
                      '15',
                      '16',
                      '17',
                      '18',
                      '19',
                      '20',
                      '21',
                      '22',
                      '23',
                      '24',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
            ],
          ),
        ],
      );
    } else if (resultat == "notification") {
      visibility = false;
      documentJoint = Column(
        children: [
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText: 'Date',
            timeLabelText: "Heure",
            // selectableDayPredicate: (date) {
            //   if (date.weekday == 6 || date.weekday == 7) {
            //     return false;
            //   }

            //   return true;
            // },
            onChanged: (val) => print(val),
            validator: (val) {
              return null;
            },
            onSaved: (val) async {
              idNotif = [];
              date = "";
              totalDays = [];
              print(val);
              notification = val;
              notificationBool = true;
              quotidient = false;
              hebdoBool = false;
              dateBool = false;
              animatedpadding = false;
            },
          ),
        ],
      );
    }
    return documentJoint;
  }

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  String unityChallenge = "haute";
  String nameChallenge;
  String targetChallenge;
  List<Challengemodel2> challengeListTache = [];
  String totalChallenge = "0";
  FancyDrawerController _controller;
  void initState() {
    super.initState();

    quotidient = false;
    hebdoBool = false;
    dateBool = false;
    notificationBool = false;
    _myActivities = [];
    _myActivitiesResult = '';
    _controller =
        FancyDrawerController(vsync: this, duration: Duration(milliseconds: 50))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchMapsUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    return Material(
      child: FancyDrawerWrapper(
        hideOnContentTap: true,
        backgroundColor: Colors.white,
        controller: _controller,
        drawerItems: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable,
                      child: Home(
                        id: "",
                        idChallenge1: '',
                        namechallenge: '',
                        returnRaccourci: false,
                      ))));
            },
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: ExampleApp())));
            },
            child: Row(
              children: [
                Icon(Icons.save_rounded),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Sauvegarde",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: ResultaChallenge())));
            },
            child: Row(
              children: [
                Icon(FontAwesomeIcons.play),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Score ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              _launchMapsUrl(
                  "https://newaccount1626188315630.freshdesk.com/support/solutions");
            },
            child: Row(
              children: [
                Icon(Icons.support),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Support",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              _launchMapsUrl("https://easytodo.fr");
            },
            child: Row(
              children: [
                Icon(Icons.policy),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "À propos",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: HomeScreen())));
            },
            child: Row(
              children: [
                Icon(Icons.book),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Intro",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
                 Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: ChangeNotifierProvider.value(
                      value: variable,
                      child: PurchaseApp( ))));
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //         value: variable, child: PurchaseApp())));
              // Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(Icons.store),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Acheter",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        child: Scaffold(
          key: scaffoldkey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: SafeArea(
              child: AppBar(
                elevation: 0,
                title: Text(
                    widget.idChallenge1.isEmpty ? "" : widget.namechallenge),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 10),
                    child: SizedBox.fromSize(
                      size: Size(50, 50), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Colors.purple, // button color
                          child: InkWell(
                            // splash color
                            splashColor: Colors.white,
                            onTap: () {
                              variable.uploadChallenge();
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.upload_sharp,
                                  size: 20,
                                  color: Colors.white,
                                ), // icon
                                Text(
                                  "Upload",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.idChallenge1.isNotEmpty
                      ? IconButton(
                          alignment: Alignment.topRight,
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _controller.toggle();
                          },
                        )
                      : SizedBox(width: 10),
                ],
                leading: widget.idChallenge1.isEmpty
                    ? IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          _controller.toggle();
                        },
                      )
                    : null,
                centerTitle: true,
                flexibleSpace: Container(
                  padding: EdgeInsets.only(top: 40.0),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 55,
                    height: 130,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[Colors.purple, Colors.blue])),
                ),
              ),
            ),
          ),
          body: Shimmer(
            duration: Duration(seconds: 3),
            interval: Duration(seconds: 5),
            color: Colors.white,
            enabled: true,
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.purple, Colors.blue])),
              child: ChallengesListBuilder(
                idChallenge: widget.idChallenge1,
                selectbool: false,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: buildBottomSheet(),
        ),
      ),
    );
  }

  updateController(dynamic value) {
    _bottomSheetController.setState(() {
      unityChallenge = value;
    });
  }

  updateController1(bool visibility1) async {
    await delay(500);
    _bottomSheetController.setState(() {
      visibility = visibility1;
    });
  }

  retour() async {
    await delay(500);
    Navigator.pop(context);
    unityChallenge = "haute";
  }

  FloatingActionButton buildBottomSheet() {
    return FloatingActionButton(
        // child: Lottie.asset('assets/float.json'),
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[900],
        onPressed: () {
          _bottomSheetController = scaffoldkey.currentState.showBottomSheet(
            (context) {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: [
                          IconButton(
                            alignment: Alignment.topRight,
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Offstage(
                            offstage: visibility,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              onSaved: (value) {
                                nameChallenge = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Merci d'entrer un nom pour le challenge";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  helperText: "Exemple : 'Tâche quotidienne '",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  labelText: "Nom de la mission",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Offstage(
                            offstage: visibility,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              onSaved: (value) {
                                targetChallenge = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Merci d'entrer une description pour la mission";
                                } else if (value.length > 35) {
                                  return "Pas plus de 50 caractères";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  helperText: "Exemple : 'Liste des tâches'",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2.0, color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.blueAccent),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: "Description",
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                            value: unityChallenge,
                            onChanged: (value) {
                              updateController(value);
                            },
                            onSaved: (value) {
                              updateController(value);
                            },
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: "haute",
                                child: Row(
                                  children: [
                                    Icon(Icons.update,
                                        size: 30.0, color: Colors.red),
                                    SizedBox(width: 10),
                                    Text("Haute",
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "normal",
                                child: Row(
                                  children: [
                                    Icon(Icons.auto_fix_normal,
                                        size: 30.0, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text(
                                      "Normal",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "quotidien",
                                child: Row(
                                  children: [
                                    Icon(Icons.view_day,
                                        size: 30.0, color: Colors.orange),
                                    SizedBox(width: 10),
                                    Text("Quotidien",
                                        style: TextStyle(color: Colors.orange)),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "hebdomadaire",
                                child: Row(
                                  children: [
                                    Icon(Icons.view_week,
                                        size: 30.0, color: Colors.orange),
                                    SizedBox(width: 10),
                                    Text("Hebdomadaire",
                                        style: TextStyle(color: Colors.orange)),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "mensuel",
                                child: Row(
                                  children: [
                                    Icon(Icons.date_range,
                                        size: 30.0, color: Colors.orange),
                                    SizedBox(width: 10),
                                    Text("Mensuel",
                                        style: TextStyle(color: Colors.orange)),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "notification",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Notification"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "raccourci",
                                child: selectraccourci(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          selectdropdown(
                              unityChallenge,
                              Provider.of<Challengecontroller>(context)
                                  .getChallenges()),
                          Center(
                            child: IconButton(
                              iconSize: 60,
                              alignment: Alignment.topRight,
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.orange[900],
                              ),
                              onPressed: () {
                                if (unityChallenge == "raccourci") {
                                  Provider.of<
                                              Challengecontroller>(context,
                                          listen: false)
                                      .raccourciChallenge(
                                          raccourci: totalChangeListChal
                                              .toSet()
                                              .toList(),
                                          name: nameChallenge,
                                          idChallenge: widget.idChallenge1);
                                  Navigator.pop(context);
                                } else if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  {
                                    if (unityChallenge == "notification") {
                                      heureTotal = '';
                                    } else if (unityChallenge == "quotidien") {
                                      idNotif = [];
                                      date = "";
                                      totalDays = [];
                                      notificationBool = false;
                                      hebdoBool = false;
                                      dateBool = false;
                                      quotidient = true;
                                      animatedpadding = true;
                                    } else if (unityChallenge == "normal" ||
                                        unityChallenge == "haute") {
                                      totalDays = [];
                                      date = "";
                                      animatedpadding = false;
                                      quotidient = false;
                                      dateBool = false;
                                      notificationBool = false;
                                      hebdoBool = false;
                                      idNotif = [];
                                      heureTotal = '';
                                    }
                                    if (quotidient ||
                                        dateBool ||
                                        notificationBool) {
                                      idNotif
                                          .add(customAlphabet("0123456789", 2));
                                    } else if (hebdoBool) {
                                      for (var n = totalDays.length - 1;
                                          n >= 0;
                                          n--) {
                                        idNotif.add(
                                            customAlphabet("0123456789", 2));
                                      }
                                    }

                                    Provider.of<Challengecontroller>(context,
                                            listen: false)
                                        .addChallenge(
                                            prelevementAutoBool: false,
                                            echeancierBoll: false,
                                            restePaiement: 0,
                                            previsions: 0,
                                            coutTotalBool: false,
                                            prixTotalBool: false,
                                            prixTotal: 0,
                                            coutTotal: 0,
                                            boolId: true,
                                            idNotif: idNotif,
                                            idChallenge: idCHallengeFirat(
                                                widget.idChallenge1),
                                            id: nanoid(11),
                                            notifiaction: heureTotal,
                                            date: date,
                                            totalDays:
                                                totalDays.toSet().toList(),
                                            quotidient: quotidient,
                                            animatedpadding: animatedpadding,
                                            name: nameChallenge,
                                            totalChallenge: totalChallenge,
                                            description: targetChallenge,
                                            unity: unityChallenge,
                                            challengeListTache:
                                                challengeListTache);
                                    saveNotification(nameChallenge,
                                        targetChallenge, idNotif);

                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          );
        });
  }
}
