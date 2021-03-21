import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../controllers/challenge_controller.dart';
import '../home_screen.dart';
import 'baseAlertDialog.dart';
import 'home_screen_tache.dart';

class ChallengesListBuilder extends StatefulWidget {
  @override
  _ChallengesListBuilderState createState() => _ChallengesListBuilderState();
}

class _ChallengesListBuilderState extends State<ChallengesListBuilder> {
  double percentage(int listeTache, int totalChallenge) {
    double percent1;
    if (listeTache != 0 && listeTache == totalChallenge) {
      percent1 = 0.00;
    } else if (listeTache != 0 && listeTache != totalChallenge) {
      percent1 = listeTache / totalChallenge;
    } else {
      percent1 = 0.00;
    }
    return percent1;
  }

  String maxLetter(String word) {
    var word2;
    word2 = word[0];
    if (word.length > 18) {
      for (var i = 1; i <= 18; i++) {
        word2 = word2 + word[i];
      }
    } else {
      word2 = word;
    }
    return word2;
  }

  Color changeColors(String challengeListeColors) {
    Color colors;
    if (challengeListeColors == "normal") {
      colors = Colors.green;
    } else if (challengeListeColors == "haute") {
      colors = Colors.red;
    } else if (challengeListeColors == "Moyen") {
      colors = Colors.orange;
    }
    return colors;
  }

  String unityPattern = "unity_challenge.";
  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengesList = variable.getChallenges();
    _confirmRegister(int index) {
      var baseDialog = BaseAlertDialog(
          title: "Confirm Registration",
          content: "I Agree that the information provided is correct",
          yesOnPressed: () {
            variable.addListChallengeSave(_challengesList[index].name);
            Navigator.pop(context, false);
          },
          noOnPressed: () {},
          yes: "Agree",
          no: "Cancel");
      showDialog(
          context: context, builder: (BuildContext context) => baseDialog);
    }

    final Challengecontroller provider =
        Provider.of<Challengecontroller>(context);
    if (_challengesList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "Pas de mission en cours.",
          style: TextStyle(color: Colors.orange[600], fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: _challengesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3.0, left: 8.0, right: 8.0),
          child: Dismissible(
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                provider.addnbChallengeVallide();
                provider.remove(index: index);
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content:
                        "Le challenge ${_challengesList[index].name} a bien ete valide"));
              }

              if (direction == DismissDirection.startToEnd) {
                provider.remove(index: index);
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content:
                        "La mission ${_challengesList[index].name} a bien ete supprime"));
              }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                final bool resultat = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Confirmation",
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: Text("Voulez vous suprimmez la mission"),
                        actions: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text("Oui"),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text("Nom"),
                          )
                        ],
                      );
                    });
                return resultat;
              }
              return true;
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.delete,
                size: 55.0,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.centerRight,
              color: Colors.green,
              child: Icon(
                Icons.check,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            key: Key(UniqueKey().toString()),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  //background color of box
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 45.0, // soften the shadow
                    spreadRadius: 2.0, //extend the shadow
                    offset: Offset(
                      3.0, // Move to right 10  horizontally
                      3.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 20.0,
                child: ListTile(
                  onLongPress: () {
                    _confirmRegister(index);
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: variable,
                            child: HomeTaches(
                              _challengesList[index].name,
                            ))));
                  },
                  title: Container(
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 15.0,
                          child: Text(
                            "Titre",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(_challengesList[index].name),
                        SizedBox(
                          width: 5.0,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        // border: Border.all(
                        //   color: Colour('#C4AB4D'),
                        //   width: 2,
                        // ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 15.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 250.0,
                                    height: 25.0,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          maxLetter(_challengesList[index]
                                              .description),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 250.0,
                                    height: 30.0,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Priorite",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          _challengesList[index]
                                              .unity
                                              .toString()
                                              .replaceAll(unityPattern, "")
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: changeColors(
                                                  _challengesList[index]
                                                      .unity
                                                      .toString()
                                                      .replaceAll(
                                                          unityPattern, ""))),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                elevation: 15.0,
                                child: Container(
                                  child: new CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    percent: 1.0,
                                    // percent: percentage(
                                    //     _challengesList[index]
                                    //         .listeDeTache
                                    //         .length,
                                    //     int.parse(_challengesList[index]
                                    //         .totalChallenge)),
                                    center: new Text((percentage(
                                                    _challengesList[index]
                                                        .listeDeTache
                                                        .length,
                                                    int.parse(
                                                        _challengesList[index]
                                                            .totalChallenge)) *
                                                100)
                                            .toStringAsFixed(2) +
                                        "%"),
                                    progressColor: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  isThreeLine: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SnackBar _buildSnackBar({@required String content}) {
    return SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }
}
