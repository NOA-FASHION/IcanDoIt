import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icandoit/filp_main.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Formations extends StatelessWidget {
  const Formations({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 95),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              margin: EdgeInsets.only(top: 35),
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
                  "Liste et suivi de vos formations".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // gradient: LinearGradient(
                  //     begin: Alignment.centerLeft,
                  //     end: Alignment.centerRight,
                  //     colors: [Colors.orange, Colors.blue]),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Lottie.asset("assets/school.json", width: 40),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000509420",
            etape: 'Etape 1',
            typeChallenge1: ' Créer une mission de',
            typeChallenge: ' type "hebdomadaire"',
            lottiesChallenge: "assets/challengeQuotidien.json",
            assetPictureChallengeeCreer: 'assets/listeHebdo.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Imaginez que vous avez une liste de formation ou de matière à travailler régulièrement et que vous souhaitez avoir un suivi précis de votre progression."),
                Text(
                    "Vous devez créer une mission hebdomadaire et sélectionner les jours de la semaine que vous avez réservé pour étudier."),
              ],
            ),
            actionChallenge2: 'Créer un challenge hebdomadaire',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer la liste  ',
            typeChallenge: ' de vos formations ',
            lottiesChallenge: "assets/listeFomation.json",
            assetPictureChallengeeCreer: 'assets/listeFormation.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Rentrer les différentes formations que vous étudiez en créant pour chaque matière un évènement de type formations."),
            actionChallenge2: 'Eléments et documentations ',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804649",
            etape: 'Etape 3',
            typeChallenge1: " Validation de l'état",
            typeChallenge: ' de votre progression',
            lottiesChallenge: "assets/validateRecette.json",
            assetPictureChallengeeCreer: 'assets/validEtape.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Vous pouvez par un swipe vers la gauche valider l'assimilation de chaque étape de votre formation. "),
            actionChallenge2: 'Validation des challenges',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804652",
            etape: 'Fonction',
            typeChallenge1: " vérification de l'état",
            typeChallenge: ' de votre progression',
            lottiesChallenge: "assets/verifyEtat.json",
            assetPictureChallengeeCreer: 'assets/etatAvancement.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Vous avez la possibilité de vérifier votre progression, en cliquant sur une des formations existante. "),
            actionChallenge2: 'visualiser votre progression',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804653",
            etape: 'Option',
            typeChallenge1: "Modifier l'état de votre ",
            typeChallenge: "parcours de formation ",
            lottiesChallenge: "assets/modifierEtat.json",
            assetPictureChallengeeCreer: 'assets/formation.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Vous pouvez aussi a tout moment modifier la progression de votre parcours de formation en sélectionnant l'icône en forme de crayon. "),
                Text(
                    "Cela vous permettra de reprendre votre formation exactement à l'endroit ou vous vous êtes arrêté la dernière fois. ")
              ],
            ),
            actionChallenge2: 'Modification progression',
            pictureChallenge: 'assets/formation1.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804234",
            etape: 'Option',
            typeChallenge1: "Sauvegarde et restauration",
            typeChallenge: ' hebdomadaire auto',
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/bacup.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Liste de formations',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "la totalité des évènements seront restaurés à leurs états initials à chaque journée de la semaine que vous avez choisi lors de la création de votre mission hebdomadaire."),
            actionChallenge2: 'Sauvegarde et restauration',
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
