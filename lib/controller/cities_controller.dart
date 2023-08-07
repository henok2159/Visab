

import 'package:get/get.dart';
import 'package:tourist_guide/controller/home_page_state.dart';
import 'package:tourist_guide/data/repository.dart';

class CitiesController extends GetxController{

  late var state = HomePageState().obs;
  var cities = List.empty(growable: true).obs;
  late Repository _repository;

  @override
  void onInit() async {
    _repository = Repository.instance();
    state.value = OnLoading();
    cities.bindStream(_repository.getCitiesAsStream());
    super.onInit();
  }
}