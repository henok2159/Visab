import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/detail_page_state.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/models/review.dart';
import 'package:tourist_guide/ui/widgets/review_item.dart';


//todo
class ReviewsPage extends GetView<ItemDetailController> {

  @override
  Widget build(BuildContext context) {
      return GetX<ItemDetailController>(
          builder: (controller) {
            return makeWidgetBasedOnState(controller.state.value);
          }
      );
  }

  makeWidgetBasedOnState(DetailPageState s) {
    if (s is OnError) {
      return Center(child: Text("Error while fetching data."));
    }
    else if (s is OnLoading) {
      return Center(child: CircularProgressIndicator(),);
    }
    else if (s is OnSuccess) {
      Review review = (s.itemDetail as ItemDetail).reviews[0];
      return review.author_name == "" && review.relative_time_description == "" ?
          Center(child: Text("No reviews for this item."),)
          :
      ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: (s.itemDetail as ItemDetail).reviews.length, //todo
        itemBuilder: (ctx, i) {
          Review review = (s.itemDetail as ItemDetail).reviews.elementAt(i);
          return ReviewItem(
              review.author_name, review.text, review.profile_photo_url,
              review.rating, review.relative_time_description);
        }, separatorBuilder: (BuildContext context, int index) {return Divider(thickness: 2,);},
      );
    }
  }
}