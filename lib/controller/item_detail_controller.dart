
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/detail_page_state.dart';
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/utils/network_util.dart';

class ItemDetailController extends GetxController with SingleGetTickerProviderMixin{

  Repository _repository = Repository.instance();
  var state = DetailPageState().obs;// Rx<State> state;
  late TabController tabController;
  late ItemDetail itemDetail;
  String? placeId;

  ItemDetailController({this.placeId});
  @override
  void onInit() {
    tabController = new TabController(length: 3, vsync: this);
    if(placeId != null){
      fetchDetails(placeId!);
    }
    super.onInit();
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void fetchDetails(String placeId) async {
    print("place id in the itemdetail controller : ");
    state.value = OnLoading();
    try {
        itemDetail = await _repository.fetchItemDetail(placeId);
        state.value = OnSuccess(itemDetail);
    }
    catch (e) {
      state.value = OnError();
    }
  }

  static String makeImageUrlFormReference(String photoReference) {
    if (photoReference.isEmpty) {
      return "https://picsum.photos/200/300?random=1"; // todo make it random hotel picture
    }
    return NetworkUtil.makeImageUrlFormReference(photoReference);
  }
}