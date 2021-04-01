import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class PlayYoutubeScreen extends StatefulWidget {
  final String nameChallenge;
  const PlayYoutubeScreen({Key key, this.nameChallenge}) : super(key: key);

  @override
  _PlayYoutubeScreenState createState() => _PlayYoutubeScreenState();
}

class _PlayYoutubeScreenState extends State<PlayYoutubeScreen> {
  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();

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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
            initialUrl: widget.nameChallenge,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
