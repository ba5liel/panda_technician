import 'package:flutter/material.dart';

void DialogBox(BuildContext context, String title, String message,String negativeButton, String positiveButton,
 Function negativeCallBack , Function positiveCallBack) {

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
              child:  Text(negativeButton),
              onPressed: () {
              negativeCallBack();
                
              }, //closes popup
            ),
              TextButton(
              child:  Text(positiveButton),
              onPressed: () {
              positiveCallBack();
                
              }, //closes popup
            )
          ],
        );
      });
}

 bool test(){
return true;
}
