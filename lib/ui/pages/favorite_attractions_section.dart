import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:tourist_guide/controller/favorite_attractions_controller.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as state;
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/widgets/item.dart';

class FavoriteAttractionsSection extends GetView<FavoriteAttractionController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: GetX<FavoriteAttractionController>(
          builder: (controller) {
            return makeWidgetBasedOnState(controller.state.value,context);
          }
      ),
    );
  }
}


Widget makeWidgetBasedOnState(state.HomePageState s, BuildContext context){
  FavoriteAttractionController controller = Get.find<FavoriteAttractionController>();
  if(s is state.OnError){
    return Center(child: Text("Error while fetching attractions"));
  }
  else if(s is state.OnLoading){
    return Center(child: CircularProgressIndicator(),);
  }
  else if( s is state.OnSuccess){
    return  controller.favAttractions.value.length != 0 ? ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: controller.favAttractions.value.length,
      itemBuilder: (ctx, i) {
        Favorite favorite = controller.favAttractions.value.values.elementAt(i);
        return Container(
            key: ValueKey(i),
            padding: EdgeInsets.only(top: 4, bottom: 4),
            height : MediaQuery.of(context).size.height/4,
            child:
            ItemWidget(Item(favorite.name,favorite.itemId,favorite.rating,favorite.image),
              height:  MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width,
              isAttraction: true
              ,addToFavoriteCallback: controller.addToFavorites,
              removeFromFavoriteCallback: controller.removeFromFavorites,)
        );//todo
      },
    ) : Center(child: Text("No Attraction is selected as a favorite."));
  }
  else{
    return Center(child: Text("Else branch..."),);
  }

}



