// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// ignore: use_function_type_syntax_for_parameters

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({required this.resumeCallBack,required this.detachedCallBack});

  Function  resumeCallBack;
  Function  detachedCallBack;

//  @override
//  Future<bool> didPopRoute()

//  @override
//  void didHaveMemoryPressure()

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        await detachedCallBack();
        break;
      case AppLifecycleState.detached:
        await detachedCallBack();
        break;
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }

    if(AppLifecycleState.inactive == state){
        await detachedCallBack();
    print("WWWWWWWW");
    }
  print('''
=============================================================
               $state
=============================================================
''');
  }

//  @override
//  void didChangeLocale(Locale locale)

//  @override
//  void didChangeTextScaleFactor()

//  @override
//  void didChangeMetrics();

//  @override
//  Future<bool> didPushRoute(String route)
}