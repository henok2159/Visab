// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    json['author_name'] as String,
    json['profile_photo_url'] as String,
    (json['rating'] as num).toDouble(),
    json['relative_time_description'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'author_name': instance.author_name,
      'profile_photo_url': instance.profile_photo_url,
      'rating': instance.rating,
      'relative_time_description': instance.relative_time_description,
      'text': instance.text,
    };
