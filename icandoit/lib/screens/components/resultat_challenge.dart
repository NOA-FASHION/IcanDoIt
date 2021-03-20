import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';
import 'challenge_list_save.dart';

class ResultaChallenge extends StatefulWidget {
  ResultaChallenge({Key key}) : super(key: key);

  @override
  _ResultaChallengeState createState() => _ResultaChallengeState();
}

class _ResultaChallengeState extends State<ResultaChallenge>
    with SingleTickerProviderStateMixin {
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
    Challengecontroller variable2 = Provider.of<Challengecontroller>(context);

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
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Colors.purple, Colors.blue])),
                // key: ValueKey<int>(currentPage),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Column(
                        children: [
                          Card(
                            child: Text("Aujourdhui"),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 15.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(''),
                                          Text("data")
                                        ],
                                      ),
                                    ),
                                    Card(
                                      elevation: 15.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(''),
                                          Text("data")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 15.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(''),
                                          Text("data")
                                        ],
                                      ),
                                    ),
                                    Card(
                                      elevation: 15.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(''),
                                          Text("data")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            child: Card(
                              elevation: 15.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              child: ,
                            ),
                          )
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
}
