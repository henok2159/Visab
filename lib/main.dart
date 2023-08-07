import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/data/shared_preference.dart';
import 'package:tourist_guide/ui/pages/guide_home.dart';
import 'package:tourist_guide/ui/pages/login.dart';
import 'package:tourist_guide/ui/pages/new_dash_board.dart';
import 'file:///C:/Programming/NewCourses/FlutterProjects/tourist_guide/lib/ui/splash_screen.dart';

import 'controller/bindings/auth_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set portrait orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  //SharedPreferenceUtil.saveUserId("338a698b-82a1-4836-8e1f-c89b93504c72");
  //SharedPreferenceUtil.changeUserType("");
  //SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.initial);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        initialBinding: AuthBinding(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: "Visab") //MyHomePage(title: 'Visab'),
        );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    //return DashboardPage();
    return FutureBuilder<String>(
        future: SharedPreferenceUtil.getUserSessionStatus(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return SplashScreen(false);
            case ConnectionState.done:
              return decidePageBasedOnUserStatus(snapshot);
            default:
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
          }
        });
  }
}

Widget decidePageBasedOnUserStatus(AsyncSnapshot<String> snapshot) {
  /*Possible user statuses : initial - for the first time
        logged_in and logged_out
  * */
  print("decidePageBasedOnUserStatus");
  if (snapshot.hasData) {
    String currentStatus = snapshot.data!;
    print("Current user status : $currentStatus}");
    if (currentStatus == SharedPreferenceUtil.loggedIn) {
      return FutureBuilder<String>(
          future: SharedPreferenceUtil.getUserType(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return SplashScreen(false);
              case ConnectionState.done:
                print("user type ");
                return decidePageBasedOnUserType(snapshot);
              default:
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
            }
          });
    } else if(currentStatus == SharedPreferenceUtil.initial){
      return SplashScreen(true); // beta's code here
    }
    else{
      // for logged_out case
      return LoginPage();
    }
  } else {
    return Scaffold(
        body: Center(
          child: Text("Error"),
        ));
  }
}

Future<String> getUserId() async {
  return await SharedPreferenceUtil.getUserId();
}

Widget decidePageBasedOnUserType(AsyncSnapshot<String> snapshot) {
  if (snapshot.hasData) {
    /*Possible user status : tourist and guide */
    String userType = snapshot.data!;
    print("userType : $userType");

    if (userType == SharedPreferenceUtil.guideType){
      return FutureBuilder<String>(
            future: SharedPreferenceUtil.getUserId(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return SplashScreen(false);
                case ConnectionState.done:
                  print("userid : ");
                  return GuideHome(tourGuideId: snapshot.data ?? "",);
                default:
                  return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ));
              }
            });
    }
    else if (userType == SharedPreferenceUtil.touristType){
      return NewDashboardPage();//DashboardPage();
    }else{
      return LoginPage();
    }

  }
  else{
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}