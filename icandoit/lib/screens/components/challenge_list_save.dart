import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:item_selector/item_selector.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:slide_drawer/slide_drawer.dart';

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable2 = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengeList = variable2.getChallenges2();
    return MaterialApp(
      title: 'Item Selector',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: SafeArea(
            child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                // call toggle from SlideDrawer to alternate between open and close
                // when pressed menu button
                onPressed: () => SlideDrawer.of(context).toggle(),
              ),
              flexibleSpace: Container(
                child: InkWell(
                    onTap: () {
                      int indexSave;
                      indexSave = variable2.getChallengesindex();
                      print("resultat des index");
                      print(indexSave);
                      if (indexSave != null) {
                        variable2.addSlectSave();
                      } else {
                        return AlertDialog(
                          content: Text(
                              "Vous devez selectionner un challenge pour l'enregistrer"),
                        );
                      }
                    },
                    child: Container(
                        width: 200.0,
                        height: 200.0,
                        child: Lottie.asset('assets/save1.json'))),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Colors.purple, Colors.blue])),
              ),
              title: Text("save"),
            ),
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 246),
          child: Container(
            // key: ValueKey<int>(currentPage),
            child: ListViewPage(_challengeList),
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
    margin: EdgeInsets.all(10),
    elevation: selected ? 2 : 10,
    child: ListTile(
      leading: FlutterLogo(),
      contentPadding: EdgeInsets.all(10),
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
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
