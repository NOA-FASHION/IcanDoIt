import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListeDeCourses extends StatelessWidget {
  const ListeDeCourses({Key key}) : super(key: key);

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
          child: Text("Faire une liste de course",
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
            )),
        Text(
            "Sélectionner votre mission pour rentrer les différents articles avec leur prix que vous allez acheter.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Créer un élément de type 'achat' pour chaque articles que vous souhaitez rentrer.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Ci joint le lien pour créer une tâche ou un commentaire",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        IconButton(
            onPressed: () {
              _launchMapsUrl(
                  "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible");
            },
            icon: Icon(
              Icons.link,
              size: 40,
              color: Colors.blue,
            )),
        Text(
            "Un compteur apparait avec les informations suivantes: achats et prévisions.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Les chiffres de vos prévisions d'achat ainsi que l'addition total en live de vos achat valider apparaisse en haut de votre écran.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Les prévisions représentes l'addition du prix tous les articles crées et les achats sont le total de ceux que vous avez validé.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/listeDeCourse.gif'),
        ),
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
          image: AssetImage('assets/listedecourse2.gif'),
        ),
        SizedBox(
          height: 19,
        ),
        Text(
            "Vous pouvez faire une sauvegarde de votre liste d'article pour réutilisez cette liste d'article le mois prochain",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
