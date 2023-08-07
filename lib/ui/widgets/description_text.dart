import 'package:flutter/material.dart';

class CustomExpandableTextWidget extends StatefulWidget {
  String text;
  CustomExpandableTextWidget(this.text);

  _CustomExpandableTextWidgetState createState() => _CustomExpandableTextWidgetState();
}

class _CustomExpandableTextWidgetState extends State<CustomExpandableTextWidget> {

  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.text,
                maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start),
            InkWell(
              onTap: (){
                setState(() {
                descTextShowFlag = !descTextShowFlag;
              }); },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  descTextShowFlag ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More",style: TextStyle(color: Colors.blue))
                ],
              ),
            ),
          ],
        ),
    );
  }
}