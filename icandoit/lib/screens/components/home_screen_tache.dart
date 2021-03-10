import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/build_challenge_list_tache.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeTaches extends StatefulWidget {
  final String something;
  final String percent;
  HomeTaches(this.something, this.percent);
  @override
  _HomeTachesState createState() =>
      _HomeTachesState(this.something, this.percent);
}

class _HomeTachesState extends State<HomeTaches> {
  double percentage(String percent) {
    var percent1;
    percent1 = (double.parse(percent) / 100);
    return percent1;
  }

  final String something;
  final String percent;
  _HomeTachesState(this.something, this.percent);
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _bottomSheetController;
  final Challengecontroller _controller = Challengecontroller();
  Future<List> challengesData;
  Future<List> challengesData2;
  String unityChallenge = "evenement";
  String nameChallenge = "Tache";
  String targetChallenge;
  String totalChallengeEnCours;
  int totaChallengeEnCours1 = 0;
  int index;

  @override
  void initState() {
    challengesData = _controller.initChallengeList1(something);
    challengesData2 = _controller.initChallengeList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SafeArea(
          child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ICanDoIt"),
                Container(
                  padding: EdgeInsets.all(8.0),
                ),
              ],
            ),
            flexibleSpace: Container(
              padding: EdgeInsets.only(right: 30.0),
              alignment: Alignment.centerRight,
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                elevation: 35.0,
                child: new CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: percentage(percent),
                  center: new Text(percent),
                  progressColor: Colors.green,
                ),
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
          child: ChallengesListBuilderTaches(
            controller: _controller,
            challenData: challengesData,
            nameChallenge: something,
          ),
        ),
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
                          RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                setState(() {
                                  // totaChallengeEnCours1 =
                                  //     totaChallengeEnCours1 + 1;
                                  // totalChallengeEnCours =
                                  //     totaChallengeEnCours1.toString();
                                  challengesData = _controller.addChallenge2(
                                      totalChallenge: '1',
                                      nameListChallenge: something,
                                      name: nameChallenge,
                                      description: unityChallenge,
                                      tache: targetChallenge);
                                });
                              }
                              Navigator.pop(context);
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
