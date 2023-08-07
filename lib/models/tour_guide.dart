import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tour_guide.g.dart';

@JsonSerializable()
class TourGuide{
  String tourGuideId;
  String descritpion;
  String name;
  String imageUrl;
  List<String> langs;
  String gender;
  String city;
  String email;
  String phone;

  TourGuide(this.tourGuideId,this.name,this.imageUrl,this.descritpion, this.langs, this.gender, this.city,this.email,this.phone);

  factory TourGuide.fromJson(Map<String, dynamic> json){
    return _$TourGuideFromJson(json);
  }

  factory TourGuide.fromDocumentSnapshot(DocumentSnapshot snapshot){
    return TourGuide(
      snapshot.id,
      snapshot['name'] as String,
      snapshot['imageUrl'] as String,
      snapshot['description'] as String,
      (snapshot['langs'] as List<dynamic>).map((e) => e as String).toList(),
      snapshot['gender'] as String,
      snapshot['city'] as String,
      snapshot['email'] as String,
      snapshot['phone'] as String,
    );
  }

  Map<String, dynamic> toJson(){
    return _$TourGuideToJson(this);
  }

}