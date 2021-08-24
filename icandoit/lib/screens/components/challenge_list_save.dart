import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:icandoit/screens/components/resultat_challenge.dart';
import 'package:item_selector/item_selector.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:slide_drawer/slide_drawer.dart';

import '../home_screen.dart';
import 'baseAlertDialog.dart';

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp>
    with SingleTickerProviderStateMixin {
  // SnackBar _buildSnackBar({@required String content}) {
  //   return SnackBar(
  //     content: Text(
  //       content,
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }

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
    Challengecontroller variable2 = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengeList = variable2.getChallenges2();

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
                  "Sauvegare",
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
                  "Support us",
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
                  "About us",
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
                  flexibleSpace: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          // splash color
                          splashColor: Colors.white,
                          onTap: () {
                            int indexSave;
                            indexSave = variable2.getChallengesindex();
                            if (indexSave != null) {
                              variable2.addSlectSave();
                              showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  backgroundColor: Colors.blue,
                                  icon: Icon(
                                    Icons.restore,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  message: "Restauration rèussi avec succes",
                                ),
                              );
                              // Scaffold.of(context).showSnackBar(_buildSnackBar(
                              //     content:
                              //         "Le challenge  a bien ete restaurer"));
                            } else {
                              _confirmRegister();
                            }
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.restore,
                                size: 30,
                                color: Colors.white,
                              ),

                              Text(
                                "Restaurer",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ), // text
                            ],
                          ),
                        ),
                        InkWell(
                          // splash color
                          splashColor: Colors.white,
                          onTap: () {
                            int indexSave;
                            indexSave = variable2.getChallengesindex();
                            variable2.removeSave(index: indexSave);
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                backgroundColor: Colors.blue,
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                message: "Sauvegarde effacée avec succes.",
                              ),
                            );
                            // Scaffold.of(context).showSnackBar(_buildSnackBar(
                            //     content: "Le sauvegarde a bien ete supprimé"));
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.backup,
                                size: 30,
                                color: Colors.white,
                              ),
                              // Lottie.asset('assets/trash.json',
                              //     width: 40.0, height: 40), // icon
                              Text(
                                "Supprimer",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ), // text
                            ],
                          ),
                        ),
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
    elevation: selected ? 1 : 35,
    child: ListTile(
      leading: Icon(
        Icons.backup,
        size: 35.0,
        color: Colors.blue,
      ),
      contentPadding: EdgeInsets.all(10),
      title: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: Row(
          children: [
            Text(
              "Titre",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
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
