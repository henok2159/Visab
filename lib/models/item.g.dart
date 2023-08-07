// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['name'] as String,
    json['place_id'] as String, json.containsKey("rating") ?
  (json['rating'] as num).toDouble() : 3.5, json.containsKey("photos") ?
  (json['photos'] as List<dynamic>).map((e) => Photo.fromJson(e as Map<String, dynamic>).photo_reference).first : "",
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'place_id': instance.place_id,
      'photo': instance.photo,
      'rating': instance.rating,
    };
