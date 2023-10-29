import 'package:flutter/material.dart';

void DisplayImage(BuildContext context, String uri) {

  showDialog(
      context: context,
      
     barrierDismissible: true,
            barrierLabel:
                "",
            barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return 
        GestureDetector(
          onTap: (){},
          child:
           Container(
          alignment: Alignment.center,
          child:  Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                  width: 300,
                  height: 400,
                  color: Colors.black,
                  child: Image.network(uri),
                )
          ],),
        ));
      });
}

