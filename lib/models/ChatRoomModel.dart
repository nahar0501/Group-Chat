// To parse this JSON data, do
//
//     final ChatRoomData = ChatRoomDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ChatRoomModel
{
  String id;
  ChatRoomData data;
  ChatRoomModel({required this.id,required this.data});
}

class ChatRoomData {
  ChatRoomData({
    required this.creator,
    required this.members,
    required this.name,
  });

  String creator;
  List<String> members;
  String name;

  factory ChatRoomData.fromRawJson(String str) => ChatRoomData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatRoomData.fromJson(Map<String, dynamic> json) => ChatRoomData(
    creator: json["creator"],
    members: List<String>.from(json["members"].map((x) => x)),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator,
    "members": List<dynamic>.from(members.map((x) => x)),
    "name": name,
  };
}
