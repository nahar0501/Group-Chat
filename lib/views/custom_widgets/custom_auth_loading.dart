import 'package:flutter/material.dart';

class CustomAuthLoading extends StatelessWidget {
  String title;
   CustomAuthLoading({required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 150,
        child: Column(
          children:   [
            const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
