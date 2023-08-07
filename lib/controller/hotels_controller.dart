
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_guide/controller/home_page_state.dart' as custom;
import 'package:tourist_guide/data/repository.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/utils/network_util.dart';

class HotelsController extends GetxController{

  Repository _repository = Repository.instance();
  var state = custom.HomePageState().obs; // Rx<State> state;
  late ScrollController _scrollController;
  List<Item> items = List.empty(growable: true);
  String nextPage = "";

  ScrollController get scrollController => _scrollController;

  @override
  void onInit() async {
    print("HotelController hashcode: ${this.hashCode}" );
    _scrollController = new ScrollController();
    _scrollController.addListener(_onScroll);
    super.onInit();
  }

  static String makeImageUrlFormReference(String photoReference){
    if(photoReference.isEmpty){
      return "https://picsum.photos/200/300?random=1";// todo make it random hotel picture
    }
    return NetworkUtil.makeImageUrlFormReference(photoReference);
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
  void fetchNextPage() async{
    try {
      List<Item> nextItems = await _repository.fetchNextPage(true, nextPage, saveNextPageCallback: (value) => nextPage = value);
      items.addAll(nextItems);
      state.value  = new custom.OnSuccess(items);
    }
    catch(e){
      throw Exception("Error while fetching the next page");
    }
  }

  addToFavorites(Item item){
    Favorite favorite = Favorite(timeStamp: DateTime.now().millisecondsSinceEpoch,itemId: item.place_id, name: item.name, image: item.photo, type: "hotel",rating: item.rating);
    _repository.addToFavorites(favorite);
  }

  removeFromFavorites(String placeId){
    _repository.removeFromFavorites(placeId);
  }


}