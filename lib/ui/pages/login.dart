import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/auth_controller.dart';
import 'package:tourist_guide/controller/login_state.dart';
import 'package:tourist_guide/controller/reset_password_controller.dart';
import 'package:tourist_guide/controller/tour_guide_auth_controller.dart';
import 'package:tourist_guide/ui/pages/continue_as_guide.dart';
import 'package:tourist_guide/ui/pages/reset_password.dart';
import 'package:tourist_guide/ui/pages/signup.dart';
import 'package:tourist_guide/ui/widgets/custom_input_filed.dart';

class LoginPage extends GetWidget<AuthenticationController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: new Text(
          "Login",
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Login to your account...",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: GetX<AuthenticationController>(
                  builder: (controller) {
                    return Column(
                      children: <Widget>[
                        CustomInputField(
                          label: "Email",
                          controller: controller.emailController,
                          errorMsg: controller.invalidEmailError.value,
                        ),
                        CustomInputField(
                          label: "Password",
                          obscureText: true,
                          controller: controller.pwController,
                          errorMsg: controller.passwordFieldError.value,
                        ),
                      ],
                    );
                  },
                ),
              ),
              GetX<AuthenticationController>(builder: (controller) {
                /* if(controller.isFormValid.value && controller.state.value == LoginState.loaded){
                      Get.to(() => AdminHome());
                    }*/
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        color: Colors.white,
                        child: Align(
                          child: buildSubmissionButton(context, () { controller.onLoginPressed();}, "Login", controller.state.value),
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextButton(
                      onPressed: () => Get.bottomSheet(
                          ResetPassword(),
                          backgroundColor: Colors.white),
                      //Get.to(() => ResetPassword()
                      child: Text(
                        controller.state.value == LoginState.loading
                            ? "Validating user data..."
                            : "Forget password?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () => Get.to(() => SignupPage()),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ]),
                    TextButton(
                      onPressed: () => Get.bottomSheet(
                           ContinueAsGuest(),
                          backgroundColor: Colors.white),
                      //Get.to(() => ResetPassword()
                      child: Text(
                        "Continue as a tour guide",
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /**/

  /**/
  Widget buildBottomSheet(BuildContext context, CustomInputField inputField,
      VoidCallback onPressed, String buttonText, LoginState state) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          inputField,
          SizedBox(
            height: 20,
          ),
          Center(
            child: buildSubmissionButton(context, () {onPressed();}, buttonText, state)
          )
        ],
      ),
    );
  }

  Widget buildSubmissionButton(BuildContext context, VoidCallback onPressed,
      String buttonText, LoginState submissionState) {
    return Container(
      padding: EdgeInsets.only(top: 3, left: 3),
      child: MaterialButton(
        key:ValueKey(buttonText),
        minWidth: 120,
        height: 40,
        onPressed: () {
          onPressed();
        },
        color: Theme.of(context).primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: submissionState == LoginState.loading
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(
                buttonText,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
      ),
    );
  }
}

/* Container(
                            padding:
                                EdgeInsets.only(bottom: 3, top: 3, left: 3),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {

                              },
                              color: Theme.of(context).primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child:
                                  controller.state.value == LoginState.loading
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        )
                                      : Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                            ),
                          )*/
