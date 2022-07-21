// To parse this JSON data, do
//
//     final msgModel = msgModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class MsgModel {
  MsgModel({
    required this.msg,
    required this.sender,
    required this.ph,
    required this.time,
  });

  String msg;
  String sender;
  String ph;
  int time;

  factory MsgModel.fromRawJson(String str) => MsgModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MsgModel.fromJson(Map<String, dynamic> json) => MsgModel(
    msg: json["msg"],
    sender: json["sender"],
    ph: json["ph"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "sender": sender,
    "ph": ph,
    "time": time,
  };
}
