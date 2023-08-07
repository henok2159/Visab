import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userId;
  String name;
  String email;
  String phone;
  List<String> langs;
  String imageUrl;

  User(this.userId, this.name, this.email, this.phone, this.langs,
      [this.imageUrl = "https://firebasestorage.googleapis.com/v0/b/visab-practice.appspot.com/o/cities_profiles%2Fimage_picker3029611924326695478.jpg?alt=media&token=994cb4f4-e376-490d-a15e-d23172fa8e50"]);
  factory User.initial(){
    return User("jakslfalsdkfjasld;falskfja;sdf","User Name","user@gmail.com","+251900123453",["_"],);
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot snapShot) {
    return User(
        snapShot.id,
        snapShot['name'],
        snapShot['email'],
        snapShot['phone'],
        (snapShot['langs'] as List<dynamic>).map((e) => e as String).toList(),
        snapShot['imageUrl'],
       );
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
