import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tourist_guide/ui/pages/getting_started_screen.dart';


class SplashScreen extends StatefulWidget {
  bool isFirstTime;
  SplashScreen(this.isFirstTime);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

      Timer(Duration(seconds: 3), () {
        if (widget.isFirstTime) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GettingStartedScreen(),
              )
          );
        }else{

        }
      } );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(

          children: <Widget>[
            Container(
              //width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/splash/logo2.jpg'),
                  )

              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 16),

                        )
                      ],
                    ),
                  ),
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16,bottom: 32),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
