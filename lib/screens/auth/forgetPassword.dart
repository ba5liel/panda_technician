// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:panda_technician/screens/auth/verificationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:panda_technician/components/globalComponents/popUpMessage.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  var email = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    email = "";
  }

  @override
  Widget build(BuildContext context) {
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
          "Reset Password",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFiledCustom(
            updateCallback: ((value) {
              email = value;
            }),
            preIcon: Icons.email,
            hintText: "Enter Your Email",
            isPassword: false,
            isZipCode: false,
            isEmail: false,
            isNumber: false),
        Container(
            width: 340, //
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(51, 188, 132, 1)),
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: TextButton(
              onPressed: () async {
                Loading(context);
                final prefs = await SharedPreferences.getInstance();
                prefs.setString("userEmail", email);
                var response = await ApiHandler().sendOtp(email,context);

                if (response) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerficationScreen()),
                  );
                } else {
                  showPurchaseDialog(context, "Error Occur",
                      "User Not Found");
                }
              },
              child: const Text(
                'Forget Password',
                style: TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )),
      ])),
    );
  }
}
