import 'package:flutter/material.dart';

class ListeTacheQuotidienne extends StatelessWidget {
  const ListeTacheQuotidienne({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 17.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 35),
          child: Text("Lister vos taches quotidiennes",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "La meilleur pratique est la suivante: Créer une mission quotidienne:",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Ci joint le lien pour la procédure",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Text(
            "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513695-cr%C3%A9er-challenge-quotidien",
            style: TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Text(
            "Sélectionner ensuite la mission que vous venez de créer, puis confectionnez des éléments illustrant les tâches que vous pensez réalisez quotidiennement. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Ci joint le lien pour la procédure",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Text(
            "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            style: TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Text(
            "Vous disposez de plusieurs options récurrentes, pour vous accompagnez.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(" Comment cela fonctionne t'il?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Text(
            "Chaque tache quotidienne que vous allez associer a votre mission sera sauvegardée et restaurée chaque jour automatiquement.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Exemple: Imaginez que vous avez validé les  tache 1, 2 et 5  aujourd'hui",
            style: TextStyle(fontSize: 16, color: Colors.green)),
        SizedBox(
          height: 10,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/quotidienne1.png'),
        ),
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
          image: AssetImage('assets/quotidienne2.png'),
        ),
        SizedBox(
          height: 15,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/lister.gif'),
        ),
        SizedBox(
          height: 18,
        ),
        Text(
            "Chaque élément qui compose la mission peut être commentaire, un lien youtube, un prix, une informations. ",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/docs.png'),
        ),
        SizedBox(
          height: 10,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/liste3.gif'),
        ),
      ],
    );
  }
}
