import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorite_hotels_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as state;
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/widgets/bottom_loader.dart';
import 'package:tourist_guide/ui/widgets/item_depreciated.dart';
import 'package:tourist_guide/ui/widgets/item.dart';

class HotelsPageSection extends StatelessWidget {

  HotelsController _hotelsController;
  HotelsPageSection(this._hotelsController);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
        padding: const EdgeInsets.only(top: 24, left: 16),
        alignment: Alignment.centerLeft,
        child: Text("Hotels",  style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87),
        ),
      ),
        SizedBox(height: 16,),
        Obx(() {
              return Container(
              height: MediaQuery.of(context).size.height / 4, // height of the card view
              child: makeWidgetBasedOnState(_hotelsController.state.value, _hotelsController.scrollController,MediaQuery
                  .of(context)
                  .size
                  .height / 4),
        );
            }
          ),
      ],
    );
  }
}

makeWidgetBasedOnState(state.HomePageState s, ScrollController scrollController, height){

  FavoritesHotelsController favoritesHotelsController = Get.find<FavoritesHotelsController>();
  if(s is state.OnError){
    return Center(child: Text("Error while fetching hotels"));
  }
  else if(s is state.OnLoading){
    return Center(child: CircularProgressIndicator(),);
  }
  else if( s is state.OnSuccess){
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: s.lists.length, //todo
      itemBuilder: (ctx, i) {
        if(s.lists.length >= 19 && i >= s.lists.length - 1){

          return Row(
            children: [ItemWidget(s.lists.elementAt(s.lists.length -1) as Item,
              height: height,
              width: 200,
              isAttraction: false,
              addToFavoriteCallback: favoritesHotelsController.addToFavorites,
              removeFromFavoriteCallback: favoritesHotelsController.removeFromFavorites,),
              BottomLoader(),
            ],
          );
        }
        Item item = s.lists.elementAt(i) as Item;
        return ItemWidget(item,
          isAttraction: false,
          width: 200,
          height: height,
          addToFavoriteCallback: favoritesHotelsController.addToFavorites,
          removeFromFavoriteCallback: favoritesHotelsController.removeFromFavorites,);
      },
    );
  }

}

