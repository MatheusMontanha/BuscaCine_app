import 'package:url_launcher/url_launcher.dart';

class Usaveis {
  Usaveis();

  Future<void> abrirAppURL(
      String url, bool abrirApp, bool abrirNavegador) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: abrirApp,
        forceWebView: abrirNavegador,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Não foi possível encontrar a URL';
    }
  }
}
