import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class AdressMap extends StatefulWidget {
  final Challengemodel2 item;
  final int indexChallenge;

  AdressMap({Key key, this.indexChallenge, this.item}) : super(key: key);

  @override
  _AdressMapState createState() => _AdressMapState();
}

class _AdressMapState extends State<AdressMap> {
  @override
  Widget build(BuildContext context) {
    void _launchMapsUrl() async {
      final url =
          'comgooglemaps://?daddr=${Uri.encodeFull("genipa,ducos,centre commercial")}&directionsmode=driving';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

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
              child: IconButton(
            alignment: Alignment.topRight,
            icon: Icon(
              Icons.map_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              _launchMapsUrl();
            },
          )),
        ),
      ),
    );
  }
}
