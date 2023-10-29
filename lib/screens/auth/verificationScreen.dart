// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/coutDown.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/screens/auth/LoginScreen.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:panda_technician/components/globalComponents/popUpMessage.dart';

class VerficationScreen extends StatefulWidget {
  const VerficationScreen({super.key});

  @override
  State<VerficationScreen> createState() => _VerficationScreenState();
}

class _VerficationScreenState extends State<VerficationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var newPassword = "";

  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController c = TextEditingController();
  TextEditingController d = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    newPassword = "";
    a.addListener(() {
  if(a.text.length == 4){
    b.text = b.text[1];
    c.text = c.text[2];
    d.text = d.text[3];

  }
});
    startTimer();
  }

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 2);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(minutes: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 5));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
            alignment: Alignment.center,
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 50),
            child: const Image(image: AssetImage("assets/HeaderLogo.png"))),
        const Text(
          "Please enter verification Code  ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: a,
                onChanged: (_) =>{ 
                  
                    if(a.text.length == 4){
                  
    b.text = a.text[1],
    c.text = a.text[2],
    d.text = a.text[3],
    a.text = a.text[0],


  },
                  FocusScope.of(context).nextFocus()},
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 4,
                style: const TextStyle(
                  fontSize: 16,
                ),
                cursorWidth: 1,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: b,
                  onChanged: (_) => FocusScope.of(context).nextFocus(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(fontSize: 16),
                  cursorWidth: 1,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                )),
            Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: c,
                  onChanged: (_) => FocusScope.of(context).nextFocus(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(fontSize: 16),
                  cursorWidth: 1,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                )),
            Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: d,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(fontSize: 16),
                  cursorWidth: 1,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        TextFiledCustom(
            updateCallback: ((value) {
              setState(() {
                newPassword = value;
              });
            }),
            preIcon: Icons.password,
            hintText: "Password",
            isPassword: true,
            isZipCode: false,
            isEmail: false,
            isNumber: false),
        const SizedBox(
          height: 15,
        ),
        TextFiledCustom(
            updateCallback: ((value) {
              setState(() {
                newPassword = value;
              });
            }),
            preIcon: Icons.password,
            hintText: "Confirm Password",
            isPassword: true,
            isZipCode: false,
            isEmail: false,
            isNumber: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 150, //
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(51, 188, 132, 1)),
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: TextButton(
                  onPressed: () async {
                    Loading(context);
                    final prefs = await SharedPreferences.getInstance();

if((a.text + b.text + c.text + d.text).toString() == "" || (a.text + b.text + c.text + d.text).toString().length != 4 ){
                    showPurchaseDialog(context,"Error Occured","Please Confirm Password");

}else{
  var response = await ApiHandler().resetPassword(
                        prefs.getString("userEmail").toString(),
                        newPassword,
                        a.text + b.text + c.text + d.text);

                    if (response) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    } else {
                      showPurchaseDialog(
                          context, "Error Occured", "Please Try Again Latter");
                    }
}
                  
                  },
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
            Container(
                width: 150, //
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[500]),
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: TextButton(
                  onPressed: () async {
                    Loading(context);
                    //  _fetchData(context);
                    final prefs = await SharedPreferences.getInstance();

                    var response = await ApiHandler().sendOtp(
                        prefs.getString("userEmail").toString(), context);

                    if (response) {
                      Navigator.pushNamed(context, "Verification");

                      showPurchaseDialog(
                          context, "Otp Sent", "Check Your Email",
                          isVerify: true, isApiCall: false);
                    } else {
                      showPurchaseDialog(context, "Error Occured",
                          "Wait for the count down to finsh");
                    }
                  },
                  child: const Text(
                    'Resend OTP',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const CountdownTimerDemo(),
        const SizedBox(
          height: 20,
        ),
      ]),
    ));
    ;
  }
}
