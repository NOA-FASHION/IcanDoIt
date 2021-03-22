import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayUrl extends StatelessWidget {
  final String nameChallenge;
  const PlayUrl({Key key, this.nameChallenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Initial URL"),
        ),
        body: WebView(
          initialUrl: nameChallenge,
        ),
      ),
    );
  }
}
