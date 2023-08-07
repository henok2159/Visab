

import 'dart:collection';
import 'dart:io';

import 'package:tourist_guide/data/firebase_repo.dart';
import 'package:tourist_guide/data/places_api_service.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/models/models.dart';
import 'package:tourist_guide/models/place_search_suggestion.dart';

class Repository{

  // todo : inject dependencies using constructor injection
  PlacesApiService _placesApiService = PlacesApiService.instance;
  late FirebaseRepo _firebaseRepo;
  static Repository? _repository;

  Repository._Repository(){
    _firebaseRepo = FirebaseRepo();
  }


  static Repository instance(){
    if(_repository == null){
      _repository = Repository._Repository();
    }
    return _repository!;
  }

  Future<List<Item>> fetchHotels(double lat, double long, {required Function(String) saveNextPageCallback}) async {
    try{
      return _placesApiService.fetchHotels(lat,long,callback : (value) => saveNextPageCallback(value));
    }catch(e){
      rethrow;
    }
  }

  Future<List<Item>> fetchAttractions(double lat, double long,{required Function(String) saveNextPageCallback}) async {
    try{
      return _placesApiService.fetchAttractions(lat,long,callback : (value) => saveNextPageCallback(value));
    }catch(e){
      rethrow;
    }
  }

  Future<List<PlaceSearch>> getAutocomplete(String search,String type) async {
    try{
      return  _placesApiService.getAutocomplete(search,type);
    }catch(e){
      rethrow;
    }
  }

  Future<TourGuide> getGuide(String uid) async {
    try {
     return _firebaseRepo.getGuide(uid);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<User> getUser(String uid) async {
    try {
      return _firebaseRepo.getUser(uid);
    } catch (e) {
      print(e);
      rethrow;
    }
  }




  Stream<List<TourGuide>> getGuides(){
    try{
      return _firebaseRepo.getGuides();
    }
    catch(e){
      rethrow;
    }
  }

  Stream<List<City>> getCitiesAsStream(){
    try{
      return _firebaseRepo.getCities();
    }
    catch(e){
      rethrow;
    }
  }
  Future<List<City>> getCities(){
    print("getCities called in side repo");
      return getCitiesAsStream().first;
  }

  Future<List<Item>> fetchNextPage(bool isHotel,String nextPage, {required Function(String) saveNextPageCallback}) async {
    try{
      return _placesApiService.fetchNextPage(isHotel, nextPage, callback : (value) =>saveNextPageCallback(value));
    }
    catch(e){
      throw Exception("Error while fetching next page");
    }
  }

  Future<ItemDetail> fetchItemDetail(String placeId) async{
        return _placesApiService.fetchItemDetail(placeId);
  }



  Future<bool> addToFavorites(Favorite favorite) async{
    try {
                return await  _firebaseRepo.addToFavorites(favorite);
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> updateUser(User user) async{
    try {
      return await  _firebaseRepo.updateUser(user);
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> updateGuide(TourGuide guide) async{
    try {
      return await  _firebaseRepo.updateGuide(guide);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<Map<String, Favorite>> getFavoriteAttractions(){
    Stream<List<Favorite>> favoriteAttractions = _firebaseRepo.getFavoriteAttractions();
         return favoriteAttractions .map((event){
          // print("Favorite Attractions : $event");
        Map<String, Favorite> favoriteHotels = LinkedHashMap();
        event.forEach((element) {
          favoriteHotels.putIfAbsent(element.itemId, () => element);
        });
        return favoriteHotels;
      });

  }

  Stream<Map<String,Favorite>> getFavoriteHotels(){

    Stream<List<Favorite>> favoriteHotels =  _firebaseRepo.getFavoriteHotels();
    return favoriteHotels.map((event){
      //print("Favorite Hotels : $event");
      Map<String, Favorite> favoriteHotels = LinkedHashMap();
      event.forEach((element) {
        favoriteHotels.putIfAbsent(element.itemId, () => element);
      });
      return favoriteHotels;
    });

  }


  Stream<Map<String,Favorite>> getFavoriteTourGuides(){
    Stream<List<Favorite>> favoriteHotels =  _firebaseRepo.getFavoriteTourGuides();
    return favoriteHotels.map((event){
      Map<String, Favorite> favoriteHotels = LinkedHashMap();
      event.forEach((element) {
        favoriteHotels.putIfAbsent(element.itemId, () => element);
      });
      return favoriteHotels;
    });
  }



/*  Stream<List<Favorite>> getFavoriteFromRemote() {
    print("From remote");
    return _firebaseRepo.getFavorites().map((event){
      if(inMemoryCache == null){
        inMemoryCache = LinkedHashMap();
      }
      event.forEach((element) {inMemoryCache!.putIfAbsent(element.itemId, () => element);});
      print("InMemoryCache : ${inMemoryCache.toString()}");
      return event;
    });
  }*/



  Future<bool> removeFromFavorites(String itemId) async{
    try{
      return await _firebaseRepo.removeFromFavorites(itemId);
    }
    catch(e){
      return false;
    }
  }
  Future<String> uploadImageToFirebase(String fileName, File imageFile) async {
    try{
      return await _firebaseRepo.uploadImageToFirebase(fileName, imageFile);
    }catch(e){
      rethrow;
    }
  }

}