import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenericBox extends StatelessWidget {
  final Color? fillColor;
  final Color? borderColor;
  final GestureTapCallback? onTap;
  final Widget child;

  const GenericBox({
    Key? key,
    this.fillColor,
    this.borderColor,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? fillColor ?? Colors.transparent),
          color: fillColor,
        ),
        child: child,
      ),
    );
  }
}