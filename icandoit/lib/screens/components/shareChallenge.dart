import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icandoit/filp_main.dart';
import 'package:lottie/lottie.dart';

class ShareChallenge extends StatelessWidget {
  const ShareChallenge({Key key}) : super(key: key);

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
                  "Quelques fonctions intéressantes".toUpperCase(),
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
                  child: Lottie.asset("assets/fonctions1.json", width: 60),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000513740",
            etape: 'Option',
            typeChallenge1: 'Partager facilement',
            typeChallenge: "  votre playlist",
            lottiesChallenge: "assets/share2.json",
            assetPictureChallengeeCreer: 'assets/music1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: "Quelques fonctions intéressantes",
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Vous pouvez partagez votre liste avec quelqu'un facilement en sélectionnant l'icône de partage en haut à droite de votre liste d'étapes."),
                Text(
                    "Vous aurez le choix de l'envoyer par email, watsapp, etc...")
              ],
            ),
            actionChallenge2: 'Partager un challenge',
            pictureChallenge: 'assets/music1.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000513841",
            etape: 'Option',
            typeChallenge1: 'Uploader facilement',
            typeChallenge: "  votre playlist",
            lottiesChallenge: "assets/upload3.json",
            assetPictureChallengeeCreer: 'assets/uploadMusic.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: "Quelques fonctions intéressantes",
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Vous pouvez uploader une liste qu'un de vos amis vous a envoyé."),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            actionChallenge2: 'Uploader un challenge',
            pictureChallenge: 'assets/music1.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000805279",
            etape: 'Fonction',
            typeChallenge1: ' Désactiver la vue ',
            typeChallenge: "principale d'une mission ",
            lottiesChallenge: "assets/verifyEtat.json",
            assetPictureChallengeeCreer: 'assets/restaurant2.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: "Quelques fonctions intéressantes",
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Lorsque vous réalisez une structure complexe pour une todolist composée de plusieurs arborescences, comme par exemple 'travaux de rénovation', vous pouvez désactiver la vue d'un challenge dans la liste principale.")
              ],
            ),
            actionChallenge2: 'Désactiver une vue ',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000513746",
            etape: 'Fonction',
            typeChallenge1: 'Voir le score de ',
            typeChallenge: "vos challenges",
            lottiesChallenge: "assets/succes2.json",
            assetPictureChallengeeCreer: 'assets/score.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: "Quelques fonctions intéressantes",
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Visualisez en live vos performances concernant la réalisation de vos challenges en cours."),
            actionChallenge2: 'Score de vos challenges',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000513704",
            etape: 'Option',
            typeChallenge1: 'Paramétrez facilement ',
            typeChallenge: " des notifications .",
            lottiesChallenge: "assets/notification.json",
            assetPictureChallengeeCreer: 'assets/music1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: "Quelques fonctions intéressantes",
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Selon votre choix périodique, Une notification automatique sera active pour vous rappeler et vous encourager dans vos tâches quotidiennes."),
            actionChallenge2: 'Notifications',
            pictureChallenge: 'assets/music1.gif'),
        SizedBox(height: 30),
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
    //       child: Text("partager et uploader ",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Vous pouvez soit récupéré un challenge qu'un ami ou votre chef vous a envoyé ou partager un procès ou des missions que vous avez confectionnez au petit oignons.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "pour récupérer un challenge , vous devez au préalable récupérer le challenge sur une plateforme de partage que votre interlocuteur vous aurais envoyez au préalable tel que watsapp ou par email , etc.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Ensuite vous cliquez sur le bouton en haut a droite des challenges qui va vous redirigez sur les dossiers de partage votre téléphone.ensuite il suffit de sélectionner le challenge que vous voulez récupérer.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/upload.gif'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Pour le partage il faut d'abord sélection le challenge que vous souhaitez partager et cliquez sur le bouton partage en haut a droite , cela vous redirigera vers une plateforme de partage soit watsapp, drive ou encore votre boite email, etc.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour la procédure pour uploader un challenge",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513841-uploader-un-challenge");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/download.gif'),
    //     ),
    //     Text("Ci joint le lien pour la procédure pour downloader un challenge",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     IconButton(
    //         onPressed: () {
    //           _launchMapsUrl(
    //               "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513740-partager-un-challenge");
    //         },
    //         icon: Icon(
    //           Icons.link,
    //           size: 40,
    //           color: Colors.blue,
    //         )),
    //   ],
    // );
  }
}
