import 'package:flutter/material.dart';
import 'package:icandoit/screens/components/build_challenge_list.dart';
import 'package:icandoit/controllers/challenge_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  final Challengecontroller _controller = Challengecontroller();
  Future<List> challengesData;
  String unityChallenge = "haute";
  String nameChallenge;
  String targetChallenge;

  @override
  void initState() {
    challengesData = _controller.initChallengeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          title: Text('ICanDoIt'),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: ChallengesListBuilder(
        controller: _controller,
        challenData: challengesData,
      ),
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
                              // final RegExp checkReg = RegExp(r'^\D+$');
                              if (value.isEmpty) {
                                return "Merci d'entrer un nom pour le challenge";
                              }
                              // else if (!checkReg.hasMatch(value)) {
                              //   return "$value";
                              // }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: "Nom de la mission"),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              targetChallenge = value;
                            },
                            validator: (value) {
                              // final _isInt = int.tryParse(value);
                              // if (_isInt == null) {
                              //   return "Merci d'entrer uniquement des chiffres";
                              // }
                              if (value.isEmpty) {
                                return "Merci d'entrer une description pour la mission";
                              } else if (value.length > 35) {
                                return "pas plus de 50 caracteres";
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: "Description"),
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
                                value: "haute",
                                child: Text("haute"),
                              ),
                              DropdownMenuItem(
                                value: "normal",
                                child: Text("normal"),
                              ),
                            ],
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                setState(() {
                                  challengesData = _controller.addChallenge(
                                      name: nameChallenge,
                                      description: targetChallenge,
                                      unity: unityChallenge);
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Ajouter la mission"),
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
