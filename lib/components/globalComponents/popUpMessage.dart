import 'package:flutter/material.dart';

void showPurchaseDialog(BuildContext context, String title, String message,
    {bool isApiCall: true, bool isOtp: false, isVerify: false
    }) {
  showDialog(
      context: context,
      barrierDismissible:
          false, // disables popup to close if tapped outside popup (need a button to close)
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Text(message),
          //buttons?
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                if (isApiCall) {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  FocusScope.of(context).unfocus();
                  if(isOtp){
                    Navigator.pushNamed(context, "SingUp");
                  }
                  if(isVerify){
                    Navigator.pushNamed(context, "Verification");
                  }

                } else {
                  Navigator.of(context).pop();
                  FocusScope.of(context).unfocus();
 if(isOtp){
                    Navigator.pushNamed(context, "SingUp");
                  }
                }
              }, //closes popup
            ),
          ],
        );
      });
}

 bool test(){
return true;
}
