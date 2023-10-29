// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:otp_autofill/otp_autofill.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/coutDown.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:panda_technician/components/globalComponents/popUpMessage.dart';
// import 'package:sms_receiver/sms_receiver.dart';
// import 'package:telephony/telephony.dart';

class SignUpVerification extends StatefulWidget {
  const SignUpVerification({super.key});

  @override
  State<SignUpVerification> createState() => _SignUpVerificationState();
}

// class SampleStrategy extends OTPStrategy {
//   @override
//   Future<String> listenForCode() {
//     return Future.delayed(
//       const Duration(seconds: 4),
//       () => 'Your code is 54321',
//     );
//   }
// }

class _SignUpVerificationState extends State<SignUpVerification>
    with SingleTickerProviderStateMixin {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  void onEnd() {}
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController c = TextEditingController();
  TextEditingController d = TextEditingController();
  // Telephony telephony = Telephony.instance;
  // late OTPTextEditController controller;
  final scaffoldKey = GlobalKey();
  // ignore: unnecessary_new

  late AnimationController _controller;
  bool updater = false;
  @override
  void initState() {
    super.initState();
    // SmsReceiver receiver = SmsReceiver((value) {
    //   print("REEEEEEEEEEE: " + value.toString());
    // });
    // receiver
    //     .startListening()
    //     .then((value) => print("eeeeeeeeeeee: " + value.toString()));
    // receiver.onSmsReceived("sdf");
    // receiver.startListening().then((value) => () {
    //       print("MEESAGE: " + value.toString());
    //     });

    // OTPInteractor()
    //     .getAppSignature()
    //     .then((value) => print('signature - $value'));
    // controller = OTPTextEditController(
    //   codeLength: 4,
    //   onCodeReceive: (code) => print('Your Application receive code - $code'),
    // )..startListenUserConsent(
    //     (code) {
    //       final exp = RegExp(r'(\d{4})');
    //       return exp.stringMatch(code ?? '') ?? '';
    //     },
    //     strategies: [
    //       SampleStrategy(),
    //     ],
    //   );

    // if (Platform.isAndroid) {
    //   telephony.listenIncomingSms(
    //     onNewMessage: (SmsMessage message) {
    //       String sms = message.body.toString();

    //       String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');

    //       setState(() {
    //         updater = !updater;
    //         a.text = otpcode[0];
    //         b.text = otpcode[1];
    //         c.text = otpcode[2];
    //         d.text = otpcode[3];
    //       });
    //     },
    //     listenInBackground: false,
    //   );
    // }
    _controller = AnimationController(vsync: this);
    getSms();
    a.addListener(() {
      if (a.text.length == 4) {
        b.text = b.text[1];
        c.text = c.text[2];
        d.text = d.text[3];
      }
    });
  }

  getSms() async {
    //  var resp = await SmsAutoFill().listenForCode();
    // var resp = await SmsAutoFill().listenForCode;

    //  print("CODE CODE: "+ resp.toString());
  }

  void _fetchData(BuildContext context) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
  }

  var requestCode = "";

  updateRquestCode(String a, String b, String c, String d) {
    setState(() {
      requestCode = a + b + c + d;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 300,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 50),
                child: const Image(image: AssetImage("assets/HeaderLogo.png"))),
            const Text(
              "Please enter verification Code",
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
                      autofillHints: const <String>[AutofillHints.oneTimeCode],
                      controller: a,
                      onChanged: (_) => {
                        print("ADF: " + a.text.length.toString()),
                        if (a.text.length == 4)
                          {
                            print("ADF:"),
                            b.text = a.text[1],
                            c.text = a.text[2],
                            d.text = a.text[3],
                            a.text = a.text[0],
                          },
                        FocusScope.of(context).nextFocus()
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 5,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(51, 188, 132, 1)),
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: TextButton(
                      onPressed: () async {
                        Loading(context);

                        final prefs = await SharedPreferences.getInstance();
                        if ((a.text + b.text + c.text + d.text).toString() ==
                                "" ||
                            (a.text + b.text + c.text + d.text)
                                    .toString()
                                    .length !=
                                4) {
                          showPurchaseDialog(context, "Error Occured",
                              "Please Confirm Password");
                        } else {
                          var response = await ApiHandler().verifyAccount(
                              prefs.getString("userEmail").toString(),
                              a.text + b.text + c.text + d.text);
                          if (response) {
                            Navigator.pushNamed(context, "Home");
                          } else {
                            showPurchaseDialog(
                                context, "Error Occured", "Wrong OTP");
                          }
                        }
                      },
                      child: const Text(
                        'Verify',
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
                        final prefs = await SharedPreferences.getInstance();

                        var response = await ApiHandler().sendOtp(
                            prefs.getString("userEmail").toString(), context);

                        if (response) {
                          Navigator.pushNamed(context, "Signup");

                          showPurchaseDialog(
                              context, "Otp Sent", "Check Your SMS",
                              isOtp: true, isApiCall: false);
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
            SizedBox(
              height: 20,
            ),
            CountdownTimerDemo()
          ]),
        )));
    ;
  }
}
