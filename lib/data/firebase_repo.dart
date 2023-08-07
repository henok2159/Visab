import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tourist_guide/controller/auth_controller.dart';
import 'package:tourist_guide/models/favorite.dart';
import 'package:tourist_guide/models/models.dart';

import 'favorite_datasrc_interface.dart';

class FirebaseRepo extends IFavoritesDataSource{
  late FirebaseFirestore _firestore;
  late Reference firebaseStorageRef ;
/*  String userId = "DiXbRvPwtveU4lVMycMvfEH91hg2";*/

  FirebaseRepo(){
    _firestore = FirebaseFirestore.instance;
    firebaseStorageRef = FirebaseStorage.instance.ref();
  }

  Future<bool> createNewUser(User user) async {
    try {
      await _firestore.collection("users").doc(user.userId).set(user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User> getUser(String uid) async {
    print("getUser called with userId : $uid}");
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("users").doc(uid).get();

      return User.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> updateUser(User user) async{
    print("Update user called....");
    try{
      await _firestore.collection("users").doc(user.userId).set(user.toJson());
      return true;
    }catch(e){
      return false;

    }
  }


  Future<bool> updateGuide(TourGuide guide) async{
    print("Update user called....");
    try{
      await _firestore.collection("guides").doc(guide.tourGuideId).set(guide.toJson());
      return true;
    }catch(e){
      return false;

    }
  }

  Stream<List<User>> getUsers(){
       return _firestore.collection("users").snapshots().map((QuerySnapshot query)
        {
          List<User> ?users = [];
          query.docs.forEach((element) {
            print("user id " + element.id);
            users.add(User.fromDocumentSnapshot(element));
          });
          return users;
        });
  }


  Stream<List<TourGuide>> getGuides(){
    try{return _firestore.collection("guides").snapshots().map((QuerySnapshot query)
    {
      List<TourGuide> ?guides = [];
      query.docs.forEach((element) {
        guides.add(TourGuide.fromDocumentSnapshot(element));
      });
      return guides;
    });}
    catch(e){
      throw Exception("error while fetching guides ..." + e.toString());
    }
  }

  Stream<List<City>> getCities(){
   try {
     return _firestore.collection("cities").snapshots().map((
         QuerySnapshot query) {
       List<City> ?cities = [];
       query.docs.forEach((element) {
         cities.add(City.fromDocumentSnapshot(element));
       });
       print("Cities list : ${cities.toString()}");
       return cities;
     });
   }
    catch(e){
    throw Exception("error while fetching cities ..." + e.toString());
    }
  }

  Future<TourGuide> getGuide(String uid) async {
    try {
      DocumentSnapshot _doc =
      await _firestore.collection("guides").doc(uid).get();

      return TourGuide.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool> addToFavorites(Favorite favorite) async{
    print("Current user id INSIDE addToFav: ${AuthenticationController.userId} ");
    // todo change sampleUserId to AutenticationController.userId
    try {
      await _firestore.collection("users").doc(AuthenticationController.userId).collection("favorites").doc(favorite.itemId).set(favorite.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Stream<List<Favorite>> getFavoriteAttractions() {
    print("getFavoriteAttractions called inside Firebase repo");
    try {
      return _firestore.collection("users").doc(AuthenticationController.userId).collection("favorites")
          .orderBy("time_stamp",descending: true).snapshots().map((QuerySnapshot query) {
        List<Favorite> ?favoriteAttractions= [];
        query.docs.forEach((element) {
          if(element['type'] == Favorite.attractionType) {
            favoriteAttractions.add(Favorite.fromDocumentSnapshot(element));
          }
        });
        //print("favorite attractions list ${favoriteAttractions.toString()}");
        return favoriteAttractions;
      });
    }
    catch(e){
      //print("Catch while fetching favorites attractions");
      throw Exception("error while fetching cities ..." + e.toString());
    }
  }

  @override
  Stream<List<Favorite>> getFavoriteHotels() {
    print("getFavoriteHotels called inside Firebase repo userId : ${AuthenticationController.userId}");

    try {
      return _firestore.collection("users").doc(AuthenticationController.userId).collection("favorites")
          .orderBy("time_stamp",descending: true)
          .snapshots().map((
          QuerySnapshot query) {
        List<Favorite> ?favoriteHotels= [];
        query.docs.forEach((element) {
          if(element['type'] == Favorite.hotelType) {
            favoriteHotels.add(Favorite.fromDocumentSnapshot(element));
          }
        });
        print("favorite hotels list ${favoriteHotels.toString()}");
        return favoriteHotels;
      });
    }
    catch(e){
      print("Catch while fetching favorites attractions");
      throw Exception("error while fetching cities ..." + e.toString());
    }
  }

  @override
  Stream<List<Favorite>> getFavoriteTourGuides() {
    print("getFavoriteTourGuides called inside Firebase repo");

    try {
      return _firestore.collection("users").doc(AuthenticationController.userId).collection("favorites")
          .orderBy("time_stamp",descending: true)
          .snapshots().map((
          QuerySnapshot query) {
        List<Favorite> ?favoriteAttractions= [];
        query.docs.forEach((element) {
          if(element['type'] == Favorite.tourGuideType) {
            favoriteAttractions.add(Favorite.fromDocumentSnapshot(element));
          }
        });
        return favoriteAttractions;
      });
    }
    catch(e){
      print("Catch while fetching favorites attractions");
      throw Exception("error while fetching cities ..." + e.toString());
    }
  }

  @override
  Future<bool> removeFromFavorites(String itemId) async{
    print("Current user id : ${AuthenticationController.userId}");
    try{
      await _firestore.collection("users").doc(AuthenticationController.userId).collection("favorites").doc(itemId).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<String> uploadImageToFirebase(String fileName, File imageFile) async {
    // type here used to identify the owner of the picture if 0 => admin , 1 => tour guide , 2=>
    String imageDirectory = "users_profiles";
    UploadTask uploadTask = firebaseStorageRef.child("$imageDirectory/$fileName").putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }


}