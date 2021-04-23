import 'package:advance_text_field/advance_text_field.dart';
import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FormationEdit extends StatefulWidget {
  final Challengemodel2 item;
  final int indexChallenge;

  FormationEdit({Key key, this.indexChallenge, this.item}) : super(key: key);

  @override
  _FormationEditState createState() => _FormationEditState();
}

class _FormationEditState extends State<FormationEdit> {
  @override
  Widget build(BuildContext context) {
    final Challengecontroller provider =
        Provider.of<Challengecontroller>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SafeArea(
          child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              padding: EdgeInsets.only(right: 30.0),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      body: Shimmer(
        duration: Duration(seconds: 3),
        interval: Duration(seconds: 5),
        color: Colors.white,
        enabled: true,
        direction: ShimmerDirection.fromLTRB(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.blue])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AdvanceTextField(
                  type: AdvanceTextFieldType.EDIT,
                  editLabel: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  saveLabel: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  textHint: widget.item.formation.chapitre,
                  onEditTap: () {},
                  onSaveTap: (text) {
                    print('value is: $text');
                    provider.addformationChapitre(
                        indexChallenge: widget.indexChallenge,
                        index: int.parse(widget.item.index),
                        chapitre: text);
                  },
                ),
                AdvanceTextField(
                  type: AdvanceTextFieldType.EDIT,
                  editLabel: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  saveLabel: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  // textHint: provider.getChallenges()[widget.indexChallenge].listeDeTache[int.tryParse(widget.item.index)].formation.chapitre,
                  textHint: widget.item.formation.duree,
                  onEditTap: () {},
                  onSaveTap: (text) {
                    print('value is: $text');
                    provider.addformationDuree(
                        indexChallenge: widget.indexChallenge,
                        index: int.parse(widget.item.index),
                        duree: text);
                  },
                ),
                AdvanceTextField(
                  type: AdvanceTextFieldType.EDIT,
                  editLabel: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  saveLabel: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  textHint: widget.item.formation.theoriePratique,
                  onEditTap: () {},
                  onSaveTap: (text) {
                    provider.addformationTheoriePratique(
                        indexChallenge: widget.indexChallenge,
                        index: int.parse(widget.item.index),
                        theoriePratique: text);
                    print('value is: $text');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
