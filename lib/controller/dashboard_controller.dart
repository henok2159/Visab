
import 'package:get/get.dart';
import 'package:tourist_guide/controller/bindings/home_binding.dart';
import 'package:tourist_guide/controller/favorite_attractions_controller.dart';
import 'package:tourist_guide/controller/favorite_guides_controller.dart';
import 'package:tourist_guide/controller/favorite_hotels_controller.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/ui/pages/account_page.dart';
import 'package:tourist_guide/ui/pages/dashboard_page.dart';
import 'package:tourist_guide/ui/pages/favorites_page.dart';

import 'home_page_controller.dart';

class DashboardController extends GetxController{
  HomePageBinding homePageBinding = new HomePageBinding();
  @override
  void onInit() {
    homePageBinding.dependencies();
    print("OnInit called in Dashboard controller");
    if(!FavoritesController.isOnInitCalled){
      Get.find<FavoriteAttractionController>().bindStream();
      Get.find<FavoritesHotelsController>().bindStream();
      Get.find<FavoritesGuidesController>().bindStream();
    }
    Get.find<HomePageController>().getData();
    super.onInit();
  }
  var tabIndex = 0;
  var title = "Home".obs;
  List<String> titles = ["Home","Favorite","Account"];

  void changeTabIndex(int index,[bool isCityDetailPage = false]){

    print("changeTabIndex value : $index");
    tabIndex = index;
    if(isCityDetailPage){
      if(index == 1){
        Get.to(()=>DashboardPage());
      }else if(index == 2){
        Get.to(()=>DashboardPage());
      }
    }
    title.value = titles[index];
    update();
  }

  void changeTitle(String title){
    this.title.value = title;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void clearState(){
    homePageBinding.clearState();
  }
}