import 'package:location/location.dart';

class NetworkUtil{

  static String _apiKey = "Your_api_key_here";
  static const baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
  static const  baseUrlForDetail = "https://maps.googleapis.com/maps/api/place/details/json?";


  static String get apiKey => _apiKey;

  static String makeImageUrlFormReference(String photoReference){
    if (photoReference.isEmpty) {
      return "https://picsum.photos/200/300?random=1"; // todo make it random hotel picture
    }
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$_apiKey";
  }
}