
import 'package:tourist_guide/models/location.dart';

class Geometry{
  Location location;

  Geometry(this.location);

  factory Geometry.fromJson(Map<String, dynamic> json){
    print("Geometry.fromJson() called");
    return Geometry(Location.fromJson(json['location']));
  }
  Map<String, dynamic> toJson(){
    return {
      "location" : this.location
    };
  }


}