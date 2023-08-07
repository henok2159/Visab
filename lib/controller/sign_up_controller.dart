import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/auth_controller.dart';

class SignUpController extends GetxController {
  Rx<bool> isFormValid = true.obs;
  Rx<bool> isUploading = false.obs;
  late TextEditingController nameController;

  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController pwController;
  late TextEditingController confirmPwController;
  late AuthenticationController _authenticationController;
  Rx<String> emptyFieldError = "".obs;
  Rx<String> passwordError = "".obs;
  Rx<String> confirmPwError = "".obs;
  Rx<String> nameFieldError = "".obs;
  Rx<String> phoneFieldError = "".obs;
  Rx<String> invalidEmailError = "".obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    pwController = TextEditingController();
    confirmPwController = TextEditingController();
    _authenticationController = Get.find<AuthenticationController>();


    super.onInit();
  }

  void attachTextListeners(){
    nameController.addListener(() {
      checkEmptyField(nameController.text.trim(), () {
        nameFieldError.value = "Name field can't be empty";
        isFormValid.value = false;
      }, () {
        nameFieldError.value = "";
      });
    });

    phoneController.addListener(() {
      checkEmptyField(phoneController.text.trim(), () {
        phoneFieldError.value = "Phone field can't be empty";
        isFormValid.value = false;
        //isValid = false;
      }, () {
        phoneFieldError.value = "";
      });
    });

    emailController.addListener(() {
      checkEmptyField(emailController.text.trim(), () {
        invalidEmailError.value = "Email field can't be empty";
        isFormValid.value = false;
        //isValid = false;
      }, () {
        invalidEmailError.value = "";
      });
    });

    pwController.addListener(() {
      checkEmptyField(pwController.text.trim(), () {
        passwordError.value = "Password field can't be empty";
        isFormValid.value = false;
        //isValid = false;
      }, () {
        passwordError.value = "";
      });
    });

    confirmPwController.addListener(() {
      checkEmptyField(pwController.text.trim(), () {
        confirmPwError.value = "Password confirmation field can't be empty";
        isFormValid.value = false;
        //isValid = false;
      }, () {
        confirmPwError.value = "";
      });
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clear();
  }

  void clear() {
    emailController.clear();
    nameController.clear();
    phoneController.clear();
    confirmPwController.clear();
    pwController.clear();
  }

  void createUser() async {
    isUploading.value = true;
    try {
      await _authenticationController.createUser(
        nameController.text.trim(),
        emailController.text.trim(),
        pwController.text.trim(),
        phoneController.text.trim(),
      );
      isUploading.value = false;

      Get.back();
    } catch (e) {}
  }

  void onSubmitPressed() async {
    if (validate()) {
      createUser();
    } else {
      attachTextListeners();
      Get.snackbar("Validation error", "forms are not valid");
    }
  }

  bool checkEmptyField(
      String value, VoidCallback onEmpty, VoidCallback onNotEmpty) {
    if (value.isEmpty) {
      onEmpty();
      return true;
    }
    onNotEmpty();
    return false;
  }

  void validateEmail(String value, VoidCallback onInvalid) {
    if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a"
            r"-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0"
            r"-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
            r"(?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      onInvalid();
    }
  }

  bool validate() {
    bool isValid = true;

    checkEmptyField(nameController.text.trim(), () {
      nameFieldError.value = "Name field can't be empty";
      isFormValid.value = false;
    }, () {
      nameFieldError.value = "";
    });

    checkEmptyField(phoneController.text.trim(), () {
      phoneFieldError.value = "Phone field can't be empty";
      isFormValid.value = false;
      //isValid = false;
    }, () {
      phoneFieldError.value = "";
    });

    checkEmptyField(emailController.text.trim(), () {
      invalidEmailError.value = "Email field can't be empty";
      isFormValid.value = false;
      //isValid = false;
    }, () {
      invalidEmailError.value = "";
    });

    checkEmptyField(pwController.text.trim(), () {
      passwordError.value = "Password field can't be empty";
      isFormValid.value = false;
      //isValid = false;
    }, () {
      passwordError.value = "";
    });

    checkEmptyField(pwController.text.trim(), () {
      confirmPwError.value = "Password confirmation field can't be empty";
      isFormValid.value = false;
      //isValid = false;
    }, () {
      confirmPwError.value = "";
    });

    validatePassword(() {
      isFormValid.value = false;
      isValid = false;
    });

    validateEmail(emailController.text.trim(), () {
      invalidEmailError.value = "Please, enter a valid email";
      isFormValid.value = false;
      isValid = false;
    });

    if (isValid == true) {
      isFormValid.value = true;
    }
    return isValid;
  }

  void validatePassword(VoidCallback onNotValid) {
    String password = pwController.text.trim();
    String confirmPassword = confirmPwController.text.trim();
    if (password.length < 6) {
      onNotValid();
      passwordError.value = "Password has to be greater than 6 character";
    } else {
      if (confirmPassword != password) {
        onNotValid();
        confirmPwError.value = "Password mismatch";
      }
    }
  }
}
