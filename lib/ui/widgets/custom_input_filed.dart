

import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {

  String label;
  bool obscureText;
  TextEditingController controller;
  String errorMsg;
  bool isPhone;
  bool isNumber;
  String hint;
  String text;
  bool isMultiLine;
  Key? key;
  CustomInputField({this.label = '',this.hint = "", this.text = "", this.obscureText = false,required this.controller,required this.errorMsg, this.isPhone = false, this.isNumber = false, this.isMultiLine = false,this.key});
  @override
  Widget build(BuildContext context) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20,),
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          key: ValueKey(this.label),
          controller: controller,
          obscureText: obscureText,
          minLines: isMultiLine ? 5 : 1,
          maxLines: isMultiLine ? null : 1,
          keyboardType: isPhone == true ? TextInputType.phone :( isNumber == true ? TextInputType.number: (isMultiLine ? TextInputType.multiline : null)),
          decoration: InputDecoration(
            hintText: this.hint,
            errorText: errorMsg =="" ? null : errorMsg,
            errorStyle: TextStyle(color: Colors.red),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: (Colors.grey[400])!)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: (Colors.grey[400])!)
            ),
          ),
        ),
      ],
    );
  }

  static  bool checkEmptyField(
      String value, VoidCallback onEmpty, VoidCallback onNotEmpty) {
    if (value.isEmpty) {
      onEmpty();
      return true;
    }
    onNotEmpty();
    return false;
  }
}
