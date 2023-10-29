import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.buttonTitle,
      required this.callBackFunction,
      this.width = 340,
      this.buttonColor = const Color.fromRGBO(51, 188, 132, 1),
      this.textColor = Colors.white});

  String buttonTitle;
  Function callBackFunction;
  double width = 340;
  Color buttonColor = Color.fromRGBO(51, 188, 132, 1);
  Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width, //
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: buttonColor),
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: TextButton(
          onPressed: () async {
            callBackFunction();
          },
          child: Text(
            buttonTitle,
            style: TextStyle(fontSize: 14, color: textColor),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
