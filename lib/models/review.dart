
import 'package:json_annotation/json_annotation.dart';
part 'review.g.dart';

@JsonSerializable()
class Review{
  String author_name;
  String profile_photo_url;
  double rating;
  String relative_time_description;
  String text;

  Review(this.author_name,this.profile_photo_url,this.rating,this.relative_time_description,this.text);

  factory Review.initial(){
    return Review("", "", -1, "", "");
  }

  factory Review.fromJson(Map<String, dynamic> json){
    print("Review.fromJson() called");

    return _$ReviewFromJson(json);
  }

  Map<String, dynamic> toJson(){
    return _$ReviewToJson(this);
  }

}