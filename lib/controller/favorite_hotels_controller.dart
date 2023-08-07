import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/models/item.dart';

class FavoritesHotelsController extends GetxController
    with SingleGetTickerProviderMixin {

  Rx<Map<String,Favorite>> _favHotels = Rx<Map<String,Favorite>>(LinkedHashMap());

  Rx<Map<String, Favorite>> get favHotels => _favHotels;

  late Repository _repository;
  late TabController tabController;
  var state = custom.HomePageState().obs;
  @override
  void onInit() {
    tabController = new TabController(length: 3, vsync: this);
    _repository = Repository.instance();
    bindStream();

  }

  void bindStream(){
    state.value = new custom.OnLoading();
    try {
      _favHotels.bindStream(_repository.getFavoriteHotels());
      state.value = new custom.OnSuccess(favHotels.value.values.toList());
    }catch(e){
      state.value = new custom.OnError();
    }
  }

  addToFavorites(Item item){

  print("AddToFav this hotel");
  Favorite favorite = Favorite(timeStamp: DateTime.now().millisecondsSinceEpoch,itemId: item.place_id, name: item.name, image: item.photo, type: Favorite.hotelType,rating: item.rating);
    _repository.addToFavorites(favorite);
  }

  removeFromFavorites(String placeId){
    _repository.removeFromFavorites(placeId);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


}