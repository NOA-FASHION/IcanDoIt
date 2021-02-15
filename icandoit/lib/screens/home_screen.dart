import 'package:flutter/material.dart';
import 'package:icandoit/screens/components/build_challenge_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  String unityChallenge = "KG";
  String nameChallenge;
  String targetChallenge;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          title: Text('ICanDoIt'),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: ChallengesListBuilder(),
      backgroundColor: Color(0xff414a4c),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildBottomSheet(),
    );
  }

  updateController(dynamic value) {
    _bottomSheetController.setState(() {
      unityChallenge = value;
    });
  }

  FloatingActionButton buildBottomSheet() {
    return FloatingActionButton(
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
                        children: [
                          TextFormField(
                            onSaved: (value) {
                              nameChallenge = value;
                            },
                            validator: (value) {
                              final RegExp checkReg = RegExp(r'^\D+$');
                              if (value.isEmpty) {
                                return "Merci d'entrer un nom pour le challenge";
                              } else if (!checkReg.hasMatch(value)) {
                                return "$value";
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: "Nom du challenge"),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              targetChallenge = value;
                            },
                            validator: (value) {
                              final _isInt = int.tryParse(value);
                              if (_isInt == null) {
                                return "Merci d'entrer uniquement des chiffres";
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Objectif"),
                          ),
                          DropdownButtonFormField(
                            value: unityChallenge,
                            onChanged: (value) {
                              updateController(value);
                            },
                            onSaved: (value) {
                              updateController(value);
                            },
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: "KG",
                                child: Text("Kg"),
                              ),
                              DropdownMenuItem(
                                value: "KM",
                                child: Text("Km"),
                              ),
                            ],
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                              }
                            },
                            child: Text("Ajouter le challenge"),
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
