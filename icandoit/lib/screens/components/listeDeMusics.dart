import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListeDeMusics extends StatelessWidget {
  const ListeDeMusics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchMapsUrl(String lien) async {
      final url = lien;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    const bodyStyle = TextStyle(fontSize: 17.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 70),
          child: Text("Liste de musiques",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Si vous souhaitez enregistré une liste de music ou de reportage youtube.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Cela est très simple a réaliser", style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Créer une mission Normal.", style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Ci joint le lien pour la procédure",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        IconButton(
            onPressed: () {
              _launchMapsUrl(
                  "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000509155-cr%C3%A9er-un-challenge");
            },
            icon: Icon(
              Icons.link,
              size: 40,
              color: Colors.blue,
            )),
        SizedBox(
          height: 10,
        ),
        Text(
            "Sélectionner votre mission pour rentrer les différentes liens YouTube que vous souhaitez. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Automatiquement une icône youtube apparaît en haut a gauche de votre Ecran vous donnant la possibilité d'écouter votre liste de musique l'un a la suite de l'autre.",
            style: bodyStyle),
        SizedBox(
          height: 19,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/music2.gif'),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Vous pouvez partagez votre liste a quelqu'un facilement en sélectionnant l'icône de partage en haut a droite de votre liste d'étape.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Vous aurez le choix de l'envoyer par email, watsapp ,etc",
            style: bodyStyle),
        SizedBox(
          height: 19,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/music1.gif'),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
