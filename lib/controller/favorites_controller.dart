import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/favorite_attractions_controller.dart';
import 'package:tourist_guide/controller/favorite_guides_controller.dart';
import 'package:tourist_guide/controller/favorite_hotels_controller.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/models/item.dart';

class FavoritesController extends GetxController
    with SingleGetTickerProviderMixin {

  late TabController tabController;
  var state = custom.HomePageState().obs;
  late FavoriteAttractionController _attractionsController;
  late FavoritesHotelsController _hotelsController;
  late FavoritesGuidesController _favoritesGuidesController;
  static bool isOnInitCalled = false;


  @override
  void onInit() {
    print("Favorite controller Called nowwww");
    isOnInitCalled = true;
    tabController = new TabController(length: 3, vsync: this);
    _attractionsController  = Get.find<FavoriteAttractionController>();
    _hotelsController = Get.find<FavoritesHotelsController>();
    _favoritesGuidesController = Get.find<FavoritesGuidesController>();
  }

  bool isItemAlreadyFav(String itemId){
    if(_attractionsController.favAttractions.value.containsKey(itemId) || _hotelsController.favHotels.value.containsKey(itemId)){
      return true;
    }
    else{
      return false;
    }

  }

  bool isGuideAlreadyFav(String itemId){
    if(_favoritesGuidesController.favGuides.value.containsKey(itemId)){
      return true;
    }
    else{
      return false;
    }

  }



  void clearState(){
    isOnInitCalled = false;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

}