
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/data/firebase_auth.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/data/shared_preference.dart';
import 'package:tourist_guide/models/models.dart' as model;
import 'package:tourist_guide/ui/pages/dashboard_page.dart';
import 'package:tourist_guide/ui/pages/home_page.dart';
import 'package:tourist_guide/ui/widgets/custom_input_filed.dart';

import 'login_state.dart';

class AuthenticationController extends GetxController {

  var state = LoginState.initial.obs;
  Rx<bool> isFormValid = false.obs;
  FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  Rx<model.User> user = Rx<model.User>(model.User.initial());
  Rx<String> passwordFieldError = "".obs;
  Rx<String> invalidEmailError = "".obs;
  static Rx<String> _userId = "".obs;
  String email = "";
  TextEditingController pwController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // if _userId = "" ,
  late Repository _repository;

  static String get userId => _userId.value;

  @override
onInit() async{
    _repository = Repository.instance();
    state.value = LoginState.initial;
    super.onInit();
    _userId.bindStream(_firebaseAuthService.firebaseAuth.authStateChanges().map((event) {
      String ret = "";
      if(event != null){
        print("AuthStateChanges ()");
        print("Event : event.id ${event.uid}");
        _userId.value = event.uid;
        _repository.getUser(_userId.value).then((value) => user.value = value);
        ret = event.uid;
      }
     return  ret;
    }));


    //todo if _userId isnot "" fetch current User from users collection
}

Future<void> createUser(String name, String email, String password,String phone, {List<String> langs = const [""]}) async {
  try{
    user.value = await _firebaseAuthService.createUser(name, email, password, phone, langs);
  } catch (e) {

  }
}

void login() async {
  print("login called....");
  try {
      model.User user = await _firebaseAuthService.login(emailController.text.trim(), pwController.text.trim());
      SharedPreferenceUtil.changeUserType(SharedPreferenceUtil.touristType);
      this.user.value = user;
      print("logged user id : ${user.userId}");
      email = user.email;
      state.value = LoginState.loaded;
      Get.offAll(()=>DashboardPage());
  } catch (e) {
    state.value = LoginState.error;
    Get.snackbar("Error", "Error occurred while logging in");
  }
}

void signOut() async {
  try {
    bool result = await _firebaseAuthService.signOut();
    if(result){
      user.value  = model.User.initial();
    }
  } catch (e) {
    Get.snackbar("Error", "Error occurred while logging in");
  }
}

void resetPassword(String email){
  try {
    _firebaseAuthService.resetPassword(email);
  }catch(e){

  }

}
  void onLoginPressed() async{
    if (validate()) {
      state.value = LoginState.loading;
      login();
    }else{
      attachTextListener();
      Get.snackbar("Validation error", "forms are not valid");
    }

  }

  void attachTextListener(){
    pwController.addListener(() {
      CustomInputField.checkEmptyField(pwController.text.trim(), () {
        passwordFieldError.value = "Password field can't be empty";
        isFormValid.value = false;
        //isValid = false;
      }, () {
        passwordFieldError.value = "";
      });
    });
    emailController.addListener(() {
      CustomInputField.checkEmptyField(emailController.text.trim(), () {
        invalidEmailError.value = "Please, enter a valid email";
        isFormValid.value = false;
        //isValid = false;
      }, () {
        invalidEmailError.value = "";
      });
    });
  }
  bool isEmailValid(String value){
    if(!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a"
        r"-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0"
        r"-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
        r"(?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool checkEmptyField(String value){
    if(value == null || value.isEmpty){
      return true;
    }
    return false;
  }
  bool validate(){
    bool isValid = true;
    passwordFieldError.value = "";
    invalidEmailError.value = "";
    if(checkEmptyField(pwController.text.trim())){
      print("invalidity while checking for empty fields");
      isFormValid.value = false;
      isValid = false;
      passwordFieldError.value = "Password field can't be empty";
    }
    if(checkEmptyField(emailController.text.trim()) || !isEmailValid(emailController.text.trim())){
      print("invalidity while checking for empty fields email part ");
      invalidEmailError.value = "Please, enter a valid email";
      isFormValid.value = false;
      isValid = false;

    }
    if(isValid == true){
      isFormValid.value = true;
    }
    return isValid;
  }

}

//User get user => _firebaseUser.value;







