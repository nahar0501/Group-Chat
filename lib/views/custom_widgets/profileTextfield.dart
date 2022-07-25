import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTextField extends StatelessWidget {
  String title;
  var controller;
  ProfileTextField({required this.title,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: title,
          helperStyle:const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
    );
  }
}
