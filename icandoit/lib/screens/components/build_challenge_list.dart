import 'package:elliptic_text/elliptic_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/models/challenge_model.dart';
// import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:page_transition/page_transition.dart';
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
    double percent1;
    if (listeTache != 0 && listeTache == totalChallenge) {
      percent1 = (totalChallenge - listeTache) / totalChallenge;
      return percent1;
    } else if (listeTache != 0 && listeTache != totalChallenge) {
      percent1 = (1 - (listeTache / totalChallenge));
      return percent1;
    } else if (listeTache == 0 && listeTache != totalChallenge) {
      percent1 = ((totalChallenge - listeTache) / totalChallenge);
      return percent1;
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
          text: TextSpan(text: word),
          style: TextStyle(
            color: Colors.black,
          ),
          speed: 30,
        ),
      );
      return longLetter;
    } else {
      word2 = word;
      longLetter = Text(word2);
    }
    return longLetter;
  }

  Widget maxLetterTitre(String word, bool animatinpadding) {
    Widget longLetter;

    String word2;
    if (animatinpadding && word.length > 20) {
      longLetter = Container(
        width: MediaQuery.of(context).size.width / 2.65,
        color: Colors.transparent,
        child: MarqueeText(
          text: TextSpan(text: word),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          speed: 30,
        ),
      );
      return longLetter;
    } else if (word.length > 25) {
      longLetter = Container(
        width: MediaQuery.of(context).size.width / 2.1,
        color: Colors.transparent,
        child: MarqueeText(
          text: TextSpan(text: word),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          speed: 30,
        ),
      );
      return longLetter;
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
                      width: MediaQuery.of(context).size.width / 1.6,
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
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      height: 30.0,
                      child: Row(
                        children: [
                          Text(
                            "Priorité",
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
                FlipCard(
                  front: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    elevation: 15.0,
                    child: Container(
                      child: new CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: percentage(chalenge.listeDeTache.length,
                            int.parse(chalenge.totalChallenge)),
                        center: new Text((percentage(
                                        chalenge.listeDeTache.length,
                                        int.parse(chalenge.totalChallenge)) *
                                    100)
                                .toStringAsFixed(0) +
                            "%"),
                        progressColor: Colors.green,
                      ),
                    ),
                  ),
                  back: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    elevation: 15.0,
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              (int.parse(chalenge.totalChallenge) -
                                          chalenge.listeDeTache.length)
                                      .toString() +
                                  "/" +
                                  chalenge.totalChallenge,
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.blue),
                            ),
                          ),
                          EllipticText(
                            text: "Tâches validées",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.blue),
                            // Draw text at the bottom of the ellipse.
                            perimiterAlignment:
                                EllipticText_PerimiterAlignment.top,
                            offset: 0.0,
                            // Stretch text to half the circumference.
                            fitFactor: 1 / 2,
                            fitType: EllipticText_FitType.scaleFit,
                          ),
                          // _animate(
                          //   (__value) => Center(
                          //     // Wrap the EllipticText widget in a SizedBox to set its size.
                          //     child: SizedBox(
                          //       height: 60.0,
                          //       width: 60.0,
                          //       child: EllipticText(
                          //         text: "test",
                          //         style: TextStyle(
                          //             fontSize: 10.0, color: Colors.blue),
                          //         // Draw text at the bottom of the ellipse.
                          //         perimiterAlignment:
                          //             EllipticText_PerimiterAlignment.top,
                          //         offset: __value,
                          //         // Stretch text to half the circumference.
                          //         fitFactor: 1 / 2,
                          //         fitType: EllipticText_FitType.noFit,
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (chalenge.idNotif.isNotEmpty) {
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
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            height: 30.0,
                            child: Row(
                              children: [
                                Text(
                                  "Priorité",
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
                      FlipCard(
                        front: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          elevation: 15.0,
                          child: Container(
                            child: new CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 5.0,
                              percent: percentage(chalenge.listeDeTache.length,
                                  int.parse(chalenge.totalChallenge)),
                              center: new Text((percentage(
                                              chalenge.listeDeTache.length,
                                              int.parse(
                                                  chalenge.totalChallenge)) *
                                          100)
                                      .toStringAsFixed(0) +
                                  "%"),
                              progressColor: Colors.green,
                            ),
                          ),
                        ),
                        back: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          elevation: 15.0,
                          child: Container(
                            child: Text("test"),
                          ),
                        ),
                      ),
                    ]),
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
      return colors;
    } else if (challengeListeColors == "haute") {
      colors = Colors.red;
      return colors;
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
      _challengesList =
          _challengesListget.where((c) => c.boolId == true).toList();
    }

    _confirmRegister(String id) {
      int index = variable.returnIndexForName(id);
      var baseDialog = BaseAlertDialog(
          title: "Confirmer la sauvegarde",
          content: "Une sauvegarde va être effectuée",
          yesOnPressed: () {
            variable.addListChallengeSaveindex(index);
            Navigator.pop(context, false);
          },
          noOnPressed: () {
            Navigator.pop(context);
          },
          yes: "Oui",
          no: "Non");
      showDialog(
          context: context, builder: (BuildContext context) => baseDialog);
    }

    Widget resrtorButtm(int index, bool anamatingPadding) {
      Widget restorhButtom = SizedBox(
        width: 1.0,
      );
      if (anamatingPadding) {
        restorhButtom = IconButton(
          alignment: Alignment.center,
          icon: Icon(
            Icons.restore,
            color: Colors.black,
          ),
          onPressed: () {
            variable.restaureSave(index);
          },
        );
      }
      return restorhButtom;
    }

    Widget switchButtm(String id, bool boolId) {
      Widget switchButtom = SizedBox(
        width: 1.0,
      );
      if (widget.idChallenge.isNotEmpty) {
        // print(boolId);
        isSwitched = boolId;
        switchButtom = Row(
          children: [
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  int index = variable.returnIndexForName(id);
                  isSwitched = value;
                  // print(isSwitched);
                  variable.desactivAffichagePrinc(index, isSwitched);
                });
              },
              activeTrackColor: Colors.yellow,
              activeColor: Colors.orangeAccent,
            ),
            Icon(Icons.remove_red_eye_outlined)
          ],
        );
      }
      return switchButtom;
    }

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
                if (_challengesList[index].notification.isEmpty &&
                    _challengesList[index].idNotif.isNotEmpty) {
                  for (var n = _challengesList[index].idNotif.length - 1;
                      n >= 0;
                      n--) {
                    variable.cancelNotificationById(
                        int.parse(_challengesList[index].idNotif[n]));
                  }
                }
                int index1 =
                    variable.returnIndexForName(_challengesList[index].id);
                variable.addnbChallengeVallide();
                variable.remove(
                    idChallenge: widget.idChallenge,
                    index: index1,
                    validate: true,
                    id: _challengesList[index].id);
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "Le challenge a bien été validé",
                    lotties: 'assets/challenge.json'));
              }

              if (direction == DismissDirection.startToEnd) {
                if (_challengesList[index].idNotif.isNotEmpty) {
                  for (var n = _challengesList[index].idNotif.length - 1;
                      n >= 0;
                      n--) {
                    variable.cancelNotificationById(
                        int.parse(_challengesList[index].idNotif[n]));
                  }
                }
                int index1 =
                    variable.returnIndexForName(_challengesList[index].id);
                variable.remove(
                    idChallenge: widget.idChallenge,
                    index: index1,
                    validate: false,
                    id: _challengesList[index].id);
                Scaffold.of(context).showSnackBar(_buildSnackBar(
                    content: "La mission a bien été supprimée",
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
                        content: Text("Voulez vous supprimer la mission"),
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
                            child: Text("Non"),
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
                color: widget.idChallenge.isNotEmpty
                    ? Colors.grey[400]
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 20.0,
                child: ListTile(
                  onLongPress: () {
                    _confirmRegister(_challengesList[index].id);
                  },
                  onTap: () async {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: ChangeNotifierProvider.value(
                                value: variable,
                                child: HomeTaches(
                                    _challengesList[index].id,
                                    variable.returnIndexForName(
                                        _challengesList[index].id),
                                    _challengesList[index].name,
                                    _challengesList[index].animatedpadding,
                                    widget.idChallenge))));
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
                                    _challengesList[index].name.toUpperCase(),
                                    _challengesList[index].animatedpadding),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        switchButtm(_challengesList[index].id,
                            _challengesList[index].boolId),
                        resrtorButtm(
                            variable
                                .returnIndexForName(_challengesList[index].id),
                            _challengesList[index].animatedpadding)
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

  Future<Widget> buildPageAsync(List<ChallengeModel> challengesList,
      Challengecontroller variable, int index) async {
    return Future.microtask(() {
      return HomeTaches(
          challengesList[index].id,
          variable.returnIndexForName(challengesList[index].id),
          challengesList[index].name,
          challengesList[index].animatedpadding,
          widget.idChallenge);
    });
  }
}

class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

final _animate =
    (final Widget Function(double) widget) => TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 0.0,
            // Revolve text at 30 RPM.
            end: 30.0 * /*circumference = */ 1189.90797,
          ),
          duration: Duration(minutes: 1),
          builder: (_, __value, __) => widget(__value),
        );
