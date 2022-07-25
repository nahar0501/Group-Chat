// To parse this JSON data, do
//
//     final InvoiceData = InvoiceDataFromJson(jsonString);


import 'dart:convert';
class InvoiceModel
{
  String id;
  InvoiceData invoiceData;
  InvoiceModel({required this.id,required this.invoiceData});
}
class InvoiceData {
  InvoiceData({
    required this.invoiceno,
    required this.senderName,
    required this.recieverName,
  });

  int invoiceno;
  String senderName;
  String recieverName;

  factory InvoiceData.fromRawJson(String str) => InvoiceData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
    invoiceno: json["invoiceno"],
    senderName: json["senderName"],
    recieverName: json["recieverName"],
  );

  Map<String, dynamic> toJson() => {
    "invoiceno": invoiceno,
    "senderName": senderName,
    "recieverName": recieverName,
  };
}
