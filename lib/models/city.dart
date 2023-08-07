import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tourist_guide/models/location.dart';
part 'city.g.dart';

@JsonSerializable()
class City{
  String cityId;
  String name;
  String imageUrl;
  String description;
  Location location;

  City(this.cityId,this.name, this.imageUrl,this.description,this.location);

  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);

  factory City.fromDocumentSnapshot(DocumentSnapshot json) {
    return City(
      json.id,
      json['name'] as String,
      json['imageUrl'] as String,
      json['description'] as String,
      Location.fromJson(json['location'])
    );
  }

}