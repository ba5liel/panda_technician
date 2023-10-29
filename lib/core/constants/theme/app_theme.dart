import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {

  static final ThemeData appTheme = ThemeData(
    primaryColor: const Color(0xffF27F26),
    backgroundColor: const Color(0xffFF844F),
    dividerColor:  Colors.black,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 36.sp,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white
    ),
      labelMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color.fromRGBO(0, 0, 0, 0.6),
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      // Add more text styles as needed
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
    ),


  );

}
