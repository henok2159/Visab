
import 'package:json_annotation/json_annotation.dart';
part 'photo.g.dart';
@JsonSerializable()
class Photo {
  String photo_reference;

  Photo(this.photo_reference);

  factory Photo.fromJson(Map<String, dynamic> json){
    return _$PhotoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PhotoToJson(this);
  }
}