

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/search_page_state.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/models/place_search_suggestion.dart';

class SearchPageController extends GetxController{
  final String hotelType = "Hotels";
  final String attractionType = "Attractions";
  late Repository _repository;
  late var searchResults = List<PlaceSearch>.empty(growable: true).obs;
  late var placeType = "".obs;
  var searchPageState = SearchPageState.initial.obs;
  late TextEditingController searchBarController;

  @override
  onInit() {
    super.onInit();
    _repository = Repository.instance();
    placeType.value = hotelType;
    searchBarController = new TextEditingController();

  }

  searchPlaces(String searchTerm) async {
    searchPageState.value = SearchPageState.loading;
    try{searchResults.value = await _repository.getAutocomplete(searchTerm, placeType.value);
    searchPageState.value = SearchPageState.onResult;
    }
    catch(e){
      searchPageState.value = SearchPageState.onError;
    }
  }

  changePlaceType(String? value){
    if(value == null){
      placeType.value = hotelType;
    }
    else if(value == attractionType){
      placeType.value = attractionType;
    }
  }

  addToFavorites(Item item){
    print("AddToFav this attraction");
    String type = Favorite.hotelType;
    if(placeType.value == attractionType){
      type = Favorite.attractionType;
    }
    Favorite favorite = Favorite(timeStamp: DateTime.now().millisecondsSinceEpoch,itemId: item.place_id, name: item.name, image: item.photo, type: type,rating: item.rating);
    _repository.addToFavorites(favorite);
  }

  removeFromFavorites(String placeId){
    _repository.removeFromFavorites(placeId);
  }



  @override
  void dispose() {
   // selectedLocation.close();
    //bounds.close();
    super.dispose();
  }

}