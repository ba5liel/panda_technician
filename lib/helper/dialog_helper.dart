import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showGetXLoading() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        // The background color
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The loading indicator
              Image.asset(
                "assets/Loading.gif",
                height: 100.0,
                width: 100.0,
              ),
              SizedBox(
                height: 15,
              ),
              // Some text
              Text('Loading...')
            ],
          ),
        ),
      ),
    );
  }

  static void showGetXDialogBox(
      String title,
      String message,
      String negativeButton,
      String positiveButton,
      Function negativeCallBack,
      Function positiveCallBack) {
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          title: Text(
            title,
          ),
          content: Text(message),
          //buttons?
          actions: <Widget>[
            TextButton(
              child: Text(negativeButton),
              onPressed: () {
                negativeCallBack();
              }, //closes popup
            ),
            TextButton(
              child: Text(positiveButton),
              onPressed: () {
                positiveCallBack();
              }, //closes popup
            )
          ],
        ));
  }

  static void showGetXError(String msg) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        // The background color
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Error'), Text(msg)],
          ),
        ),
      ),
    );
  }

  static void hideGetXLoading() {
    if (Get.isDialogOpen != null) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }

  static void showErrorSnackbar(String? message) {
    String errorMessage = message ??= "There was an error";
    Get.snackbar(
      "Error",
      errorMessage,
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
