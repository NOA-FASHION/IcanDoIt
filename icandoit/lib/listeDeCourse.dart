import 'package:flutter/material.dart';
import 'package:icandoit/filp_main.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ListeDeCourses extends StatelessWidget {
  const ListeDeCourses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70),
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
                  "Faire une liste de course",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
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
                  child: Lottie.asset("assets/courseList1.json", width: 45),
                ),
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
            assetPictureChallengeeCreer: 'assets/courses.png',
            titreChallenge: 'Challenges Normal',
            titreChallenge2: 'Faire une liste de course',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text("Pour lister les articles que vous pensez acheter."),
                Text("Vous devez d'abord créer un challenge de type normal. ")
              ],
            ),
            actionChallenge2: 'Créer un challenge Normal',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513812-documentation-possible",
            etape: 'Etape 2',
            typeChallenge1: ' Créer la liste de ',
            typeChallenge: ' tous les articles',
            lottiesChallenge: "assets/recetteEtape.json",
            assetPictureChallengeeCreer: 'assets/listecourses.png',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire une liste de course',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Créer un élément de type 'achat' pour chaque articles que se trouve dans votre cadie."),
            actionChallenge2: 'documentations  possibles',
            pictureChallenge: 'assets/challengeQuotidien.png'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804649",
            etape: 'Etape 3',
            typeChallenge1: 'Validation en live',
            typeChallenge: "des achats effectués",
            lottiesChallenge: "assets/validateRecette.json",
            assetPictureChallengeeCreer: 'assets/validateFormation.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire une liste de course',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                "Lors de la création de votre liste de courses, valider chaque achat par un swipe vers la gauche."),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804659",
            etape: 'Fonction',
            typeChallenge1: ' Acces aux informations ',
            typeChallenge: " d'achats et de prévisions.",
            lottiesChallenge: "assets/accederDoc.json",
            assetPictureChallengeeCreer: 'assets/listeDeCourse.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire une liste de course',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(children: [
              Text(
                  "Un compteur apparait avec les informations suivantes: achats et prévisions."),
              new ListTile(
                leading: Icon(Icons.fiber_manual_record),
                title: new Text(
                    '  le compteur achat repésente la somme de vos achats'),
              ),
              new ListTile(
                  leading: Icon(Icons.fiber_manual_record),
                  title: new Text(
                      "le compteur prévision représente la somme de vos prévision d'achat."))
            ]),
            actionChallenge2: 'Documentations  possibles',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804653",
            etape: 'Option',
            typeChallenge1: 'Modification en live',
            typeChallenge: "du prix des articles",
            lottiesChallenge: "assets/calculator.json",
            assetPictureChallengeeCreer: 'assets/listedecourse2.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire une liste de course',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Vous avez la possibilité de modifier le prix des articles. "),
                Text(
                    "    Ce qui aura pour conséquence la modification en live les valeurs du compteur d'achat et du compteur de prévision "),
              ],
            ),
            actionChallenge2: 'Modifier ',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000513743",
            etape: 'Option',
            typeChallenge1: 'Réaliser facilement une',
            typeChallenge: " Sauvegarde manuelle",
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/FaireGateauxAuChocoalat1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire une liste de course',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Column(
              children: [
                Text(
                    "Avant de valider chaque achats, il est conseillé de faire une sauvegarde de votre liste de course."),
                Text("Cela vous permettra de la réétuliser le mois d'apres."),
              ],
            ),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/lister.gif'),
        SizedBox(height: 30),
        FlipLayoutDemo(
            lienInternet:
                "https://newaccount1626188315630.freshdesk.com/a/solutions/articles/69000804380",
            etape: 'Option',
            typeChallenge1: 'Réaliser facilement une',
            typeChallenge: "Restauration manuelle",
            lottiesChallenge: "assets/backup.json",
            assetPictureChallengeeCreer: 'assets/FaireGateauxAuChocoalat1.gif',
            titreChallenge: 'Challenges quotidien',
            titreChallenge2: 'Faire une liste de course',
            descriptionChallenge: 'Liste des challenges',
            prioriteChallenge: 'Quotidien',
            actionChallenge: Text(
                " Vous pourrez à tout moment effectuer une restauration manuelle des articles enregistrés"),
            actionChallenge2: 'Documentations possibles',
            pictureChallenge: 'assets/lister.gif'),
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
    //       child: Text("Faire une liste de course",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Créer une mission Normal.", style: bodyStyle),
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
    //         "Sélectionner votre mission pour rentrer les différents articles avec leur prix que vous allez acheter.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Créer un élément de type 'achat' pour chaque articles que vous souhaitez rentrer.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text("Ci joint le lien pour créer une tâche ou un commentaire",
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
    //         "Un compteur apparait avec les informations suivantes: achats et prévisions.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Les chiffres de vos prévisions d'achat ainsi que l'addition total en live de vos achat valider apparaisse en haut de votre écran.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Text(
    //         "Les prévisions représentes l'addition du prix tous les articles crées et les achats sont le total de ceux que vous avez validé.",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Image(
    //       width: 200,
    //       image: AssetImage('assets/listeDeCourse.gif'),
    //     ),
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
    //       image: AssetImage('assets/listedecourse2.gif'),
    //     ),
    //     SizedBox(
    //       height: 19,
    //     ),
    //     Text(
    //         "Vous pouvez faire une sauvegarde de votre liste d'article pour réutilisez cette liste d'article le mois prochain",
    //         style: bodyStyle),
    //     SizedBox(
    //       height: 10,
    //     ),
    //   ],
    // );
  }
}
