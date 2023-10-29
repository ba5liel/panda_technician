import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:sms_autofill/sms_autofill.dart';

class SMSVerificationPage extends StatefulWidget {
  @override
  _SMSVerificationPageState createState() => _SMSVerificationPageState();
}

class _SMSVerificationPageState extends State<SMSVerificationPage> {
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    ddd();
  }

  ddd() async {
    // await SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Verification'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            Text('Enter verification code:'),
            SizedBox(height: 8),
            //  PinFieldAutoFill(
            //       currentCode: "",
            //       onCodeSubmitted: ((value){}),
            //       onCodeChanged:((value){}),
            //       codeLength: 4
            //     ),
            SizedBox(height: 16),
            TextButton(
              child: Text('Verify'),
              onPressed: () {
                // Perform verification using the code
              },
            )
          ],
        ),
      ),
    );
  }
}
