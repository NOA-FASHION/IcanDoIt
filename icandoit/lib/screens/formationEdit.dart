import 'package:advance_text_field/advance_text_field.dart';
import 'package:flutter/material.dart';

class FormationEdit extends StatefulWidget {
  final String chapitre;
  final String duree;
  final String theoriePratique;

  FormationEdit({Key key, this.chapitre, this.duree, this.theoriePratique})
      : super(key: key);

  @override
  _FormationEditState createState() => _FormationEditState();
}

class _FormationEditState extends State<FormationEdit> {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              textHint: widget.chapitre,
              onEditTap: () {},
              onSaveTap: (text) {
                print('value is: $text');
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
              textHint: widget.duree,
              onEditTap: () {},
              onSaveTap: (text) {
                print('value is: $text');
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
              textHint: widget.theoriePratique,
              onEditTap: () {},
              onSaveTap: (text) {
                print('value is: $text');
              },
            ),
          ],
        ),
      ),
    );
  }
}
