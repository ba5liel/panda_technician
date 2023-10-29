import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({super.key});
  @override
  State<CountdownTimerDemo> createState() => _CountdownTimerDemoState();
}



class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 2);
  @override
  void initState() {
    super.initState();
    startTimer();
  }
 
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 5));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
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
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
  

    final minutes = strDigits(myDuration.inMinutes.remainder(2));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return  Container(
        width:300,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
         
            Text(
              'Resend OTP in $minutes:$seconds',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),
          
         
          ],
        ),
      
    );
  }
}