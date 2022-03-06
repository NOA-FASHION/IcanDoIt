import 'package:flutter/material.dart';
import 'package:icandoit/filp_main.dart';
import 'package:url_launcher/url_launcher.dart';

class ListeTacheQuotidienne extends StatelessWidget {
  const ListeTacheQuotidienne({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70),
        FlipLayoutDemo(
            etape: 'Etape 1',
            typeChallenge: 'de type "quotidien"',
            lottiesChallenge: "assets/challengeQuotidien.json",
            assetPictureChallengeeCreer: 'assets/challengeQuotidien.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos taches quotidiennes',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: "Sélectionner la mission que vous venez de créer.",
            actionChallenge2: 'Créer un challenge quotidien',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            etape: 'Etape 2',
            typeChallenge: 'de type "quotidien"',
            lottiesChallenge: "assets/challengeQuotidien.json",
            assetPictureChallengeeCreer: 'assets/challengeQuotidien.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos taches quotidiennes',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: "Sélectionner la mission que vous venez de créer.",
            actionChallenge2: 'Créer un challenge quotidien',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            etape: 'Etape 3',
            typeChallenge: 'de type "quotidien"',
            lottiesChallenge: "assets/challengeQuotidien.json",
            assetPictureChallengeeCreer: 'assets/challengeQuotidien.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos taches quotidiennes',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: "Sélectionner la mission que vous venez de créer.",
            actionChallenge2: 'Créer un challenge quotidien',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 70),
      ],
    );
    // void _launchMapsUrl(String lien) async {
    //   final url = lien;
    //   if (await canLaunch(url)) {
    //     await launch(url);
    //   } else {
    //     throw 'Could not launch $url';
    //   }
    // }

    // const bodyStyle = TextStyle(fontSize: 17.0);
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.only(top: 70),
    //       child: Text("Lister vos taches quotidiennes",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "La meilleur pratique est la suivante: Créer une mission quotidienne:",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour la procédure",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513695-cr%C3%A9er-challenge-quotidien");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //     Text(
    //         "Sélectionner ensuite la mission que vous venez de créer, puis confectionnez des éléments illustrant les tâches que vous pensez réalisez quotidiennement. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour la procédure",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //     Text(
    //         "Vous disposez de plusieurs options récurrentes, pour vous accompagnez.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(" Comment cela fonctionne t'il?",
    //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Chaque tache quotidienne que vous allez associer a votre mission sera sauvegardée et restaurée chaque jour automatiquement.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Exemple: Imaginez que vous avez validé les  tache 1, 2 et 5  aujourd'hui",
    //         style: TextStyle(fontSize: 16, color: Colors.green)),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/quotidienne1.png'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Les taches validées seront restaurées le jour suivant. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Une notification quotidienne sera active pour vous rappeler et vous encourager dans vos taches quotidiennes.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/quotidienne2.png'),
    //     ),
    //     SizedBox(
    //       height: 15,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/lister.gif'),
    //     ),
    //     SizedBox(
    //       height: 18,
    //     ),
    //     Text(
    //         "Chaque élément qui compose la mission peut être commentaire, un lien youtube, un prix, une informations. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/docs.png'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/liste3.gif'),
    //     ),
    //   ],
    // );
  }
}
