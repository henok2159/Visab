import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/tour_guide_auth_controller.dart';
import 'package:tourist_guide/models/tour_guide.dart';
import 'package:tourist_guide/ui/pages/login.dart';
import 'file:///C:/Programming/NewCourses/FlutterProjects/tourist_guide/lib/ui/splash_screen.dart';
import 'package:tourist_guide/utils/constants.dart';
import 'package:tourist_guide/utils/other_app_launcher.dart';

import 'edit_guide_profile.dart';

class GuideHome extends GetView<GuideAuthController> {
  late GuideAuthController controller;

  GuideHome({String tourGuideId = ""}) {
    controller = Get.put(GuideAuthController(tourGuideId));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text("Home", style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: FutureBuilder<TourGuide?>(
            future: controller.getGuide(),
            builder: (BuildContext context,
                AsyncSnapshot<TourGuide?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                //return SplashScreen(false);
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return buildGuideDetail(context, snapshot.data!);
                  } else {
                    return SplashScreen(false);
                  }
                default:
                  return SplashScreen(false);
              }
            })
      //buildGuideDetail(context, controller.guide)
    );
  }

  Widget buildGuideDetail(BuildContext context, TourGuide tourGuide) {
    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      child: new Stack(
        children: <Widget>[

          new Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: EdgeInsets.only(bottom: 16),
              child: SingleChildScrollView(
                child: new Stack(
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.center,
                      child: new Padding(
                        padding: new EdgeInsets.only(top: _height / 15),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                              new NetworkImage(tourGuide.imageUrl),
                              radius: _height / 10,
                            ),
                            new SizedBox(
                              height: _height / 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  new Text(
                                    tourGuide.name,
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 16,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: _height / 2.5),
                      child: new Container(
                        color: Colors.white,
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(
                          top: _height / 2.6,
                          left: _width / 20,
                          right: _width / 20),
                      child: new Column(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.only(top: _height / 25),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Description",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, bottom: 32.0),
                                  child: Text(tourGuide.descritpion),
                                ),
                                Text(
                                  "Contacts",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                InkWell(
                                  onTap: () =>
                                  {
                                    OtherAppLauncherService.sendMail(
                                        tourGuide.email)
                                  },
                                  child: Column(children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.email,
                                            color:
                                            Theme
                                                .of(context)
                                                .primaryColor),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          tourGuide.email,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ]),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                InkWell(
                                  onTap: () =>
                                  {
                                    OtherAppLauncherService.launchCaller(
                                        tourGuide.phone)
                                  },
                                  child: Column(children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.call,
                                            color:
                                            Theme
                                                .of(context)
                                                .primaryColor),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          tourGuide.phone,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ]),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Column(children: [
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.location_city,
                                          color: Theme
                                              .of(context)
                                              .primaryColor),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        tourGuide.city,
                                        style:
                                        Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.to(() => EditGuideProfile(tourGuide)),
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.aboutUs) {
      Get.snackbar("Test", "Option menu test for Settings");
    }
    else if (choice == Constants.signOut) {
      controller.onSignOUt();
      Get.to(() => LoginPage());
    }
  }

}