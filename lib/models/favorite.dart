import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'item.dart';

class Favorite{
  static final hotelType = "hotel";
  static final attractionType = "attraction";
  static final tourGuideType = "tour_guide";

  String itemId;
  int timeStamp;
  String name;
  double rating; // optional only applicable for attraction and hotels item
  String image;
  String type;

  Favorite({required this.timeStamp, required this.itemId,required this.name, required this.image,required this.type, this.rating = -1.0});



  factory Favorite.fromDocumentSnapshot(DocumentSnapshot json){
    return Favorite(
        itemId: json.id,
        timeStamp: json['time_stamp'],
        name: json['name'],
        image: json['image'],
        type: json['type'],
        rating: json['rating']
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json){
    return Favorite(
      timeStamp: json['time_stamp'],
      itemId: json['item_id'],
      name: json['name'],
      image: json['image'],
      type: json['type'],
      rating: json['rating']
    );
  }
  Map<String, dynamic> toJson(){
    return {
     'item_id':this.itemId,
      'name' : this.name,
      'rating' : this.rating,
      'image' : this.image,
      'type' : this.type,
      'time_stamp' : this.timeStamp
    };
  }


  @override
  String toString() {
    //return "=======================Favorite=================\nName : $name\nitemId : $itemId\nRating : $rating\nimage : $image\ntype : $type";
    return "Name : $name";
  }
}

