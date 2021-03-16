import 'dart:math';
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:item_selector/item_selector.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  int currentPage = 0;
  List<int> indexSave;

  @override
  Widget build(BuildContext context) {
    Challengecontroller variable2 = Provider.of<Challengecontroller>(context);
    List<ChallengeModel> _challengeList = variable2.getChallenges();
    return MaterialApp(
      title: 'Item Selector',
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            child: InkWell(
                onTap: () {
                  variable2.addSlectSave();
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

// class ColumnPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ItemSelectionController(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(4, (index) {
//           return ItemSelectionBuilder(
//             index: index,
//             builder: buildListItem,
//           );
//         }),
//       ),
//     );
//   }
// }

class ListViewPage extends StatelessWidget {
  final List<ChallengeModel> _challengeList;
  ListViewPage(this._challengeList);
  @override
  Widget build(BuildContext context) {
    return ItemSelectionController(
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

// Widget buildGridItem(BuildContext context, int index, bool selected) {
//   return Card(
//     margin: EdgeInsets.all(10),
//     elevation: selected ? 2 : 10,
//     child: GridTile(
//       child: Center(child: FlutterLogo()),
//       footer: Padding(
//         padding: const EdgeInsets.all(2),
//         child: Text(
//           index.toString(),
//           textAlign: TextAlign.end,
//         ),
//       ),
//     ),
//   );
// }

// class GridViewPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final selection = RectSelection(4);
//     return ItemSelectionController(
//       selection: selection,
//       child: GridView.count(
//         crossAxisCount: 4,
//         mainAxisSpacing: 4,
//         crossAxisSpacing: 4,
//         children: List.generate(100, (int index) {
//           return ItemSelectionBuilder(
//             index: index,
//             builder: buildGridItem,
//           );
//         }),
//       ),
//       onSelectionStart: selection.start,
//       onSelectionUpdate: selection.update,
//     );
//   }
// }

// class RectSelection extends ItemSelection {
//   RectSelection(this.columns);

//   final int columns;
//   ItemSelection oldSelection = ItemSelection();

//   int rowAt(int index) => index ~/ columns;
//   int columnAt(int index) => index % columns;
//   int indexAt(int row, int column) => column + row * columns;

//   bool start(int start, int end) {
//     oldSelection = ItemSelection(start, end);
//     return false;
//   }

//   bool update(int start, int end) {
//     // calculate rectangular selection bounds
//     final startRow = rowAt(min(start, end));
//     final endRow = rowAt(max(start, end));
//     final startColumn = columnAt(min(start, end));
//     final endColumn = columnAt(max(start, end));

//     // construct new rectangular selection row by row
//     final newSelection = ItemSelection();
//     for (int r = startRow; r <= endRow; ++r) {
//       final startIndex = indexAt(r, startColumn);
//       final endIndex = indexAt(r, endColumn);
//       newSelection.add(startIndex, endIndex);
//     }

//     // apply selection changes
//     addAll(ItemSelection.copy(newSelection)..removeAll(oldSelection));
//     removeAll(ItemSelection.copy(oldSelection)..removeAll(newSelection));

//     oldSelection = newSelection;
//     return true;
//   }
// }
