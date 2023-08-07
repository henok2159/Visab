import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:tourist_guide/models/item.dart';
import 'package:tourist_guide/models/item_detail.dart';
import 'package:tourist_guide/models/place_search_suggestion.dart';
import 'package:tourist_guide/utils/network_util.dart';
import 'package:tourist_guide/data/mock_data.dart';

// build cmd = flutter pub run build_runner build
// baseUrl = https://maps.googleapis.com/maps/api/place/details/json?
// place_id=&key=YOUR_API_KEY
class PlacesApiService{

  static PlacesApiService _placesApiService = PlacesApiService();
  static PlacesApiService get instance => _placesApiService;

  String hotelsPageToken = "";
  String attractionsPageToken = "";
  //location=9.0476609,38.7599358&type=lodging
  String baseUrl = NetworkUtil.baseUrl;
  String _apiKey = NetworkUtil.apiKey;
  String baseUrlForDetail = NetworkUtil.baseUrlForDetail;

    Future<String> makeCompleteUrl(double lat, double long, bool isHotel) async{
    String temp = baseUrl+"location=$lat,$long&radius=${5000}";
    if(isHotel){
      temp += "&type=lodging&keyword=hotel&key=$_apiKey";
    }
    else{
      temp += "&type=tourist_attraction&key=$_apiKey";
      temp += "";
    }
    return temp;
  }

  Future<List<Item>> fetchHotels(double lat, double long,{required Function(String) callback}) async {
    print("Current lat and long $lat, $long inside fetchHotels()");
    /*if(lat > 7){
      return MockData.getHotels2();
    }
    return MockData.getHotels();*/
    try {
      String fullUrl = await makeCompleteUrl(lat,long,true);
      print("Complete url for hotels : " + fullUrl);

      http.Response response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        List<Item> hotels = parseItemResponse(response.body, true,callback: (value) => callback(value));
        return hotels;
      }
      else {
        print("Error while loading inside placesApiService...");
        throw Exception("Error while loading users...");
      }
    }catch(e){
      throw Exception();
    }
  }
  Future<List<Item>> fetchAttractions(double lat, double long,{required Function(String) callback}) async{
    /*if(lat > 7){
      return MockData.getAttractions2();
    }
      return MockData.getAttractions();*/
    print("Current lat and long $lat, $long inside fetchAttractions()");
    try {
      String fullUrl = await makeCompleteUrl(lat,long, false);
      //String fullUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=9.0485246,38.7582737&radius=5000&type=tourist_attraction&key=AIzaSyAgryGM0W7_UkWuLA3qcmcTrY2QkCxFxjw";
      print("Complete url for Attractions : " + fullUrl);
      http.Response response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        print("Response status for Attractions request is 200");
        List<Item> attractions = parseItemResponse(response.body, false, callback: (value) => callback(value));
        print("parsedAttractions to be returned ${attractions.toString()}");
        return attractions;
      }
      else {
        print("Error while loading inside placesApiService...");
        throw Exception("Error while loading users...");
      }
    }catch(e){
  throw Exception();
  }
  }

  List<Item> parseItemResponse(String responseBody,bool isHotel, {required Function(String) callback}){
    final Map<String,dynamic> parsed = json.decode(responseBody);
    if(parsed.containsKey("next_page_token")){
      print("NextPage token : ${parsed["next_page_token"]}");
      callback(parsed["next_page_token"]);
      if(isHotel){
        hotelsPageToken = parsed["next_page_token"] as String;
        print("print hotelsPageToken : $hotelsPageToken");
      }
      else{
        attractionsPageToken = parsed["next_page_token"] as String;
        print("print attractionsPageToken : $attractionsPageToken");

      }
    }
    var items = parsed["results"] as List;
    List<Item> parsedItems = List<Item>.empty(growable: true);
    for(int i = 0; i < items.length ; i++){
      Item currentItem = Item.fromJson(items[i]);
      print("CurrentItem : ${currentItem.toString()}");
      parsedItems.add(currentItem);
    }
    print("Parsed Items ${parsedItems.toString()}");
    return parsedItems;
  }

  Future<List<Item>> fetchNextPage(bool isHotel,String nextPageToken, {required Function(String) callback}) async {
    String nextUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
      if(nextPageToken == ""){
        throw NoNextPageException();
      }
      nextUrl += "pagetoken=$nextPageToken&key=$_apiKey";

    print("FetchNextPage url : " + nextUrl);
    http.Response response = await http.get(Uri.parse(nextUrl));
    if(response.statusCode == 200){
      List<Item> hotels =  parseItemResponse(response.body, false, callback: (value) => callback(value));
      return hotels;
    }
    else{
      print("Error while loading inside placesApiService...");
      throw Exception("Error while loading users...");
    }
  }

  Future<ItemDetail> fetchItemDetail(String placeId) async{
    //https://maps.googleapis.com/maps/api/place/details/json?
   // return MockData.getDetail(placeId);
      String baseUrlForDetail = NetworkUtil.baseUrlForDetail + "place_id=$placeId&key=$_apiKey";
      print("itemDetail url $baseUrlForDetail");
      http.Response response = await http.get(Uri.parse(baseUrlForDetail));
      if(response.statusCode == 200){
        ItemDetail itemDetail =  parseItemDetailResponse(response.body);
        print("FetchedItemDetail : " + itemDetail.toString());
        return itemDetail;
      }
      else{
        print("Error while loading inside placesApiService...");
        throw Exception("Error while loading users...");
      }
  }

  ItemDetail parseItemDetailResponse(String responseBody){
    final Map<String,dynamic> parsed = json.decode(responseBody);
    var result = parsed["result"];
    ItemDetail itemDetail = ItemDetail.fromJson(result);
    return itemDetail;
  }
  Future<List<PlaceSearch>> getAutocomplete(String search,String type) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=establishment&components=country:et&key=${NetworkUtil.apiKey}';
        print("Autocomplete link: $url");
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("getAutocompleteSearch called ...");
        var json = jsonDecode(response.body);
        var jsonResults = json['predictions'] as List;
        //print("Predictions from autocomplete : $jsonResults");
        return jsonResults.map((place){
          PlaceSearch search = PlaceSearch.fromJson(place);
          print("Prediction : ${search.toString()}");
        return search;}).toList();
      }
      else{
        throw Exception("Error while doing autocompete search..");
      }
    }catch(e){
      throw Exception("Error while doing autocompete search..");
    }

  }

}






class LocationPermissionException implements Exception{

}

class NoNextPageException implements Exception{

}