

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TakePictureWidget extends StatelessWidget {
  Rx<String> imageSelectionStatus;
  VoidCallback callback;
  TakePictureWidget(this.imageSelectionStatus, this.callback);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color:
            imageSelectionStatus.value == "Select a picture"?(Colors.red[400])!:(Colors.grey[400])!),
        ),
        child:
            Center(child:  Obx(()=>
              Text(imageSelectionStatus.value)
            )),),
        IconButton(icon: Icon(Icons.add_a_photo, color: Theme.of(context).primaryColor,), onPressed:
        callback)]
    );
  }

}
