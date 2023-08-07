
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'admin.g.dart';

@JsonSerializable()
class Admin{
  String id;
  String name;
  String email;

  Admin(this.id,this.name,this.email);

  Map<String, dynamic> toJson(){
    return _$AdminToJson(this);
  }
  factory Admin.fromJson(Map<String, dynamic> json){
    return _$AdminFromJson(json);
  }

  factory Admin.fromDocumentSnapshot(DocumentSnapshot snapshot){
    return Admin(
      snapshot.id,
      snapshot['name'] as String,
      snapshot['email'] as String,
    );
  }

  factory Admin.initial(){
    return Admin("_","_","_");

  }
}