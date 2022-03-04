import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TravauxDeRenovation extends StatelessWidget {
  const TravauxDeRenovation({Key key}) : super(key: key);

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
          child: Text("Travaux de rénovation",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Créer une mission Normal.", style: bodyStyle),
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
            "Sélectionner votre mission pour rentrer les différentes informations et documents associé aux travaux que vous devez effectuer. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Créer un élément de type 'projet' pour chaque pièce de la maison, par exemple:",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Projet chambre ,Projet salle à manger,Projet salle de bain,Projet cuisine,Projet salon,Projet terrasse",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            'Sélectionner un des projet  par exemple "Chambres" et créer un ensemble de documentations et de taches concernant ce projet.',
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Par exemples:", style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Une liste de tutoriel concernant des travaux en relation avec le projet chambre.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Une autre liste de photos et videos de meuble ou matériaux avec leur ref et leur prix.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "une autre liste  du prix des matériaux et objets  a acheter pour le  projet chambre.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "une liste  des choses a réaliser des choses a réaliser pour le projet chambre.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Les taches validées seront restaurées le jour suivant. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Une notification quotidienne sera active pour vous rappeler et vous encourager dans vos taches quotidiennes.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/travaux1.png'),
        ),
        SizedBox(
          height: 15,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/travaux.gif'),
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
