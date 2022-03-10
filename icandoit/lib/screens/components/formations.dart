import 'package:flutter/material.dart';
import 'package:icandoit/filp_main.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Formations extends StatelessWidget {
  const Formations({Key key}) : super(key: key);

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
                  "Liste et suivi de vos formations",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset("assets/listeFomation.json", width: 60),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000509155-cr%C3%A9er-un-challenge",
            etape: 'Etape 1',
            typeChallenge1: ' Créer une mission',
            typeChallenge: 'de type "hebdomadaire"',
            lottiesChallenge: "assets/challengeQuotidien.json",
            assetPictureChallengeeCreer: 'assets/listeHebdo.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "Imaginez que vous avez une liste de formation ou de matière a travailler régulièrement et que vous souhaitez avoir un suivi précis des avancements. Easytodo vous assistera pleinement dans cette tâche. Créer une mission hebdomadaire que vous nommerez Formation et sélectionner les jours de la semaine que vous avez réservé pour étudier.",
            actionChallenge2: 'Créer un challenge quotidien',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer la liste de toutes',
            typeChallenge: ' vos formations ',
            lottiesChallenge: "assets/listeFomation.json",
            assetPictureChallengeeCreer: 'assets/listeFormation.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "Rentrer les différentes formations que vous étudiez en créant un évenement de type formations. Ce type d'évenement comporte des options adapté a ce type de liste.",
            actionChallenge2: 'Eléments et documentations  possibles',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 3',
            typeChallenge1: "Validation de l'avancé",
            typeChallenge: "de vos formations",
            lottiesChallenge: "assets/validateRecette.json",
            assetPictureChallengeeCreer: 'assets/validEtape.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire un gâteau aux chocolat',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "A chaque formation suivi, vous pouvez par un swipe vers la gauche valider que cette formation a ete faite. ",
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000804234-sauvegarde-et-restauaration-automatique",
            etape: 'Fonction',
            typeChallenge1: " Vérifier l'état d'avancement",
            typeChallenge: ' de votre formation',
            lottiesChallenge: "assets/verifyEtat.json",
            assetPictureChallengeeCreer: 'assets/etatAvancement.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "En cliquant sur une des formation existante vous avez la possibilité de vérifier l'avancement de chaque formation. ",
            actionChallenge2: 'Sauvegarde et restauration automatique',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Option',
            typeChallenge1: "Modifier l'état de votre ",
            typeChallenge: "parcours de formation ",
            lottiesChallenge: "assets/modifierEtat.json",
            assetPictureChallengeeCreer: 'assets/formation.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "Vous pouvez aussi a tout moment modifier l'état de votre parcours de formation en sélectionnant en forme de crayon. Cela vous permettra de reprendre exactement l'endroit ou vous avez arrêter votre formation la dernière fois. ",
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/formation1.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Option',
            typeChallenge1: "Une sauvegarde et une reatauration",
            typeChallenge: ' hebdomadaire se fera automatiquement',
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/bacup.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge:
                "Chaque tâches valider sera restaurer les jours que vous avez sélectionner, en gardant en mémoire l'état d'avancement de votre derniere connexion ",
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/formation1.gif'),
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
    //       child: Text("Liste de formations ",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Imaginez que vous avez une liste de formation ou de matière a travailler régulièrement et que vous souhaitez avoir un suivi précis des avancements. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Easytodo vous assistera pleinement dans cette tâche. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Créer une mission hebdomadaire que vous nommerez Formation et sélectionner les jours de la semaine que vous avez réservé pour étudier. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour la procédure",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000509155-cr%C3%A9er-un-challenge");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //     Text(
    //         "Sélectionner votre mission pour rentrer les différentes formations que vous réaliser en ce moment.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "En cliquant sur une des formation existante vous avez la possibilité de vérifier l'avancement de chaque formation.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Vous pouvez aussi a tout moment modifier l'état de votre parcours de formation en sélectionnant en forme de crayon .",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Cela vous permettra de reprendre exactement l'endroit ou vous avez arrêter votre formation la dernière fois. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Chaque tâches valider sera restaurer les jours que vous avez sélectionner, en gardant en mémoire l'état d'avancement de votre derniere connexion .",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/formation1.gif'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Une notification hebdomadaire sera active pour vous rappeler et vous encourager a reprendre vos formations.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(" Il y a la possibilité de modifier le prix de l'article.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/formation.gif'),
    //     ),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Text(
    //         "Vous pouvez faire une sauvegarde de votre liste d'article pour réutilisez cette liste d'article le mois prochain",
    //         style: TextStyle(
    //             color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
    //     SizedBox(
    //       height: 10,
    //     ),
    //   ],
    // );
  }
}
