import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/models/item.dart';

class FavoriteAttractionController extends GetxController
    with SingleGetTickerProviderMixin {

  Rx<Map<String, Favorite>> _favAttractions = Rx<Map<String, Favorite>>(LinkedHashMap());
  Rx<Map<String, Favorite>> get favAttractions => _favAttractions;

  late Repository _repository;
  late TabController tabController;
  var state = custom.HomePageState().obs;
  FavoriteAttractionController();
  @override
  void onInit() {
    print("Fav Attraction onInit called");
    tabController = new TabController(length: 3, vsync: this);
    _repository = Repository.instance();
    bindStream();

  }

  void bindStream(){
    state.value = new custom.OnLoading();
    try {
      print("Fav Attraction onInit above binding methods");
      _favAttractions.bindStream(_repository.getFavoriteAttractions());
      state.value = new custom.OnSuccess(_favAttractions.value.values.toList());
    }catch(e){
      state.value = new custom.OnError();
    }
  }


  addToFavorites(Item item){
    print("AddToFav this attraction");
    Favorite favorite = Favorite(timeStamp: DateTime.now().millisecondsSinceEpoch,itemId: item.place_id, name: item.name, image: item.photo, type: Favorite.attractionType,rating: item.rating);
    _repository.addToFavorites(favorite);
  }

  removeFromFavorites(String placeId){
    _repository.removeFromFavorites(placeId);
  }

  @override
  void dispose() {
    print("Fav Attraction dispose method called");
    tabController.dispose();
    super.dispose();
  }


}