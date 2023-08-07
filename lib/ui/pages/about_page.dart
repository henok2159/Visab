import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:tourist_guide/controller/detail_page_state.dart';
import 'package:tourist_guide/controller/item_detail_controller.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/ui/widgets/location_widget.dart';
import 'package:tourist_guide/ui/widgets/name_with_rating.dart';
import 'package:tourist_guide/utils/other_app_launcher.dart';

//todo
class AboutPage extends GetView<ItemDetailController> {
  bool isAttraction;

  AboutPage(this.isAttraction);

  @override
  Widget build(BuildContext context) {
    return GetX<ItemDetailController>(builder: (controller) {
      return makeWidgetBasedOnState(controller.state.value, context);
    });
  }

  makeWidgetBasedOnState(DetailPageState s, BuildContext context) {
    if (s is OnError) {
      return Center(child: Text("Error while fetching data."));
    } else if (s is OnLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (s is OnSuccess) {
      return func(s.itemDetail as ItemDetail, context);
    }
  }

  Widget func(ItemDetail detail, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: ListView(
        children: <Widget>[
          NameWithRatingWidget(
            name: detail.name,
            rating: detail.rating,
            nameColor: Colors.black,
            isAttraction: isAttraction,
          ),
          SizedBox(
            height: 10,
          ),
          Text( isAttraction ? "${detail.name} is a tourist attraction site located in ${detail.formatted_address}":
            "${detail.name} offer accommodation services with different kinds of room types with panoramic view, restaurants that serve delicious meals.",
            style: TextStyle(color: Colors.grey.shade600),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Location",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                  onTap: ()=> MapsLauncher.launchCoordinates(detail.geometry.location.lat, detail.geometry.location.long),
                  child: LocationWidget(detail.geometry.location)),
            ],
          ),
          InkWell(
            onTap: ()=> MapsLauncher.launchCoordinates(detail.geometry.location.lat, detail.geometry.location.long),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on_outlined,
                        color: Theme.of(context).primaryColor),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        detail.formatted_address,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          InkWell(
            onTap: () =>  OtherAppLauncherService.launchCaller(detail.international_phone_number),
            child: Column(

              children: [
                SizedBox(height: 10),
                Row(
                children: <Widget>[
                  Icon(Icons.call, color: Theme.of(context).primaryColor),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    detail.international_phone_number,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
                SizedBox(height: 10),]
            ),
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }


}
