// import 'package:colour/colour.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/build_challenge_list.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter_document_picker/flutter_document_picker.dart';
// import 'package:slide_drawer/slide_drawer.dart';

import 'components/challenge_list_save.dart';
import 'components/resultat_challenge.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String dateQuotidien;
  String heure;
  String date;
  List _myActivities;
  String _myActivitiesResult;
  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  Widget selectdropdown(String resultat) {
    Widget documentJoint = SizedBox(
      width: 1.0,
    );
    if (resultat == "quotidien") {
      // _visibility1 = true;
      // wait = "assets/wait.json";
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
              'heure',
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
                // underline: SizedBox(),
                onChanged: (String newValue) {
                  setState(() {
                    dateQuotidien = newValue;
                  });
                },
                items: <String>[
                  '1 h',
                  '2 h',
                  '3 h',
                  '4 h',
                  '5 h',
                  '6 h',
                  '7 h',
                  '8 h',
                  '9 h',
                  '10 h',
                  '11 h',
                  '12 h',
                  '13 h',
                  '14 h',
                  '15 h',
                  '16 h',
                  '17 h',
                  '18 h',
                  '19 h',
                  '20 h',
                  '21 h',
                  '22 h',
                  '23 h',
                  '24 h',
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
      // _visibility1 = true;
      // wait = "assets/wait.json";
      documentJoint = Column(
        children: [
          MultiSelectFormField(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            title: Text("Choix"),
            autovalidate: false,
            // titleText: 'My workouts',
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
            // required: true,
            // hintText: 'Please choose one or more',
            initialValue: _myActivities,
            onSaved: (value) {
              if (value == null) return;
              setState(() {
                _myActivities = value;
              });
            },
          ),
          // Container(
          //   padding: EdgeInsets.all(8),
          //   child: RaisedButton(
          //     child: Text('Save'),
          //     onPressed: _saveForm,
          //   ),
          // ),
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
                  'heure',
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
                    // underline: SizedBox(),
                    onChanged: (String newValue) {
                      setState(() {
                        heure = newValue;
                      });
                    },
                    items: <String>[
                      '1 h',
                      '2 h',
                      '3 h',
                      '4 h',
                      '5 h',
                      '6 h',
                      '7 h',
                      '8 h',
                      '9 h',
                      '10 h',
                      '11 h',
                      '12 h',
                      '13 h',
                      '14 h',
                      '15 h',
                      '16 h',
                      '17 h',
                      '18 h',
                      '19 h',
                      '20 h',
                      '21 h',
                      '22 h',
                      '23 h',
                      '24 h',
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
                    value: date,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 30,
                    // underline: SizedBox(),
                    onChanged: (String newValue) {
                      setState(() {
                        date = newValue;
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
                  'heure',
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
                    // underline: SizedBox(),
                    onChanged: (String newValue) {
                      setState(() {
                        dateQuotidien = newValue;
                      });
                    },
                    items: <String>[
                      '1 h',
                      '2 h',
                      '3 h',
                      '4 h',
                      '5 h',
                      '6 h',
                      '7 h',
                      '8 h',
                      '9 h',
                      '10 h',
                      '11 h',
                      '12 h',
                      '13 h',
                      '14 h',
                      '15 h',
                      '16 h',
                      '17 h',
                      '18 h',
                      '19 h',
                      '20 h',
                      '21 h',
                      '22 h',
                      '23 h',
                      '24 h',
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
            timeLabelText: "Hour",
            selectableDayPredicate: (date) {
              // Disable weekend days to select from the calendar
              if (date.weekday == 6 || date.weekday == 7) {
                return false;
              }

              return true;
            },
            onChanged: (val) => print(val),
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) => print(val),
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
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: Home())));
              setState(() {});
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Go to home",
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
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: ExampleApp())));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.save_rounded),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Sauvegare challenge",
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
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable, child: ResultaChallenge())));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.save_rounded),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "score des challenges",
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
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //         value: variable, child: ExampleApp())));
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.support),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Support us",
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
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ChangeNotifierProvider.value(
              //         value: variable, child: Home())));
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.policy),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "About us",
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
                  // InkWell(
                  //   splashColor: Colors.purple,
                  //   onTap: () {
                  //     variable.uploadChallenge();
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 15),
                  //     child: Ink(
                  //       decoration: ShapeDecoration(
                  //         color: Colour('#265FBC'),
                  //         shape: CircleBorder(),
                  //       ),
                  //       child: Icon(
                  //         Icons.upload_sharp,
                  //         size: 40,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
                leading: IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _controller.toggle();
                  },
                ),
                centerTitle: true,
                flexibleSpace: Container(
                  padding: EdgeInsets.only(right: 30.0),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 60,
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
              child: ChallengesListBuilder(),
            ),
          ),
          // backgroundColor: Color(0xff414a4c),
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

  FloatingActionButton buildBottomSheet() {
    return FloatingActionButton(
        child: Lottie.asset('assets/float.json'),
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
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
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
                                labelText: "Nom de la mission",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              targetChallenge = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Merci d'entrer une description pour la mission";
                              } else if (value.length > 35) {
                                return "pas plus de 50 caracteres";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(15.0)),
                                labelText: "Description",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
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
                                    Icon(
                                      Icons.update,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("haute"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "normal",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.auto_fix_normal,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("normal"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "quotidien",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.view_day,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("quotidien"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "hebdomadaire",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.view_week,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("hebdomadaire"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "mensuel",
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 10),
                                    Text("mensuel"),
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
                                    Text("notification"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          selectdropdown(unityChallenge),
                          InkWell(
                              onTap: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  Provider.of<Challengecontroller>(context,
                                          listen: false)
                                      .addChallenge(
                                          name: nameChallenge,
                                          totalChallenge: totalChallenge,
                                          description: targetChallenge,
                                          unity: unityChallenge,
                                          challengeListTache:
                                              challengeListTache);

                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                  width: 120.0,
                                  height: 120.0,
                                  child: Lottie.asset('assets/save1.json'))),
                        ],
                      ),
                    ),
                  ));
            },
          );
        });
  }
}
