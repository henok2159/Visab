// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourGuide _$TourGuideFromJson(Map<String, dynamic> json) {
  return TourGuide(
    json['tourGuideId'] as String,
    json['name'] as String,
    json['imageUrl'] as String,
    json['description'] as String,
    (json['langs'] as List<dynamic>).map((e) => e as String).toList(),
    json['gender'] as String,
    json['city'] as String,
    json['email'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$TourGuideToJson(TourGuide instance) => <String, dynamic>{
      'tourGuideId': instance.tourGuideId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description' : instance.descritpion,
      'langs': instance.langs,
      'gender': instance.gender,
      'city': instance.city,
      'email': instance.email,
      'phone': instance.phone,
    };
