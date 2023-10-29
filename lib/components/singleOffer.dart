

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class SingleOffer extends StatefulWidget {
   SingleOffer({super.key,required this.removeOffer});

Function removeOffer;
  @override
  State<SingleOffer> createState() => _SingleOfferState();
}

class _SingleOfferState extends State<SingleOffer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *0.9,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: 
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
    width:MediaQuery.of(context).size.width *0.56,
    height: 50,
      // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
    
    decoration: BoxDecoration(
      color: Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 2,
        offset:const Offset(0, 3), 
      ),
    ],
    ),
    child: const  TextField(
          style: TextStyle(fontSize: 16),
          cursorWidth: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Line Item",
      ),
    )
  ),
    Container(
    width:MediaQuery.of(context).size.width * 0.2,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 2,
        offset:const Offset(0, 3), 
      ),
    ],
    ),
    child: const  TextField(
          style: TextStyle(fontSize: 16),
          cursorWidth: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "\$0.00",
      ),
    )
  ),
  Container(
    width:40,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 2,
        offset:const Offset(0, 3), 
      ),
    ],
    ),
    child: TextButton(onPressed: () { 
      widget.removeOffer();
     },
    child: Icon(Icons.restore_from_trash,color: Colors.grey[400],),)
  )

    ],));
  }
}