import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("About us")),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Our Mission",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                  child: Text("Build a good, long lasting and interesting connection between tourists and Ethiopia."),
                ),
                Text(
                  "About the Visab Applicaiton",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 32.0),
                  child: Text("Things VISAB Application provides us:\n\tWhen we enter into homepage we will have a brief access of attraction sites, popular destination, hotel nearby, tour guide and favourite feature which adds our favourite services and service providers in order to get them easily."),
                ),
              ],
            ),
          ),
        ));
  }
}
