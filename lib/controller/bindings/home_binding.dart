import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/attractions_controller.dart';
import 'package:tourist_guide/controller/cities_controller.dart';
import 'package:tourist_guide/controller/dashboard_controller.dart';
import 'package:tourist_guide/controller/favorites_controller.dart';
import 'package:tourist_guide/controller/home_page_controller.dart';
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/controller/tour_guide_auth_controller.dart';
import 'package:tourist_guide/data/current_location.dart';
import 'package:tourist_guide/ui/pages/attractions_page_section.dart';

import '../auth_controller.dart';
import '../favorite_attractions_controller.dart';
import '../favorite_guides_controller.dart';
import '../favorite_hotels_controller.dart';
import '../reset_password_controller.dart';

class HomePageBinding extends Bindings{
  void dependencies() {
    print("HomePageBinding called ...");
    Get.put<CitiesController>(CitiesController());
    Get.put(FavoriteAttractionController());
    Get.put(FavoritesHotelsController());
    Get.put(FavoritesGuidesController());
    Get.put<FavoritesController>(FavoritesController());
    Get.put(AttractionsController(),tag: "home_page");
    Get.put<HotelsController>(HotelsController(),tag: "home_page");
    Get.put(HomePageController());
  }

  void clearState(){
      Get.find<FavoritesController>().clearState();
      Get.find<HomePageController>().dispose();
  }

}