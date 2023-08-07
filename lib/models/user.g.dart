// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['userId'] as String,
    json['name'] as String,
    json['email'] as String,
    json['phone'] as String,
    (json['langs'] as List<dynamic>).map((e) => e as String).toList(),
    json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'langs': instance.langs,
      'imageUrl': instance.imageUrl,
    };
