



import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmptyScreen extends StatelessWidget {
   EmptyScreen({super.key, required this.title, required this.subTitle });
  String title;
  String subTitle;

  @override
  Widget build(BuildContext context) {
    return    EmptyWidget(
   image:"assets/HeaderLogo.png",
   title: title,
   subTitle: subTitle,
   titleTextStyle: TextStyle(
     fontSize: 22,
     color: Color(0xff9da9c7),
     fontWeight: FontWeight.w500,
   ),
   subtitleTextStyle: TextStyle(
     fontSize: 14,
     color: Color(0xffabb8d6),
   ),
 );
  }
}