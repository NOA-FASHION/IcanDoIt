import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayUrl extends StatelessWidget {
  final String nameChallenge;
  const PlayUrl({Key key, this.nameChallenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
        body: WebView(
          initialUrl: nameChallenge,
        ),
      ),
    );
  }
}
