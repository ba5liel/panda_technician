// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StateProvider with ChangeNotifier {
  bool active = false;
  StateProvider({this.active = false});

  void changeTechnicianState(bool newState) {
    active = newState;
    notifyListeners();
  }
}
