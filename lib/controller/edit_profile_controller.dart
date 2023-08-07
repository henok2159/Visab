
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_guide/controller/auth_controller.dart';
import 'package:tourist_guide/data/firebase_auth.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/ui/widgets/custom_input_filed.dart';
import 'package:tourist_guide/utils/user_util.dart';

class EditProfileController extends GetxController{

  Rx<bool> isFormValid = false.obs;
  Rx<bool> isUploading = false.obs;
  late TextEditingController nameController ;
  late TextEditingController languagesController;
  late TextEditingController phoneController;
  late AuthenticationController _authenticationController;
  late ImagePicker picker;
  var _pickedFile = PickedFile("path").obs;

  get pickedFile => _pickedFile;
  Rx<String> emptyFieldError = "".obs;
  Rx<String> invalidEmailError = "".obs;
  var imageSelectionText = "Select a picture".obs;
  late Repository _repository;
  late User currentUser;
  var userName = ''.obs;
  Rx<String> nameFieldError = "".obs;
  Rx<String> phoneFieldError = "".obs;


  @override
  void onInit() {
    currentUser = Get.find<AuthenticationController>().user.value;
    userName.value = currentUser.name;
    picker = ImagePicker();
    languagesController = TextEditingController(text: UserUtil.formatLanguagesList(currentUser.langs));
    nameController = TextEditingController(text : currentUser.name);
    nameController.addListener(() {
      print("AddListener called");
      userName.value = nameController.text.trim();});
    phoneController = TextEditingController(text : currentUser.phone);
    _authenticationController = Get.find<AuthenticationController>();

    nameController.addListener(() {
      CustomInputField.checkEmptyField(nameController.text.trim(), () {
        nameFieldError.value = "Name field can't be empty";
        isFormValid.value = false;
      }, () {
        nameFieldError.value = "";
      });
    });

    phoneController.addListener(() {
      CustomInputField.checkEmptyField(phoneController.text.trim(), () {
        phoneFieldError.value = "Phone field can't be empty";
        isFormValid.value = false;
        //isValid = false;
      }, () {
        phoneFieldError.value = "";
      });
    });

    _repository =Repository.instance();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clear();
  }

  void clear(){
    languagesController.clear();
    nameController.clear();
    phoneController.clear();
  }


  Future uploadImageToFirebase(File _imageFile, String fileName) async {
    return await _repository.uploadImageToFirebase(fileName, _imageFile);

  }
  void updateUser(String imageUrl) async{
    //User user = User(key,

    User user = User(currentUser.userId,nameController.text.trim(),
        currentUser.email,phoneController.text.trim(),
        languagesController.text.split(','),imageUrl);
    _authenticationController.user.value = user;
    try {
      await _repository.updateUser(user);
      //Future.delayed(Duration(milliseconds: 2000),()=>isUploading.value = false);
      isUploading.value = false;
      Get.back();
    }
    catch(e){
    }
  }
  void onSavePressed() async{
    if (validate()) {
      String url = currentUser.imageUrl;
      isUploading.value = true;
      if(_pickedFile.value.path != "path") {
        var splitted = _pickedFile.value.path.split('/');
        String fileName = splitted[splitted.length - 1];
            url = await uploadImageToFirebase(File(_pickedFile.value.path), fileName);
      }
      updateUser(url);
    }else{
      Get.snackbar("Validation error", "forms are not valid");
    }

  }

  void pickImage() async{
    _pickedFile.value = (await ImagePicker().getImage(
      source: ImageSource.gallery ,
    ))!;

  }
  bool validate() {
    bool isValid = true;

    CustomInputField.checkEmptyField(nameController.text.trim(), () {
      nameFieldError.value = "Name field can't be empty";
      isFormValid.value = false;
    }, () {
      nameFieldError.value = "";
    });

    CustomInputField.checkEmptyField(phoneController.text.trim(), () {
      phoneFieldError.value = "Phone field can't be empty";
      isFormValid.value = false;
      //isValid = false;
    }, () {
      phoneFieldError.value = "";
    });
    if (isValid == true) {
      isFormValid.value = true;
    }
    return isValid;
  }


}