import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
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
  String resultaChallenge(int nbchallengeValide) {
    String resultat = "assets/succes0.json";
    if (nbchallengeValide == 0) {
      resultat = "assets/succes0.json";
    } else if (nbchallengeValide > 0) {
      resultat = "assets/succes1.json";
    } else if (nbchallengeValide > 3) {
      resultat = "assets/succes2.json";
    } else if (nbchallengeValide > 6) {
      resultat = "assets/succes3.json";
    }
    return resultat;
  }

  int currentPage = 0;
  FancyDrawerController _controller;
  void initState() {
    super.initState();
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
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
    var mediaQueryData = MediaQuery.of(context);
    Challengecontroller variable2 = Provider.of<Challengecontroller>(context);
    ChallengeDays challengeDaysResult = variable2.getChallengeDays();
    Challengeyesterday challengeyesterdayResult =
        variable2.getChallengeyesterday();
    List<VBarChartModel> bardata = [
      VBarChartModel(
        index: 0,
        label: "Challenge vallide",
        colors: [Colors.orange, Colors.deepOrange],
        jumlah: double.parse(challengeDaysResult.nbchallengeVallide),
        tooltip: "${challengeDaysResult.nbchallengeVallide}",
      ),
      VBarChartModel(
        index: 1,
        label: "Tache vallide",
        colors: [Colors.orange, Colors.deepOrange],
        jumlah: double.parse(challengeDaysResult.nbtacheVallide),
        tooltip: "${challengeDaysResult.nbtacheVallide}",
      ),
      VBarChartModel(
        index: 2,
        label: "Challenge en cours",
        colors: [Colors.teal, Colors.indigo],
        jumlah: double.parse(challengeDaysResult.nbChallengeEnCours),
        tooltip: "${challengeDaysResult.nbChallengeEnCours}",
      ),
    ];

    return Material(
      child: FancyDrawerWrapper(
        backgroundColor: Colors.blue,
        controller: _controller,
        drawerItems: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable2, child: Home())));
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: variable2, child: Home())));
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Sauvegare challenge",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
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
                Icon(Icons.save_rounded),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "score des challenges",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
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
                      value: variable2, child: ExampleApp())));
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "Support us",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
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
                      value: variable2, child: Home())));
              // setState(() {});
            },
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "About us",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
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
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[Colors.purple, Colors.blue])),
                  ),
                  // title: Text("save"),
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
                      child: Container(
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
                            Card(
                              elevation: 25.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("hier"),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    width: mediaQueryData.size.width / 2.5,
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 25.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Lottie.asset(
                                                'assets/task.json',
                                                width: 30.0),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${challengeyesterdayResult.nbtacheVallide} taches valide",
                                                textAlign: TextAlign.center),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    width: mediaQueryData.size.width / 2.5,
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 25.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Lottie.asset('assets/challenge.json',
                                              width: 50),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "${challengeyesterdayResult.nbchallengeVallide} challenges valide",
                                                textAlign: TextAlign.center),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 25.0),
                            Card(
                              elevation: 25.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Aujourdhui"),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: mediaQueryData.size.width / 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: mediaQueryData.size.width / 3,
                                          height: 140,
                                          child: Card(
                                            elevation: 25.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Lottie.asset(
                                                    resultaChallenge(int.parse(
                                                        challengeDaysResult
                                                            .nbchallengeVallide)),
                                                    width: 90),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    challengeDaysResult
                                                        .commentaire,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 25.0),
                                        Container(
                                          width: mediaQueryData.size.width / 3,
                                          height: 140,
                                          child: Card(
                                            elevation: 25.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Lottie.asset(
                                                      'assets/progress.json',
                                                      width: 60),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "${challengeDaysResult.nbChallengeEnCours} challenge en cours",
                                                      textAlign:
                                                          TextAlign.center),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: mediaQueryData.size.width / 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: mediaQueryData.size.width / 3,
                                          height: 140,
                                          child: Card(
                                            elevation: 25.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Lottie.asset(
                                                      'assets/task.json',
                                                      width: 60.0),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "${challengeDaysResult.nbtacheVallide}  taches valide",
                                                      textAlign:
                                                          TextAlign.center),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 25.0),
                                        Container(
                                          width: mediaQueryData.size.width / 3,
                                          height: 140,
                                          child: Card(
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Lottie.asset(
                                                    'assets/challenge.json',
                                                    width: 80),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "${challengeDaysResult.nbchallengeVallide} challenges valide",
                                                      textAlign:
                                                          TextAlign.center),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                                width: mediaQueryData.size.width / 1.2,
                                child: Column(
                                  children: [
                                    _buildGrafik(bardata),
                                  ],
                                ))
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
      ),
    );
  }

  Widget _buildGrafik(List<VBarChartModel> bardata) {
    return VerticalBarchart(
      tooltipColor: Colors.white,
      labelColor: Colors.white,
      background: Colors.transparent,
      maxX: 55,
      data: bardata,
      showLegend: true,
      legend: [
        Vlegend(
          textColor: Colors.white,
          isSquare: false,
          color: Colors.orange,
          text: "Challenge vallide",
        ),
        Vlegend(
          textColor: Colors.white,
          isSquare: false,
          color: Colors.teal,
          text: "tache vallide",
        ),
        Vlegend(
          textColor: Colors.white,
          isSquare: false,
          color: Colors.black,
          text: "challenge en cours",
        )
      ],
    );
  }
}
