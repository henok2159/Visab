import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/models/tour_guide.dart';




class GuidesController extends GetxController with SingleGetTickerProviderMixin{
  Rx<List<TourGuide>> _guides = Rx<List<TourGuide>>(List.empty());


  Rx<List<TourGuide>> get guides => _guides;

  Repository _repository = Repository.instance();

  @override
  void onInit() {
    _guides.bindStream(_repository.getGuides());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<TourGuide> getTourGuide(String id) async{
    return await _repository.getGuide(id);
  }

}