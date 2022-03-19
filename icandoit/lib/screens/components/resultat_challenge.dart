import 'dart:ui';

import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/scoreChallengeWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

import '../home_screen.dart';
import 'challenge_list_save.dart';

class ResultaChallenge extends StatefulWidget {
  ResultaChallenge({Key key}) : super(key: key);

  @override
  _ResultaChallengeState createState() => _ResultaChallengeState();
}

class _ResultaChallengeState extends State<ResultaChallenge>
    with SingleTickerProviderStateMixin {
  // ChallengeDays challengeDaysResult;
  // Challengeyesterday challengeyesterdayResult;
  bool isSwitched;
  String resultaChallenge(int nbchallengeValide,
      {String nmbreChalleneEnCours}) {
    String resultat = "assets/succes0.json";
    if (nbchallengeValide == 0) {
      resultat = "assets/succes0.json";
    } else if (nbchallengeValide > 9) {
      resultat = "assets/succes2.json";
    } else if (nbchallengeValide > 6) {
      resultat = "assets/succes2.json";
    } else if (nbchallengeValide > 0) {
      resultat = "assets/succes1.json";
    }
    return resultat;
  }

  int currentPage = 0;
  FancyDrawerController _controller;
  void initState() {
    super.initState();
    _controller =
        FancyDrawerController(vsync: this, duration: Duration(milliseconds: 50))
          ..addListener(() {
            setState(() {});
          });
  }

  void _launchMapsUrl() async {
    final url = "https://easytodo.fr";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    Challengecontroller variable2 = Provider.of<Challengecontroller>(context);
    ChallengeDays challengeDaysResult = variable2.getChallengeDays();

    // Challengeyesterday challengeyesterdayResult =
    //     variable2.getChallengeyesterday();
    isSwitched = challengeDaysResult.notifcationResultBool;
    print(challengeDaysResult.notifcationResultBool);
    List<VBarChartModel> bardata = [
      VBarChartModel(
        label: "Challenges validés",
        index: 0,
        colors: [Colors.orange, Colors.deepOrange],
        jumlah: double.parse(challengeDaysResult.nbchallengeVallide),
        tooltip: "${challengeDaysResult.nbchallengeVallide}",
      ),
      VBarChartModel(
        label: "Tâches validés",
        index: 1,
        colors: [Colors.black, Colors.deepOrange],
        jumlah: double.parse(challengeDaysResult.nbtacheVallide),
        tooltip: "${challengeDaysResult.nbtacheVallide}",
      ),
      VBarChartModel(
        label: "Challenges en cours",
        index: 2,
        colors: [Colors.teal, Colors.deepOrange],
        jumlah: double.parse(challengeDaysResult.nbChallengeEnCours),
        tooltip: "${challengeDaysResult.nbChallengeEnCours}",
      ),
    ];

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
                      value: variable2,
                      child: Home(
                        returnRaccourci: false,
                        id: "",
                        idChallenge1: '',
                        namechallenge: '',
                      ))));
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
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable2, child: ExampleApp())));
              setState(() {});
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
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable2, child: ResultaChallenge())));
              setState(() {});
            },
            child: Row(
              children: [
                Icon(FontAwesomeIcons.play),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Score",
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
              _launchMapsUrl();
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
              _launchMapsUrl();
            },
            child: Row(
              children: [
                Icon(Icons.policy),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "A propos",
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
        child: MaterialApp(
          title: 'Item Selector',
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: SafeArea(
                child: AppBar(
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
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 60,
                        ),
                      ],
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
            body: AnimatedSwitcher(
              duration: Duration(milliseconds: 246),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[Colors.purple, Colors.blue])),
                  // key: ValueKey<int>(currentPage),
                  child: Center(
                    child: Card(
                      color: Colors.transparent,
                      elevation: 25.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.all(15),
                            child: Card(
                              elevation: 25.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 70,
                                    padding: EdgeInsets.only(right: 22),
                                    child: Card(
                                      color: Colors.blue,
                                      elevation: 25.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                            value: isSwitched,
                                            onChanged: (value) {
                                              setState(() {
                                                isSwitched = value;
                                                variable2
                                                    .activeResultat(isSwitched);
                                              });
                                            },
                                            activeTrackColor: Colors.yellow,
                                            activeColor: Colors.orangeAccent,
                                          ),
                                          Text(
                                            "Notification",
                                            style: TextStyle(
                                                fontSize: 7,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Score des challenges".toUpperCase(),
                                      style: GoogleFonts.playfairDisplay(
                                          fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            width: mediaQueryData.size.width,
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                ScoreChallengeWidget(
                                  challengeDaysResult.nbchallengeVallide ==
                                              '0' ||
                                          challengeDaysResult
                                                  .nbchallengeVallide ==
                                              '1'
                                      ? "${challengeDaysResult.nbchallengeVallide} challenge validé"
                                      : "${challengeDaysResult.nbchallengeVallide} challenges validés",
                                  mediaQueryData,
                                  challengeDaysResult.commentaire.toUpperCase(),
                                  challengeDaysResult.nbChallengeEnCours ==
                                              '0' ||
                                          challengeDaysResult
                                                  .nbChallengeEnCours ==
                                              '1'
                                      ? "${challengeDaysResult.nbChallengeEnCours} challenge en cours"
                                      : "${challengeDaysResult.nbChallengeEnCours} challenges en cours",
                                  resultaChallenge(int.parse(
                                      challengeDaysResult.nbchallengeVallide)),
                                  challengeDaysResult.nbtacheVallide == '0' ||
                                          challengeDaysResult.nbtacheVallide ==
                                              '1'
                                      ? "${challengeDaysResult.nbtacheVallide}  tâche validée"
                                      : "${challengeDaysResult.nbtacheVallide}  tâches validées",
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    width: mediaQueryData.size.width / 0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        elevation: 15.0,
                                        child: Column(
                                          children: [
                                            _buildGrafik(bardata),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrafik(List<VBarChartModel> bardata) {
    return VerticalBarchart(
      showBackdrop: true,
      barStyle: BarStyle.CIRCLE,
      tooltipColor: Colors.black,
      labelColor: Colors.black,
      background: Colors.transparent,
      tooltipSize: 20,
      maxX: 100.0,
      labelSizeFactor: 1,
      data: bardata,
      showLegend: true,
      legend: [
        Vlegend(
          textColor: Colors.black,
          isSquare: false,
          color: Colors.orange,
          text: "Challenges validés",
        ),
        Vlegend(
          textColor: Colors.black,
          isSquare: false,
          color: Colors.black,
          text: "Tâches validées",
        ),
        Vlegend(
          textColor: Colors.black,
          isSquare: false,
          color: Colors.teal,
          text: "Challenges en cours",
        )
      ],
    );
  }
}
