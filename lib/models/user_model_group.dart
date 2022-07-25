// To parse this JSON data, do
//
//     final UserModelGroup = UserModelGroupFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserModelGroup {
  UserModelGroup({
    required this.name,
    required this.email,
    required this.id,
    required this.isSelected
  }
      );

  String name;
  String email;
  String id;
  bool isSelected;

  factory UserModelGroup.fromRawJson(String str) => UserModelGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModelGroup.fromJson(Map<String, dynamic> json) => UserModelGroup(
    name: json["name"],
    email: json["email"],
    id: json["id"],
    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "id": id,
  };
}
