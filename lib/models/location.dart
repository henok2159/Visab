class Location{

  double lat;
  double long;
  Location(this.lat, this.long);

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(json['lat'],json['lng']);
  }
  Map<String, dynamic> toJson(){
    return {
      "lat" : this.lat, "lng" :  this.long
    };
  }

  @override
  String toString() {
    return "Lat : $lat, Long : $long";
  }
}