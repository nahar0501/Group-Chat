// To parse this JSON data, do
//
//     final MsgBody = MsgBodyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
class MsgModel
{
  String msgid;
  MsgBody msgBody;
  MsgModel({required this.msgid,required this.msgBody});
}
class MsgBody {
  MsgBody({
    required this.msg,
    required this.sender,
    required this.ph,
    required this.time,
  });

  String msg;
  String sender;
  String ph;
  int time;

  factory MsgBody.fromRawJson(String str) => MsgBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MsgBody.fromJson(Map<String, dynamic> json) => MsgBody(
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
