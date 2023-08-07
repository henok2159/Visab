


import 'package:tourist_guide/models/geometry.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/models/location.dart';
import 'package:tourist_guide/models/photo.dart';
import 'package:tourist_guide/models/review.dart';

class MockData{

  static List<Item> hotels = [Item("Hotel 1","hotel_1",4.5,""),Item("Hotel 2","hotel_2",4,""),Item("Hotel 1","hotel_1",4.5,""),Item("Hotel 1","hotel_1",4.5,""),Item("Hotel 1","hotel_1",4.5,""),
    Item("Hotel 1","hotel_1",4.5,""),Item("Hotel 1","hotel_1",4.5,"")];
  static List<Item> attractions =  [Item("Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,"")];

  static ItemDetail detail = ItemDetail("Hotel Name","id", "Addis Ababa, Ethiopia","+251989324323", [Photo(""),Photo(""),Photo(""),Photo(""),Photo(""),Photo("")], 4.5, [Review("Author Name","https://qph.fs.quoracdn.net/main-qimg-6291c3a117fc230c82785148baef7eed",4.6,"a week ago","text of the review goes here")], Geometry(Location(9.8,38.23)));

  static List<Item> hotels2 = [Item("New Hotel","hotel_1",4.5,""),Item("New Hotel 2","hotel_2",4,""),Item("New Hotel 3","hotel_1",4.5,""),Item("New Hotel 4","hotel_1",4.5,""),Item("New Hotel 5","hotel_1",4.5,""),
    Item("New Hotel 6","hotel_1",4.5,""),Item("New Hotel 7","hotel_1",4.5,"")];

  static List<Item> attractions2 =  [Item("New Attraction 1","attraction_1",4.5,""),
    Item("New Attraction 1","attraction_1",4.5,""),Item("New Attraction 1","attraction_1",4.5,""),Item("New Attraction  1","attraction_1",4.5,""),Item("New Attraction 1Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,""),Item("Attraction 1","attraction_1",4.5,"")];


  static Future<List<Item>> getHotels(){
    print("getHotels() called from mock");
    return Future.delayed(Duration(milliseconds: 1000),() => hotels);
  }
  static Future<List<Item>> getHotels2(){
    print("getHotels2() called from mock");

    return Future.delayed(Duration(milliseconds: 1000),() => hotels2);
  }


  static Future<List<Item>> getAttractions(){
    print("getAttractions() called from mock");
    return Future.delayed(Duration(milliseconds: 1000),() => attractions);
  }

  static Future<List<Item>> getAttractions2(){
    print("getAttractions2() called from mock");
    return Future.delayed(Duration(milliseconds: 1000),() => attractions2);
  }

  static Future<ItemDetail> getDetail(String placeId){
    return Future.delayed(Duration(milliseconds: 1000,),()=>detail);
  }


}