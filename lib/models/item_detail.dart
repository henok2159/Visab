

import 'package:json_annotation/json_annotation.dart';
import 'package:tourist_guide/models/geometry.dart';
import 'package:tourist_guide/models/location.dart';
import 'package:tourist_guide/models/photo.dart';
import 'package:tourist_guide/models/review.dart';

part 'item_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemDetail{
    String name;
    String formatted_address;
    String international_phone_number;
    List<Photo> photos;
    Geometry geometry;
    String place_id;
    double rating;
    List<Review> reviews;

    ItemDetail(this.name,this.place_id,this.formatted_address,this.international_phone_number,this.photos,this.rating,this.reviews, this.geometry);

    factory ItemDetail.fromJson(Map<String, dynamic> json){
      return _$ItemDetailFromJson(json);
    }

    Map<String, dynamic> toJson(){
      return _$ItemDetailToJson(this);
    }

    @override
  String toString() {
    return "========================\nname : $name\n formatted Address: $formatted_address\n international_phone_number: $international_phone_number"
        "Photos ${photos.toString()} + Location ${geometry.location.toString()}\nRating : $rating\nReviews : ${reviews.toString()}";
  }

}