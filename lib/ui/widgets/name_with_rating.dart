


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/ui/pages/guides_page.dart';

class NameWithRatingWidget extends StatelessWidget {
  String name;
  double rating;
  Color nameColor;
  bool isAttraction;
  NameWithRatingWidget({ required this.name,required this.rating,required this.nameColor,required this.isAttraction} );

  @override
  Widget build(BuildContext context) {
    return isAttraction ? buildForAttraction(context) : buildForHotel();
  }

  Widget buildForAttraction(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
          width: MediaQuery.of(context).size.width/1.75,
          child: buildForHotel()),
      Container(
        padding: EdgeInsets.only(top: 3, left: 3),
        child: MaterialButton(
          //minWidth: 120,
          height: 40,
          onPressed: () {
                Get.to(() => GuidesPage());
            },
          color: Theme.of(context).primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            "Find a Guide",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      )
    ],);
  }

  Widget buildForHotel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right : 16.0),
          child: Text(
              this.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: nameColor)),
        ),
        RatingBar.builder(
          ignoreGestures: true,
          initialRating: this.rating,
          minRating: 0.5,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 16,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) =>
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
          onRatingUpdate: (double value) {},
        ),
        SizedBox(height: 8,)
      ],
    );
  }
}