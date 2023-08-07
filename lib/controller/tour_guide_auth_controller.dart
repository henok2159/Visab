
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_guide/controller/auth_controller.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/data/shared_preference.dart';
import 'package:tourist_guide/models/models.dart';
import 'package:tourist_guide/ui/pages/guide_home.dart';

import 'login_state.dart';

class GuideAuthController  extends GetxController {
  Rx<bool> isFormValid = false.obs;
  late TextEditingController verificationCodeController;
  late AuthenticationController authenticationController;
  late Repository _repsoitory;
  Rx<String> emptyFieldError = "".obs;
  var state = LoginState.initial.obs;
  late Rx<TourGuide?> guide;
  late ImagePicker picker;
  var pickedFile ;
  var isSelected = false.obs;


  String tourGuideId;
  GuideAuthController(this.tourGuideId);


  @override
  onInit() async{
    super.onInit();
    print("Oninit called");
    picker = ImagePicker();
    state.value = LoginState.initial;
    verificationCodeController  = TextEditingController();
    authenticationController = Get.find<AuthenticationController>();
    _repsoitory = Repository.instance();
    if(tourGuideId != ""){
      guide.value = await _repsoitory.getGuide(tourGuideId);
    }
  }


  Future<TourGuide?> getGuide() async{
    if(guide.value == null){
       guide.value = await _repsoitory.getGuide(tourGuideId);
    }
    return guide.value;
  }




  void onContinuePressed() async{

    try {
      if (validate()) {
        state.value = LoginState.loading;
        guide.value = await _repsoitory.getGuide(verificationCodeController.text.trim());
        state.value = LoginState.loaded;
        SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.loggedIn);
        SharedPreferenceUtil.changeUserType(SharedPreferenceUtil.guideType);
        Get.offAll(()=>GuideHome());
      } else {
        state.value = LoginState.error;
        Get.snackbar("Validation error", "forms are not valid");
      }
    }
    catch(e){
      state.value = LoginState.error;
      Get.snackbar("Error Message", "The code you provided isn't valid.");
    }

  }

  bool checkEmptyField(String value){
    if( value.isEmpty){
      return true;
    }
    return false;
  }

  bool validate(){
    bool isValid = true;
    if(checkEmptyField(verificationCodeController.text.trim())){
      emptyFieldError.value = "Please, enter a valid input";
      isFormValid.value = false;
      isValid = false;

    }
    if(isValid == true){
      isFormValid.value = true;
      emptyFieldError.value ="";
    }
    return isValid;
  }
  Future uploadImageToFirebase(File _imageFile, String fileName) async {
    return await _repsoitory.uploadImageToFirebase(fileName, _imageFile);

  }
  void pickImage() async{
    pickedFile = (await ImagePicker().getImage(
      source: ImageSource.gallery ,
    ));
    if(pickedFile != null){
      Get.snackbar("Message", "Image selected successfully.", snackPosition: SnackPosition.BOTTOM);
      isSelected.value = !isSelected.value;
      var splitted = pickedFile.path.split('/');
      String fileName = splitted[splitted.length - 1];
      uploadImageToFirebase(File(pickedFile.path), fileName);
    }else{
      Get.snackbar("Message", "Please, Pick image", snackPosition: SnackPosition.BOTTOM);
    }


  }

  void onSignOUt() async{
    SharedPreferenceUtil.changeUserSessionStatus(SharedPreferenceUtil.loggedOut);
    SharedPreferenceUtil.changeUserType("");

  }


}