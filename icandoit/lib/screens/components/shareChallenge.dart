import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareChallenge extends StatelessWidget {
  const ShareChallenge({Key key}) : super(key: key);

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
          child: Text("partager et uploader ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Vous pouvez soit récupéré un challenge qu'un ami ou votre chef vous a envoyé ou partager un procès ou des missions que vous avez confectionnez au petit oignons.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "pour récupérer un challenge , vous devez au préalable récupérer le challenge sur une plateforme de partage que votre interlocuteur vous aurais envoyez au préalable tel que watsapp ou par email , etc.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text(
            "Ensuite vous cliquez sur le bouton en haut a droite des challenges qui va vous redirigez sur les dossiers de partage votre téléphone.ensuite il suffit de sélectionner le challenge que vous voulez récupérer.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 19,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/upload.gif'),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
            "Pour le partage il faut d'abord sélection le challenge que vous souhaitez partager et cliquez sur le bouton partage en haut a droite , cela vous redirigera vers une plateforme de partage soit watsapp, drive ou encore votre boite email, etc.",
            style: bodyStyle),
        SizedBox(
          height: 10,
        ),
        Text("Ci joint le lien pour la procédure pour uploader un challenge",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        IconButton(
            onPressed: () {
              _launchMapsUrl(
                  "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513841-uploader-un-challenge");
            },
            icon: Icon(
              Icons.link,
              size: 40,
              color: Colors.blue,
            )),
        SizedBox(
          height: 19,
        ),
        Image(
          width: 200,
          image: AssetImage('assets/download.gif'),
        ),
        Text("Ci joint le lien pour la procédure pour downloader un challenge",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        IconButton(
            onPressed: () {
              _launchMapsUrl(
                  "https://newaccount1626188315630.freshdesk.com/support/solutions/articles/69000513740-partager-un-challenge");
            },
            icon: Icon(
              Icons.link,
              size: 40,
              color: Colors.blue,
            )),
      ],
    );
  }
}
