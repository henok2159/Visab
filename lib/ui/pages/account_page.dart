
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/auth_controller.dart';
import 'package:tourist_guide/models/models.dart';
import 'package:tourist_guide/ui/pages/signup.dart';
import 'package:tourist_guide/utils/user_util.dart';
import 'package:transparent_image/transparent_image.dart';

import 'edit_profile_bottom_sheet.dart';

class AccountPage extends GetView<AuthenticationController> {


  AccountPage();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>buildUserDetail(context,controller.user.value));
  }

  Widget buildUserDetail(BuildContext context, User user) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: new Stack(
          children: <Widget>[
            new Align(
              alignment: Alignment.center,
              child: new Padding(
                padding: new EdgeInsets.only(top: _height / 15),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_height/10),
                        child: FadeInImage.memoryNetwork(
                            width: _height/5,
                            height: _height/5,
                            fit: BoxFit.fill,
                            placeholder: kTransparentImage,
                            image:user.imageUrl
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: _height / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal : 16.0),
                      child: new Text(
                        user.name,
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 16,
              child: Container(
                padding: EdgeInsets.all(16),
                child: InkWell(
                  onTap: () => Get.to(()=>EditProfileBottomSheet(controller.user.value)), /*Get.bottomSheet(
                            EditProfileBottomSheet(controller.user.value),
                            backgroundColor: Colors.white),*/
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Theme.of(context).primaryColor),
                      SizedBox(width: 8,),
                      Text(
                          "Edit Profile",
                          key: ValueKey("edit_profile"),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: _height / 2.5),
              child: new Container(
                color: Colors.white,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(
                  top: _height / 2.6,
                  left: _width / 20,
                  right: _width / 20),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(top: _height / 25),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Languages",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text(UserUtil.formatLanguagesList(user.langs)),
                        ),
                        SizedBox(height: 24,),
                        Text(
                          "Contacts",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Column(children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.email,
                                    color:
                                    Theme.of(context).primaryColor),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  user.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.call,
                                    color:
                                    Theme.of(context).primaryColor),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  user.phone,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                        ]),

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

