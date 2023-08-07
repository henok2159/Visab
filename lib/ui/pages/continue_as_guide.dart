import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/login_state.dart';
import 'package:tourist_guide/controller/tour_guide_auth_controller.dart';
import 'package:tourist_guide/ui/widgets/custom_input_filed.dart';

class ContinueAsGuest extends GetView<GuideAuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX<GuideAuthController>(
      init: Get.put(GuideAuthController("")),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomInputField(
                label: "Enter a verficatioin code",
                controller:
                controller.verificationCodeController,
                errorMsg: controller.emptyFieldError.value,
                hint:
                "",
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: buildSubmissionButton(context, () {controller.onContinuePressed();}, "Continue", controller.state.value)
              )
            ],
          ),
        );
      }
    );
  }
}



Widget buildSubmissionButton(BuildContext context, VoidCallback onPressed,
    String buttonText, LoginState submissionState) {
  return Container(
    padding: EdgeInsets.only(top: 3, left: 3),
    child: MaterialButton(
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