// To parse this JSON data, do
//
//     final UserModelGroupGroup = UserModelGroupGroupFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserModelGroup {
  UserModelGroup({
    required this.rated,
    required this.name,
    required this.pic,
    required this.id,
    required this.totalpoints,
    required this.email,
    required this.isSelected
  });

  num rated;
  String name;
  bool isSelected;
  String pic;
  String id;
  num totalpoints;
  String email;

  factory UserModelGroup.fromRawJson(String str) => UserModelGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModelGroup.fromJson(Map<String, dynamic> json) => UserModelGroup(
    rated: json["rated"],
    name: json["name"],
    pic: json["pic"],
    id: json["id"],
    totalpoints: json["totalpoints"],
    email: json["email"],
    isSelected: false
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
