import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tourist_guide/models/photo.dart';
part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item{
  String name;
  String place_id;
  String  photo;
  double rating;

  Item(this.name, this.place_id, this.rating,this.photo);

  factory Item.fromJson(Map<String, dynamic> json){
    return _$ItemFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$ItemToJson(this);
  }

  factory Item.fromDocumentSnapshot(DocumentSnapshot json) {
    return Item(
      json['name'] as String,
      json['place_id'] as String,
    (json['rating'] as num).toDouble(),
    (json['photo'] as String),
    );
  }

  @override
  String toString() {
    return ("===================\nName : ${this.name}\nRating :  ${this.rating}\nPhoto: $photo\n===================");
  }

}