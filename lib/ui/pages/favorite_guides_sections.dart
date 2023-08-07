import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:tourist_guide/controller/favorite_guides_controller.dart';
import 'package:tourist_guide/controller/favorite_hotels_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as state;
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/ui/widgets/bottom_loader.dart';
import 'package:tourist_guide/ui/widgets/guide_item.dart';
import 'package:tourist_guide/ui/widgets/item_depreciated.dart';
import 'package:tourist_guide/ui/widgets/item.dart';

class FavoriteTourGuidesSection extends GetView<FavoritesGuidesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: GetX<FavoritesGuidesController>(
          builder: (controller) {
            return makeWidgetBasedOnState(controller.state.value,context);
          }
      ),
    );
  }
}

Widget makeWidgetBasedOnState(state.HomePageState s, BuildContext context){
  FavoritesGuidesController controller = Get.find<FavoritesGuidesController>();
  if(s is state.OnError){
    return Center(child: Text("Error while fetching guides"));
  }
  else if(s is state.OnLoading){
    return Center(child: CircularProgressIndicator(),);
  }
  else if( s is state.OnSuccess){
    return controller.favGuides.value.length != 0 ?GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      ),
      itemCount: controller.favGuides.value.length,
      itemBuilder: (_, index) {
        Favorite favorite = controller.favGuides.value.values.elementAt(index);
        return GuideWidget(favorite.itemId,favorite.name,favorite.image);
      },
    ) :  Center(child: Text("No Guide is selected as a favorite."));
  }
  else{
    return Center(child: Text("Else branch..."),);
  }

}

