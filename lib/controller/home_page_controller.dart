

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:location/location.dart';
import 'package:tourist_guide/controller/attractions_controller.dart';
import 'package:tourist_guide/controller/detail_page_state.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as homeState;
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/data/places_api_service.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/city.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/utils/network_util.dart';
import 'cities_controller.dart';

class HomePageController extends GetxController{

  Repository _repository = Repository.instance();

  late HotelsController hotelsController;
  late AttractionsController attractionsController;
  late CitiesController citiesController;
  late LocationData _locationData;

  @override
  void onInit(){
    print("before onInit() in homepage controller");
    citiesController  = Get.find<CitiesController>();
    attractionsController  = Get.find<AttractionsController>(tag: "home_page");
    hotelsController  = Get.find<HotelsController>(tag: "home_page");
    super.onInit();
  }
  void getData() async{
    _locationData = await getLocationData();
    fetchData(_locationData.latitude!, _locationData.longitude!);

  }
  void fetchData(double lat, double long ) async {
    print("Current lat and long $lat, $long");
    double latCopy = lat;
    double longCopy = long;
    // todo
    /*
    * determine current location of the user in this class
    * use that location for both hotels and attractions
    * use fetchAttractions(lat,long) and fetchHotels(lat,long) method instead of fetchAttractions()
    *
    * */
    try {
      hotelsController.state.value = custom.OnLoading();
      attractionsController.attractionState.value = custom.OnLoading();
      citiesController.state.value = custom.OnLoading();
      var itemsList = await Future.wait([_repository.fetchAttractions(lat,long,saveNextPageCallback: (value){
        attractionsController.nextPage = value;}),_repository.fetchHotels(latCopy,longCopy,saveNextPageCallback: (value) => hotelsController.nextPage = value)]);//
      //var itemsList = await Future.wait([_repository.getCities()]);//

      attractionsController.items.addAll(itemsList[0]);
      hotelsController.items.addAll(itemsList[1]);
      attractionsController.attractionState.value = new custom.OnSuccess(attractionsController.items);
      hotelsController.state.value = new custom.OnSuccess(hotelsController.items);
      citiesController.state.value = new custom.OnSuccess(List.empty());
    }
    catch(e){
      attractionsController.attractionState.value = custom.OnError();
      hotelsController.state.value = custom.OnError();
      citiesController.state.value = custom.OnError();
    }
  }


  static Future<LocationData> getLocationData() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData? _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw LocationPermissionException();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }
  @override
  void dispose() {
    hotelsController.state.value = custom.OnLoading();
    attractionsController.attractionState.value = custom.OnLoading();
    citiesController.state.value = custom.OnLoading();
    super.dispose();
  }
/*  addToFavorites(Item item,String type){
    Favorite favorite = Favorite(itemId: item.place_id, name: item.name, image: item.photo, type: type);
    _repository.addToFavorites(favorite);
  }*/

/*
  removeFromFavorites(String placeId){
    _repository.removeFromFavorites(placeId);
  }
*/

}