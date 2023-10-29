import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:panda_technician/app/modules/job_offer/job_offer.controller.dart';
import 'package:panda_technician/app/service/app_auth_service.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

setFirstTimeLoad() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("FirstTimeLoad", true);
}

checkFirstTimeLoad(context, Function checked) async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getKeys().contains("FirstTimeLoad")) {
    Navigator.pushNamed(context, "Login");
  } else {
    checked();
  }
}

isAlreadyLoagedIn(context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getKeys().contains("apiToken")) {
    if (prefs.getString("apiToken") != "") {
      Navigator.pushNamed(context, "Home");
    }
  }
  Get.find<JobOfferController>().listenForRequestUpdate();
  return true;
}

logout(context) async {
  DialogBox(context, "Message", "Are you sure you want to logout", "No", "Yes",
      (() {
    Navigator.pop(context);
  }), (() async {
    final AppAuthService appAuthService = Get.find<AppAuthService>();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("apiToken");
    await appAuthService.logout();
// prefs.remove("tutorialSession");
    Navigator.pushNamed(context, "Login");
  }));
}


// logout(context) async{
  
// DialogBox(context, "Message", "Are you sure you want to logout", "No", "Yes", ((){
// Navigator.pop(context);
// }), (()async{
//   final prefs = await SharedPreferences.getInstance();
// prefs.remove("apiToken");
// Navigator.pushNamed(context, "Login");

// }));
// }
