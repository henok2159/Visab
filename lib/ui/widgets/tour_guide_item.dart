
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TourGuideWidget extends StatelessWidget {
  
  final String imageUrl;
  final String tourGuideName;
  TourGuideWidget(this.tourGuideName, this.imageUrl);
  
  @override
  Widget build(BuildContext context) {
    return  new InkWell(
        onTap: () {
          Get.snackbar("Message", "Got to details page");
        },
        child: new Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.network(
              this.imageUrl
              ,
                fit: BoxFit.fill,
                //height:100.0,
              ),
              new Expanded(
                  child: new Center(
                      child: new Column(
                        children: <Widget>[
                          new SizedBox(height: 8.0),
                          new Text(
                           this.tourGuideName
                            ,
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      )))
            ],
          ),
          elevation: 2.0,
          margin: EdgeInsets.all(5.0),
        ));
  }
}
