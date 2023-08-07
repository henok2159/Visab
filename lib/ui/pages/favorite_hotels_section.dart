import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorite_hotels_controller.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as state;
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/widgets/item.dart';

class FavoriteHotelsSection extends GetView<FavoritesHotelsController> {
  FavoritesHotelsController controller = Get.put(FavoritesHotelsController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: GetX<FavoritesHotelsController>(
          builder: (controller) {
            return makeWidgetBasedOnState(controller.state.value,context);
          }
      ),
    );
  }
}

Widget makeWidgetBasedOnState(state.HomePageState s, BuildContext context){
  FavoritesHotelsController controller = Get.find<FavoritesHotelsController>();
  if(s is state.OnError){
    return Center(child: Text("Error while fetching hotels"));
  }
  else if(s is state.OnLoading){
    return Center(child: CircularProgressIndicator(),);
  }
  else if( s is state.OnSuccess){
    return controller.favHotels.value.length != 0 ? ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: controller.favHotels.value.length,
      itemBuilder: (ctx, i) {
        Favorite favorite = controller.favHotels.value.values.elementAt(i);
        return Container(
          key: ValueKey(i),
            padding: EdgeInsets.only(top: 2, bottom: 2),
            height : MediaQuery.of(context).size.height/4,
            child: ItemWidget(Item(favorite.name,favorite.itemId,favorite.rating,favorite.image),
              height:  MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width,
              isAttraction: false
              ,addToFavoriteCallback: controller.addToFavorites,
              removeFromFavoriteCallback: controller.removeFromFavorites,)
        );//todo
      },
    ) : Center(child: Text("No Hotel is selected as a favorite."));
  }
  else{
    return Center(child: Text("Else branch..."),);
  }

}

