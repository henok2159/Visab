import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Terms and Conditions")),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text( "Conditions of use"
                  ,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                    child: Text("By using this application, you certify that you have read and reviewed this Agreement and that you agree to comply with its terms. The VISAB developer team only grants use and access of this app to those who have accepted its terms.")
                ),
                Text(
                  "Privacy policy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                  child: Wrap(
                    children: [
                      Text("Before you continue using our application, we advise you to read our privacy policy regarding our user data collection. It will help you better understand our practices."),
                      Text("here is the link", style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),),
                    ],
                  ),
                ),
                Text(
                  "Intellectual property",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                      child: Text("You agree that all materials, products, and services provided on this app are the property of the VISAB developer team and its affiliates. You also agree that you will not reproduce or redistribute the developers’ intellectual property in any way, including electronic, digital, or new trademark registrations."),
                ),
                Text(
                  "User accounts",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                      child: Text("As a user of this app, you may be asked to register with us and provide private information. You are responsible for ensuring the accuracy of this information, and you are responsible for maintaining the safety and security of your identifying information. You are also responsible for all activities that occur under your account or password."+
                          "If you think there are any possible issues regarding the security of your account on the app, inform us immediately so we may address them accordingly."+
                          "We reserve all rights to terminate accounts, edit or remove content and cancel orders at our sole discretion.")
                      ),
                Text(
                  "Indemnification",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                    child: Text("You agree to indemnify the VISAB developer team and its affiliates and hold the developer team harmless against legal claims and demands that may arise from your use or misuse of our services. We reserve the right to select our own legal counsel. ")         ),
                Text(
                  "Limitation on liability",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                    child: Text("The VISAB developer team is not liable for any damage that may occur to you as a result of your misuse of our application."+
    "The VISAB developer team reserves the right to edit, modify, and change this Agreement at any time. We shall let our users know of these changes through electronic mail. This Agreement is an understanding between the VISAB developer team and the user, and this supersedes and replaces all prior agreements regarding the use of this application."))

              ],
            ),
          ),
        ));
  }
}
