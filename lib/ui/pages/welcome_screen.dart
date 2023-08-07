import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/utils/ui_constant.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 1), //2/6
                  Text(
                  "WELCOME TO THE MOST BEAUTIFUL COUNTRY IN THE WORLD "
                  ,
                   // "Did you know this about ETHIOPIA" ,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),

                  Text("ETHIOPIA is well known for her hospitality for her guests we wish this vacation is the best vacation of your "
                      "life to let you know a little bit about ETHIOPIA here is a quick Q&A this will give you some concept "
                      "about our country. ",
                  style: TextStyle(
                      color: Colors.black
                  ),
                  ),
                  Spacer(), // 1/6
                  InkWell(
                    onTap: () => Get.snackbar("Message", "Got to Quiz screen"),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Let's Start Quiz",
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
