import 'package:flutter/material.dart';
class SenderUI extends StatelessWidget {
  String msg;
   SenderUI({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        margin: const EdgeInsets.only(
          left: 50,
          right: 10,
          top: 5,
          bottom: 5,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.shade300,
                Colors.purple.shade400,
                Colors.purple.shade600,
                Colors.purple.shade800
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
        ),
        child: Text(msg,style: TextStyle(color: Colors.white),) ,
      ),
    );
  }
}
