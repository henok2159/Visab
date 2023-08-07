import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/utils/network_util.dart';

class AttractionsController extends GetxController{

  Repository _repository = Repository.instance();
  var attractionState = custom.HomePageState().obs;
  List<Item> items = List.empty(growable: true);
  late ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  String nextPage = "";


  @override
  void onInit() async {
    print("AttractionsController hashcode: ${this.hashCode}");
    _scrollController = new ScrollController();
    _scrollController.addListener(_onScroll);
    super.onInit();
  }


  void fetchNextPage() async{
    print("Next page of attractions list : $nextPage");
      try {
        List<Item> nextItems = await _repository.fetchNextPage(false, nextPage, saveNextPageCallback: (String value) {
          nextPage = value; });
        items.addAll(nextItems);
        attractionState.value  = new custom.OnSuccess(items);
      }
      catch(e){
        //throw Exception("Error while fetching the next page");
      }
  }


  void _onScroll() {
    if (_isBottom){
      fetchNextPage();
       }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  void  addToFavorites(Item item){
    Favorite favorite = Favorite(timeStamp: DateTime.now().millisecondsSinceEpoch,itemId: item.place_id, name: item.name, image: item.photo, type: "attraction");
    _repository.addToFavorites(favorite);
  }

  removeFromFavorites(String placeId){
    _repository.removeFromFavorites(placeId);
  }

}
