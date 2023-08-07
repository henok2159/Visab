// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    json['cityId'] as String,
    json['name'] as String,
    json['imageUrl'] as String,
    json['description'] as String,
    json['location'] as Location
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'cityId': instance.cityId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'location' : instance.location
    };
