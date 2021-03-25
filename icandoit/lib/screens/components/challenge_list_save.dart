import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/resultat_challenge.dart';
import 'package:item_selector/item_selector.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
// import 'package:slide_drawer/slide_drawer.dart';

import '../home_screen.dart';
import 'baseAlertDialog.dart';

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp>
    with SingleTickerProviderStateMixin {
  _confirmRegister() {
    var baseDialog = BaseAlertDialog(
        title: "pas de selection",
        content: "Vous devez selectionner un challenge",
        yesOnPressed: () {
          Navigator.pop(context, false);
        },
        yes: "Agree");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
    return;
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
    Challengecontroller variable2 = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengeList = variable2.getChallenges2();

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
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              int indexSave;
                              indexSave = variable2.getChallengesindex();
                              print("resultat des index");
                              print(indexSave);
                              if (indexSave != null) {
                                variable2.addSlectSave();
                              } else {
                                _confirmRegister();
                              }
                            },
                            child: Container(
                                width: 200.0,
                                height: 200.0,
                                child: Lottie.asset('assets/save1.json'))),
                        InkWell(
                            onTap: () {
                              int indexSave;
                              indexSave = variable2.getChallengesindex();
                              variable2.removeSave(index: indexSave);
                            },
                            child: Container(
                                width: 200.0,
                                height: 50.0,
                                child: Lottie.asset('assets/trash.json',
                                    width: 10.0, height: 10))),
                      ],
                    ),
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
                child: ListViewPage(_challengeList),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildListItem(
  BuildContext context,
  int index,
  bool selected,
) {
  Challengecontroller variable = Provider.of<Challengecontroller>(context);
  List<ChallengeModel> challengeListSave = variable.getChallenges2();
  variable.indexSaveFunction(selected, index);
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    margin: EdgeInsets.all(10),
    elevation: selected ? 1 : 15,
    child: ListTile(
      leading: FlutterLogo(),
      contentPadding: EdgeInsets.all(10),
      title: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: Container(
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
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(challengeListSave[index].name),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ListViewPage extends StatelessWidget {
  final List<ChallengeModel> _challengeList;
  ListViewPage(this._challengeList);
  @override
  Widget build(BuildContext context) {
    return ItemSelectionController(
      onSelectionUpdate: (start, end) {
        if (start != null && end != null) {
          return true;
        } else {
          return false;
        }
      },
      child: ListView.builder(
        itemCount: _challengeList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemSelectionBuilder(
            index: index,
            builder: buildListItem,
          );
        },
      ),
    );
  }
}
