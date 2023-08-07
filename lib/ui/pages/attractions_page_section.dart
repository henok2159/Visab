
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/attractions_controller.dart';
import 'package:tourist_guide/controller/favorite_attractions_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as state;
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/widgets/bottom_loader.dart';
import 'package:tourist_guide/ui/widgets/item_depreciated.dart';
import 'package:tourist_guide/ui/widgets/item.dart';

class AttractionsPageSection extends StatelessWidget {
  AttractionsController _attractionsController;
  String tag;
  VoidCallback onError;
  AttractionsPageSection(this._attractionsController, this.tag, this.onError);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 24, left: 16),
          alignment: Alignment.centerLeft,
          child: Text("Attractions", style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
          ),
        ),
        SizedBox(height: 16,),
        Obx(() {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            child: makeWidgetBasedOnState(
                Get.find<AttractionsController>(tag: tag).attractionState.value,
                //_attractionsController.attractionState.value,
                _attractionsController.scrollController,MediaQuery
                .of(context)
                .size
                .height / 4),
          );
        }
        ),
      ],
    );
  }

  Widget makeWidgetBasedOnState(state.HomePageState s,
      ScrollController scrollController,double height) {
    FavoriteAttractionController favoriteAttractionController = Get.find<
        FavoriteAttractionController>();
    print(
        "=======================InsideMakeWidget in attraction page============\ncontroller hashcode : ${_attractionsController
            .hashCode}");
    if (s is state.OnError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Error while fetching attractions")),
          TextButton(onPressed: ()=>onError(), child: Text("TRY AGAIN"))
        ],
      );
    }
    else if (s is state.OnLoading) {
      return Center(child: CircularProgressIndicator(),);
    }
    else if (s is state.OnSuccess) {
      return ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: s.lists.length, //todo
        itemBuilder: (ctx, i) {
          if(s.lists.length >= 19 && i >= s.lists.length - 1){
            return Row(
              key: i == 0 ? ValueKey("first_attraction") : ValueKey(i),
              children: [ItemWidget(s.lists.elementAt(s.lists.length -1) as Item,
                height: height,
                isAttraction: true
                ,
                width: 200,
                addToFavoriteCallback: favoriteAttractionController.addToFavorites,
                removeFromFavoriteCallback: favoriteAttractionController
                    .removeFromFavorites,
              ),
                BottomLoader(),
              ],
            );
          }
          Item item = s.lists.elementAt(i) as Item;
          return ItemWidget(item,
            height: height,
            width: 200,
            isAttraction: true
            ,
            addToFavoriteCallback: favoriteAttractionController.addToFavorites,
            removeFromFavoriteCallback: favoriteAttractionController
                .removeFromFavorites,
          );
        },
      );
    } else {
      return  Center(child: CircularProgressIndicator(),);
    }
  }

}