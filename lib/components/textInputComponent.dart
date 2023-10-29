

import 'package:flutter/material.dart';

class TextInputComponent extends StatefulWidget {
   TextInputComponent({super.key,required this.hintText});
  String hintText;

  @override
  State<TextInputComponent> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
    width:340,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 2,
        offset:const Offset(0, 2), 
      ),
    ],
    ),
    child: const  TextField(
          style: TextStyle(fontSize: 16),
          cursorWidth: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Password",
        prefixIcon: Icon(Icons.lock,color: Colors.grey,),
      ),
    )
  );
  }
}