import 'package:url_launcher/url_launcher.dart';

class OtherAppLauncherService{

  static launchCaller(String phone) async {
    var url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static sendMail(String email) async {
    var uri = 'mailto:$email?subject=Finding a tour guide for my trip';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

}