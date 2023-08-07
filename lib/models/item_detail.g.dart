// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetail _$ItemDetailFromJson(Map<String, dynamic> json) {
  return ItemDetail(
    json['name'] as String,
    json['place_id'] as String,
    json['formatted_address'] as String, json.containsKey('international_phone_number')?
    json['international_phone_number'] as String : "Not provided!",
    json.containsKey("photos") ?
    (json['photos'] as List<dynamic>)
        .map((e) => Photo.fromJson(e as Map<String, dynamic>))
        .toList(): [Photo("")], json.containsKey("rating") ?
    (json['rating'] as num).toDouble() : 3.5,
    json.containsKey("reviews") ?
    (json['reviews'] as List<dynamic>)
        .map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList() : [Review.initial()],
    Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ItemDetailToJson(ItemDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'formatted_address': instance.formatted_address,
      'international_phone_number': instance.international_phone_number,
      'photos': instance.photos.map((e) => e.toJson()).toList(),
      'geometry': instance.geometry.toJson(),
      'place_id': instance.place_id,
      'rating': instance.rating,
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
    };
