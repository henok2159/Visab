import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/models/tour_guide.dart';

class FavoritesGuidesController extends GetxController
    with SingleGetTickerProviderMixin {

  Rx<Map<String, Favorite>> _favGuides =Rx<Map<String, Favorite>>(LinkedHashMap());


  Rx<Map<String, Favorite>> get favGuides => _favGuides;
  late Repository _repository;
  var state = custom.HomePageState().obs;
  @override
  void onInit() {
    _repository = Repository.instance();
    bindStream();
  }

  void bindStream(){
    state.value = new custom.OnLoading();
    try {
      _favGuides.bindStream(_repository.getFavoriteTourGuides());
      state.value = new custom.OnSuccess(_favGuides.value.values.toList());
    }catch(e){
      state.value = new custom.OnError();
    }
  }


  addToFavorites(TourGuide guide){
    Favorite favorite = Favorite(timeStamp: DateTime.now().millisecondsSinceEpoch,itemId: guide.tourGuideId, name: guide.name, image: guide.imageUrl, type:  Favorite.tourGuideType);
    _repository.addToFavorites(favorite);
  }

  removeFromFavorites(String guideId){
    _repository.removeFromFavorites(guideId);
  }

  @override
  void dispose() {
    super.dispose();
  }


}