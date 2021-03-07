import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/build_challenge_list_tache.dart';
import 'package:icandoit/controllers/challenge_controller.dart';

class HomeTaches extends StatefulWidget {
  final String something;
  HomeTaches(this.something);
  @override
  _HomeTachesState createState() => _HomeTachesState(this.something);
}

class _HomeTachesState extends State<HomeTaches> {
  final String something;
  _HomeTachesState(this.something);
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  final Challengecontroller _controller = Challengecontroller();
  Future<List> challengesData;
  Future<List<ChallengeModel>> challengesData2;
  String unityChallenge = "evenement";
  String nameChallenge;
  String targetChallenge;

  @override
  void initState() {
    challengesData2 = _controller.initChallengeList();
    challengesData = _controller.initChallengeList1(something);
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
      body: ChallengesListBuilderTaches(
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
                              if (value.isEmpty) {
                                return "Merci d'entrer un nom pour le challenge";
                              }
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
                                value: "evenement",
                                child: Text("evenement"),
                              ),
                              DropdownMenuItem(
                                value: "achat",
                                child: Text("achat"),
                              ),
                              DropdownMenuItem(
                                value: "tache",
                                child: Text("tache"),
                              ),
                              DropdownMenuItem(
                                value: "mission",
                                child: Text("mission"),
                              ),
                              DropdownMenuItem(
                                value: "vente",
                                child: Text("vente"),
                              ),
                              DropdownMenuItem(
                                value: "choix",
                                child: Text("choix"),
                              ),
                              DropdownMenuItem(
                                value: "essai",
                                child: Text("essai"),
                              ),
                              DropdownMenuItem(
                                value: "validation",
                                child: Text("validation"),
                              ),
                              DropdownMenuItem(
                                value: "url",
                                child: Text("url"),
                              ),
                            ],
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                setState(() {
                                  challengesData = _controller.addChallenge2(
                                      nameListChallenge: something,
                                      name: nameChallenge,
                                      description: unityChallenge,
                                      tache: targetChallenge);
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
