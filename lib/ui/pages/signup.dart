import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/sign_up_controller.dart';
import 'package:tourist_guide/ui/pages/login.dart';
import 'package:tourist_guide/ui/widgets/custom_input_filed.dart';

class SignupPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: new Text(
            "Sign up",
            style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: GetX<SignUpController>(
              init: Get.put(SignUpController()),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Create an account...",
                            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                          ),
                          Column(
                            children: <Widget>[
                              CustomInputField(
                                  label: "Name",
                                  controller: controller.nameController,
                                  errorMsg: controller.nameFieldError.value),
                              CustomInputField(
                                label: "Email",
                                controller: controller.emailController,
                                errorMsg: controller.invalidEmailError.value,
                              ),
                              CustomInputField(
                                label: "Phone",
                                controller: controller.phoneController,
                                errorMsg: controller.phoneFieldError.value,
                                isPhone: true,
                              ),
                              CustomInputField(
                                label: "Password",
                                obscureText: true,
                                controller: controller.pwController,
                                errorMsg: controller.passwordError.value,
                              ),
                              CustomInputField(
                                label: "Confirm Password",
                                obscureText: true,
                                controller: controller.confirmPwController,
                                errorMsg: controller.confirmPwError.value,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              color: Colors.white,
                              child: Align(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(bottom: 3, top: 3, left: 3),
                                  child: MaterialButton(
                                    minWidth: double.infinity,
                                    height: 60,
                                    onPressed: () {
                                      controller.onSubmitPressed();
                                    },
                                    color: Theme.of(context).primaryColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)),
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Already have an account?"),
                                TextButton(
                                  onPressed: () => Get.offAll(() => LoginPage()),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                      Center(
                        child: controller.isUploading.value
                            ? SimpleDialog(
                          children: [
                            Center(
                              child: Container(
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Please wait...")
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                            : Text(""),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
