import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ToggleTag extends StatelessWidget {
   ToggleTag({super.key, required  this.isToggleOn, required this.title, required this.callBackHandler});
  String title;
  bool isToggleOn;
  Function callBackHandler;

  @override
  Widget build(BuildContext context) {
    return         Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          margin:const EdgeInsets.fromLTRB(0, 25, 0, 0),
          decoration: BoxDecoration(color:Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              blurRadius: 3,
              offset: Offset.fromDirection(2.7)
            )
          ]
          ),
          child: Row(children: <Widget>[
            


            Container(alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.70,
              height: 70,
              margin: const EdgeInsets.fromLTRB(15, 20, 0, 0),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(children: <Widget>[
                Text( title, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[400])),
               


              ]),
            ),
            TextButton(
              
              onPressed: () { 
                callBackHandler();

               },
            child: Icon(isToggleOn? Icons.toggle_on : Icons.toggle_off , color: isToggleOn? Colors.green[400]: Colors.grey[300], size: 50,))

          ],)
        );
  }
}