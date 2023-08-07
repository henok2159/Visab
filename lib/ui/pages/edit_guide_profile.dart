import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/edit_guide_profile_controller.dart';
import 'package:tourist_guide/controller/edit_profile_controller.dart';
import 'package:tourist_guide/models/models.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/ui/widgets/custom_input_filed.dart';


class EditGuideProfile extends GetView<EditGuideProfileController> {

  TourGuide guide;

  EditGuideProfile(this.guide);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return  Scaffold(
        appBar: AppBar(title: Text("Edit Profile"),
          actions: [TextButton(onPressed: ()=>controller.onSavePressed(), child: Text("SAVE", style: TextStyle(color: Colors.white),))],
        ),
        body: GetX<EditGuideProfileController>(
            init: Get.put(EditGuideProfileController()),
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: new Stack(
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.center,
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(vertical: _height / 25),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                children: [
                                  controller.pickedFile.value.path != "path" ?
                                  new CircleAvatar(
                                    backgroundImage:
                                    new FileImage(File(controller.pickedFile.value.path)),
                                    radius: _height / 10,
                                  ) : new CircleAvatar(
                                    backgroundImage:
                                    new NetworkImage(guide.imageUrl),
                                    radius: _height / 10,
                                  ),
                                  Positioned(
                                      bottom: 8,
                                      right: 4,
                                      child: Container(
                                          color: Colors.white,
                                          child: GestureDetector(
                                              onTap: ()=>controller.pickImage(),
                                              child: Icon(Icons.camera_alt_rounded, size: 32,color: Theme.of(context).primaryColor,))))
                                ],
                              ),
                              new SizedBox(
                                height: _height / 30,
                              ),
                              new Text( controller.userName.value,
                                style: new TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(
                            top: _height / 3.4,
                            left: _width / 25,
                            right: _width / 25),
                        child: new Padding(
                          padding: new EdgeInsets.only(top: _height / 20),
                          child: Column(children: [
                            CustomInputField(label: "User name", controller: controller.nameController, errorMsg: controller.emptyFieldError.value,),
                            CustomInputField(label: "Phone", controller: controller.phoneController, errorMsg: controller.emptyFieldError.value,),
                            CustomInputField(label: "City", controller: controller.cityController, errorMsg: controller.emptyFieldError.value,)
                            ,CustomInputField(hint: "Enter each language separated by comma",label: "Languages", controller : controller.languagesController,errorMsg: controller.emptyFieldError.value,),
                            CustomInputField(label: "Description", controller: controller.descriptionController, errorMsg: controller.emptyFieldError.value,isMultiLine: true,),

                          ],),

                        ),
                      ),
                      Center(child :
                      controller.isUploading.value ? SimpleDialog(
                        children: [Center(
                          child: Container(
                            child:  Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 8,),
                                Text("Please wait...")
                              ],
                            ),),)
                        ],) : Text(""),
                      ),
                    ],
                  ),
                ),
              );
            }
        ));
  }
}