import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Formations extends StatelessWidget {
  const Formations({Key key}) : super(key: key);

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
          child: Text("Liste de formations ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Imaginez que vous avez une liste de formation ou de matière a travailler régulièrement et que vous souhaitez avoir un suivi précis des avancements. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Easytodo vous assistera pleinement dans cette tâche. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Créer une mission hebdomadaire que vous nommerez Formation et sélectionner les jours de la semaine que vous avez réservé pour étudier. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Ci joint le lien pour la procédure",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
        Text(
            "Sélectionner votre mission pour rentrer les différentes formations que vous réaliser en ce moment.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "En cliquant sur une des formation existante vous avez la possibilité de vérifier l'avancement de chaque formation.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Vous pouvez aussi a tout moment modifier l'état de votre parcours de formation en sélectionnant en forme de crayon .",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Cela vous permettra de reprendre exactement l'endroit ou vous avez arrêter votre formation la dernière fois. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Chaque tâches valider sera restaurer les jours que vous avez sélectionner, en gardant en mémoire l'état d'avancement de votre derniere connexion .",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/formation1.gif'),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Une notification hebdomadaire sera active pour vous rappeler et vous encourager a reprendre vos formations.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(" Il y a la possibilité de modifier le prix de l'article.",
            style: bodyStyle),
        SizedBox(
          height: 19,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/formation.gif'),
        ),
        SizedBox(
          height: 19,
        ),
        Text(
            "Vous pouvez faire une sauvegarde de votre liste d'article pour réutilisez cette liste d'article le mois prochain",
            style: TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
