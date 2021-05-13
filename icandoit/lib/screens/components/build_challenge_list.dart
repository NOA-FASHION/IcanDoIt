import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
// import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../controllers/challenge_controller.dart';
// import '../home_screen.dart';
import 'baseAlertDialog.dart';
import 'home_screen_tache.dart';

class ChallengesListBuilder extends StatefulWidget {
  final bool selectbool;
  final String idChallenge;
  ChallengesListBuilder(
      {@required this.selectbool, @required this.idChallenge});
  @override
  _ChallengesListBuilderState createState() => _ChallengesListBuilderState();
}

class _ChallengesListBuilderState extends State<ChallengesListBuilder> {
  bool isSwitched = false;
  double percentage(int listeTache, int totalChallenge) {
    // print(listeTache);
    double percent1;
    if (listeTache != 0 && listeTache == totalChallenge) {
      percent1 = 0.00;
    } else if (listeTache != 0 && listeTache != totalChallenge) {
      percent1 = (1 - (listeTache / totalChallenge));
    } else {
      percent1 = 0.00;
    }
    return percent1;
  }

  Widget maxLetter(String word) {
    Widget longLetter;

    String word2;

    if (word.length >= 21) {
      longLetter = Container(
        width: MediaQuery.of(context).size.width / 2.9,
        color: Colors.transparent,
        child: MarqueeText(
          text: word,
          style: TextStyle(
            color: Colors.black,
          ),
          speed: 30,
        ),
      );
    } else {
      word2 = word;
      longLetter = Text(word2);
    }
    return longLetter;
  }

  Widget maxLetterTitre(String word) {
    Widget longLetter;

    String word2;

    if (word.length > 30) {
      longLetter = Container(
        width: MediaQuery.of(context).size.width / 2.55,
        color: Colors.transparent,
        child: MarqueeText(
          text: word,
          style: TextStyle(
            color: Colors.black,
          ),
          speed: 30,
        ),
      );
    } else {
      word2 = word;
      longLetter = Text(
        word2,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }
    return longLetter;
  }

  Widget activeGlow(ChallengeModel chalenge) {
    Widget glow = Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
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
                      width: MediaQuery.of(context).size.width / 1.8,
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

                          maxLetter(chalenge.description),

                          // SizedBox(
                          //   width: 1.0,
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
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
                            chalenge.unity
                                .toString()
                                .replaceAll(unityPattern, "")
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: changeColors(chalenge.unity
                                    .toString()
                                    .replaceAll(unityPattern, ""))),
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
                      // percent: 1.0,
                      percent: percentage(chalenge.listeDeTache.length,
                          int.parse(chalenge.totalChallenge)),
                      center: new Text((percentage(chalenge.listeDeTache.length,
                                      int.parse(chalenge.totalChallenge)) *
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
    );
    if (chalenge.animatedpadding) {
      glow = Shimmer(
        duration: Duration(seconds: 5),
        interval: Duration(seconds: 1),
        color: Colors.lightBlueAccent,
        enabled: true,
        direction: ShimmerDirection.fromRightToLeft(),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
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
                          width: MediaQuery.of(context).size.width / 1.8,
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
                              maxLetter(chalenge.description),
                              // SizedBox(
                              //   width: 1.0,
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
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
                                chalenge.unity
                                    .toString()
                                    .replaceAll(unityPattern, "")
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: changeColors(chalenge.unity
                                        .toString()
                                        .replaceAll(unityPattern, ""))),
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
                          // percent: 1.0,
                          percent: percentage(chalenge.listeDeTache.length,
                              int.parse(chalenge.totalChallenge)),
                          center: new Text((percentage(
                                          chalenge.listeDeTache.length,
                                          int.parse(chalenge.totalChallenge)) *
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
      );
    }
    return glow;
  }

  Color changeColors(String challengeListeColors) {
    Color colors;
    if (challengeListeColors == "normal") {
      colors = Colors.green;
    } else if (challengeListeColors == "haute") {
      colors = Colors.red;
    } else {
      colors = Colors.orange;
    }
    return colors;
  }

  String unityPattern = "unity_challenge.";
  @override
  Widget build(BuildContext context) {
    Challengecontroller variable = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengesList;
    List<ChallengeModel> _challengesListget = variable.getChallenges();
    if (widget.idChallenge.isNotEmpty) {
      _challengesList = _challengesListget
          .where((c) => c.idChallenge.contains(widget.idChallenge))
          .toList();
    } else {
      // _challengesList = variable.getChallenges();
      // for (var i = _challengesList.length - 1; i >= 0; i--) {
      //   print(_challengesList[i].boolId);

      // }

      _challengesList =
          _challengesListget.where((c) => c.boolId == true).toList();
    }

    // List<ChallengeModel> _challengesList = variable.getChallenges();
    _confirmRegister(String id) {
      int index = variable.returnIndexForName(id);
      var baseDialog = BaseAlertDialog(
          title: "Confirmez la sauvegarde",
          content: "Une sauvegarde va être éffectué",
          yesOnPressed: () {
            variable.addListChallengeSaveindex(index);
            Navigator.pop(context, false);
          },
          noOnPressed: () {},
          yes: "oui",
          no: "non");
      showDialog(
          context: context, builder: (BuildContext context) => baseDialog);
    }

    Widget switchButtm(String id, bool boolId) {
      Widget switchButtom = SizedBox(
        width: 1.0,
      );
      if (widget.idChallenge.isNotEmpty) {
        print(boolId);
        isSwitched = boolId;
        int index = variable.returnIndexForName(id);
        switchButtom = Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              print(isSwitched);
              variable.desactivAffichagePrinc(index, isSwitched);
            });
          },
          activeTrackColor: Colors.yellow,
          activeColor: Colors.orangeAccent,
        );
      }
      return switchButtom;
    }

    // final Challengecontroller provider =
    //     Provider.of<Challengecontroller>(context);
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
                int index1 =
                    variable.returnIndexForName(_challengesList[index].id);
                variable.addnbChallengeVallide();
                variable.remove(
                    index: index1,
                    validate: true,
                    id: _challengesList[index].id);
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "Le challenge a bien ete valide",
                    lotties: 'assets/challenge.json'));
              }

              if (direction == DismissDirection.startToEnd) {
                int index1 =
                    variable.returnIndexForName(_challengesList[index].id);
                variable.remove(
                    index: index1,
                    validate: false,
                    id: _challengesList[index].id);
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "La mission a bien ete supprime",
                    lotties: 'assets/trash.json'));
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
                    _confirmRegister(_challengesList[index].id);
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: variable,
                            child: HomeTaches(
                                _challengesList[index].id,
                                variable.returnIndexForName(
                                    _challengesList[index].id),
                                _challengesList[index].name,
                                _challengesList[index].animatedpadding))));
                  },
                  title: Container(
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 15.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text(
                                  "Titre".toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                maxLetterTitre(
                                    _challengesList[index].name.toUpperCase()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        switchButtm(_challengesList[index].id,
                            _challengesList[index].boolId),
                      ],
                    ),
                  ),
                  subtitle: activeGlow(_challengesList[index]),
                  isThreeLine: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SnackBar _buildSnackBar({@required String content, String lotties}) {
    return SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
      content: Container(
        height: 80,
        child: Row(
          children: [
            Lottie.asset(lotties, width: 60),
            Text(
              content,
              style: TextStyle(color: Colors.purple),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
