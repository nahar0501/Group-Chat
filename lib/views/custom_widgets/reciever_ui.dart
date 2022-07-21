import 'package:flutter/material.dart';

class RecieverUI extends StatelessWidget {
  String ph;
  String msg;
  RecieverUI({required this.ph,required  this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        margin: const EdgeInsets.only(
          left: 10,
          right: 50,
          top: 5,
          bottom: 5,
        ),
        decoration:  BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 3,
                spreadRadius: 1,
              )
            ],
            borderRadius:const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ph,style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(msg,style: TextStyle(color: Colors.black),),
          ],
        ) ,
      ),
    );
  }
}
