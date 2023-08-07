import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tourist_guide/controller/attractions_controller.dart';
import 'package:tourist_guide/controller/cities_controller.dart';
import 'package:tourist_guide/controller/detail_page_state.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/controller/hotels_controller.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/city.dart';

import 'cities_controller.dart';

class CityDetailController extends GetxController {
  City _city;
  late HotelsController hotelsController;
  late AttractionsController attractionsController;
  late CitiesController citiesController;
  late Repository _repository;

  CityDetailController(this._city) {
    print(
        "CityDetailController hashcode for ${_city.name} is ${this.hashCode}");
    print("City hashcode inside CityDetailController : ${_city.hashCode}");
    print("hascode for this CityDetailcontroller class : ${this.hashCode}");

  }
  @override
  void onInit() {
    citiesController = Get.find<CitiesController>();
    hotelsController = Get.put(HotelsController(),tag: _city.cityId);
    attractionsController = Get.put(AttractionsController(), tag: _city.cityId);;
    _repository = Repository.instance();
   getData();
    super.onInit();
  }

  var state = DetailPageState().obs; // Rx<State> state;

  @override
  void dispose() {
    super.dispose();
  }

  void getData(){
    fetchData(_city.location.lat, _city.location.long);
  }

  void fetchData(double lat, double long) async {

    double latCopy = lat;
    double longCopy = long;
    try {
      hotelsController.state.value = custom.OnLoading();
      attractionsController.attractionState.value = custom.OnLoading();
      print("attractioncontroller items ${attractionsController.items.toString()}");
      var itemsList = await Future.wait([
        _repository.fetchAttractions(lat, long, saveNextPageCallback: (value) => attractionsController.nextPage = value),
        _repository.fetchHotels(latCopy, longCopy,saveNextPageCallback: (value) => hotelsController.nextPage = value)
      ]); //
      print("itemsList ${itemsList.toString()}");
      attractionsController.items.addAll(itemsList[0]);
      print("attractioncontroller items ${attractionsController.items.toString()}");
      hotelsController.items.addAll(itemsList[1]);
      attractionsController.attractionState.value =
          new custom.OnSuccess(attractionsController.items);
      hotelsController.state.value =
          new custom.OnSuccess(hotelsController.items);
    } catch (e) {
      attractionsController.attractionState.value = custom.OnError();
      hotelsController.state.value = custom.OnError();
    }
  }
}
