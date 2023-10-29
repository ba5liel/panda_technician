
import 'package:flutter/material.dart';
class FeeTag extends StatelessWidget {
   FeeTag({super.key, required this.title,required this.hintTexts, required this.callBackHandler});
  String title;
  Function callBackHandler;
  String hintTexts;
  @override
  Widget build(BuildContext context) {
    return         Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          margin:const EdgeInsets.fromLTRB(0, 15, 0, 0),
          decoration: BoxDecoration(color:Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3,
              offset: Offset.fromDirection(2.7)
            )
          ]
          ),
          child: Row(children: <Widget>[
            


            Container(alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.60,
              height: 70,
              margin: const EdgeInsets.fromLTRB(15, 20, 0, 0),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(children: <Widget>[
                Text( title, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[400])),
               


              ]),
            ),
            Icon(Icons.edit)
,
            Container(
              width: 80,
              height: 50,
              decoration: const BoxDecoration(color: Colors.transparent),
              child:   TextField(
                keyboardType: TextInputType.number,
                onChanged: ((value){
                  print("AA: "+ value);
                callBackHandler(value);
                }),
                textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey[800]),
              decoration:  InputDecoration(
                
                counterText: '',
                border: InputBorder.none,
                hintText: hintTexts,
                prefixIcon: const Icon(Icons.attach_money),
                prefixIconConstraints: const BoxConstraints(maxWidth: 40)
              ),
            )
            ),
          

          ],)
        );
  }
}