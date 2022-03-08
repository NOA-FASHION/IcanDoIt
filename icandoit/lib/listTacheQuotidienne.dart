import 'package:flutter/material.dart';
import 'package:icandoit/filp_main.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ListeTacheQuotidienne extends StatelessWidget {
  const ListeTacheQuotidienne({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(top: 45),
              height: 70,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.orange, Colors.blue]),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue,
                  width: 4,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lister vos évenements quotidiens",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset("assets/sheduleDays.json", width: 60),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513695-cr%C3%A9er-challenge-quotidien",
            etape: 'Etape 1',
            typeChallenge1: ' Créer un challenge',
            typeChallenge: 'de type "quotidien"',
            lottiesChallenge: "assets/challengeQuotidien.json",
            assetPictureChallengeeCreer: 'assets/challengeQuotidien.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos taches quotidiennes',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "Pour lister éfficacement les évenements importants de votre journée. Vous devez d'abord créer un challenge de type quotidien. Ce type de challenge comporte des options adapter au type de liste que vous souhaitez utiliser ",
            actionChallenge2: 'Créer un challenge quotidien',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer la liste de toutes',
            typeChallenge: ' les Etapes de votre journée',
            lottiesChallenge: "assets/etapeJournee.json",
            assetPictureChallengeeCreer: 'assets/tacheQuotidienne.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos taches quotidiennes',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "confectionnez des éléments illustrant les tâches que vous pensez réalisez quotidiennement",
            actionChallenge2: 'Eléments et documentations  possibles',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000804234-sauvegarde-et-restauaration-automatique",
            etape: 'Fonction',
            typeChallenge1: ' Les tâches associer à votre mission seront',
            typeChallenge: ' Sauvegardez et restaurez quotidiennement"',
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/lister.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos taches quotidiennes',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "Imaginez que vous avez validé les  tache 1, 2 et 5  aujourd'hui. Les taches validées seront restaurées le jour suivant.",
            actionChallenge2: 'Sauvegarde et restauration automatique',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Option',
            typeChallenge1: 'Types de documenations',
            typeChallenge: "qu'il est possible de créer ",
            lottiesChallenge: "assets/digital.json",
            assetPictureChallengeeCreer: 'assets/docs.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Lister vos taches quotidiennes',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "Chaque élément qui compose la mission peut être un commentaire, un lien youtube, un prix, une informations.",
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/assets/lister.gif'),
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
