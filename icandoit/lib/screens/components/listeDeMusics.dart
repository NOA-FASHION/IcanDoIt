

import 'package:flutter/material.dart';
import 'package:icandoit/filp_main.dart';
import 'package:lottie/lottie.dart';


class ListeDeMusics extends StatelessWidget {
  const ListeDeMusics({Key key}) : super(key: key);

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
                  "Créer ma playlist de music",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset("assets/music1.json", width: 60),
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
            typeChallenge: ' de type "Normal"',
            lottiesChallenge: "assets/missionNormal.json",
            assetPictureChallengeeCreer: 'assets/music.png',
            titreChallenge: 'Challenges Normal',
            titreChallenge2: 'Créer ma playlist de music',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Si vous souhaitez enregistré une liste de music ou de reportage youtube."),
                Text(
                    " Pour créer votre playliste,vous devez d'abord créer un challenge de type normal. ")
              ],
            ),
            actionChallenge2: 'Créer un challenge Normal',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer la liste de music',
            typeChallenge: ' que vous souhaitez',
            lottiesChallenge: "assets/recetteEtape.json",
            assetPictureChallengeeCreer: 'assets/listemusic.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Créer ma playlist de music',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "créer un élément de type youtube pour chaque music que vous souhaitez écouter."),
            actionChallenge2: 'documentations  possibles',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 3',
            typeChallenge1: 'Validation des étapes',
            typeChallenge: "importante de votre recette",
            lottiesChallenge: "assets/validateRecette.json",
            assetPictureChallengeeCreer: 'assets/fairegateauxauchocolat3.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Créer ma playlist de music',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Lors de la réalisation de votre recette valider chaque étape par un swipe vers la gauche, ou consulter a tout moment la documentation visuel ou auditive associer a votre mission"),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Fonction',
            typeChallenge1: ' Ecouter votre playlist',
            typeChallenge: '  en continue',
            lottiesChallenge: "assets/music1.json",
            assetPictureChallengeeCreer: 'assets/music2.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Créer ma playlist de music',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Automatiquement une icône youtube apparaît en haut a gauche de votre Ecran vous donnant la possibilité d'écouter votre liste de musique l'un a la suite de l'autre. "),
            actionChallenge2: 'Documentations  possibles',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000513743",
            etape: 'Option',
            typeChallenge1: 'Réaliser une',
            typeChallenge: "Sauvegarde manuelle",
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/FaireGateauxAuChocoalat1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Créer ma playlist de music',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Il est conseillé de faire une sauvegarde de votre playListe en faisant un appuie long sur la mission."),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804380",
            etape: 'Option',
            typeChallenge1: 'Partager facilement',
            typeChallenge: "  votre playlist",
            lottiesChallenge: "assets/share2.json",
            assetPictureChallengeeCreer: 'assets/music1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Créer ma playlist de music',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    " Vous pouvez partagez votre liste a quelqu'un facilement en sélectionnant l'icône de partage en haut a droite de votre liste d'étape."),
                Text("Vous aurez le choix de l'envoyer par email, watsapp ,etc")
              ],
            ),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/music1.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804380",
            etape: 'Option',
            typeChallenge1: 'Uploader facilement',
            typeChallenge: "  votre playlist",
            lottiesChallenge: "assets/upload3.json",
            assetPictureChallengeeCreer: 'assets/uploadMusic.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Créer ma playlist de music',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                " Vous pouvez uoploader une liste qu'un de vos amies vous a envoyé."),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/music1.gif'),
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
    //       child: Text("Liste de musiques",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Si vous souhaitez enregistré une liste de music ou de reportage youtube.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Cela est très simple a réaliser", style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Créer une mission Normal.", style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour la procédure",
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    //     SizedBox(
    //       height: 10,
    //     ),
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
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Sélectionner votre mission pour rentrer les différentes liens YouTube que vous souhaitez. ",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Automatiquement une icône youtube apparaît en haut a gauche de votre Ecran vous donnant la possibilité d'écouter votre liste de musique l'un a la suite de l'autre.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/music2.gif'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Vous pouvez partagez votre liste a quelqu'un facilement en sélectionnant l'icône de partage en haut a droite de votre liste d'étape.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Vous aurez le choix de l'envoyer par email, watsapp ,etc",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/music1.gif'),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //   ],
    // );
  }
}
