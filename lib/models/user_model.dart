// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    required this.rated,
    required this.name,
    required this.pic,
    required this.id,
    required this.totalpoints,
    required this.email,
  });

  num rated;
  String name;
  String pic;
  String id;
  num totalpoints;
  String email;

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    rated: json["rated"],
    name: json["name"],
    pic: json["pic"],
    id: json["id"],
    totalpoints: json["totalpoints"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "rated": rated,
    "name": name,
    "pic": pic,
    "id": id,
    "totalpoints": totalpoints,
    "email": email,
  };
}
