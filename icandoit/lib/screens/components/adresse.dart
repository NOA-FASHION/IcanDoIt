import 'package:flutter/material.dart';
import 'package:icandoit/controllers/challenge_controller.dart';
import 'package:icandoit/models/challenge_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class AdressMap extends StatefulWidget {
  final String adresse;

  AdressMap({Key key, this.adresse}) : super(key: key);

  @override
  _AdressMapState createState() => _AdressMapState();
}

class _AdressMapState extends State<AdressMap> {
  @override
  Widget build(BuildContext context) {
    List<String> result = widget.adresse.split("/ ");
    void _launchMapsUrl() async {
      // final url =
      //     'comgooglemaps://?daddr=${Uri.encodeFull("genipa,ducos,centre commercial")}&directionsmode=driving';
      final url =
          "https://www.google.com/maps/search/${Uri.encodeFull(widget.adresse)}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    // final Challengecontroller provider =
    //     Provider.of<Challengecontroller>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SafeArea(
          child: AppBar(
            title: Text("Adresse"),
            centerTitle: true,
            flexibleSpace: Container(
              height: 130,
              padding: EdgeInsets.only(top: 40.0, right: 30.0),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(10),
                  child: Text("Nom: " + result[0])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.all(10),
                      child: Text("Téléphone: " + result[1])),
                  IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      launch("tel://${result[1]}");
                    },
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(10),
                  child: Text("Adresse: " + result[2])),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(10),
                  child: Text("Commune: " + result[3])),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(10),
                  child: Text("Pays: " + result[4])),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: InkWell(
                  // splash color
                  splashColor: Colors.white,
                  onTap: () {
                    _launchMapsUrl();
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.map,
                        size: 90,
                        color: Colors.white,
                      ), // icon
                      Text(
                        "GOOGLE MAPS",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ), // text
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
