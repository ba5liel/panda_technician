import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleTag extends StatelessWidget {
   SingleTag({super.key, required  this.ico, required this.title, required this.callBackHandler, this.err = false});
  String title;
  IconData ico;
  Function callBackHandler;
  bool err = false;

  @override
  Widget build(BuildContext context) {
    return      GestureDetector(
    onTap: () { 
  
                callBackHandler();
      

    },
    child:   Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          margin:EdgeInsets.fromLTRB(0, 25, 0, 0),
          decoration: BoxDecoration(color:Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: err? Colors.red: Colors.grey.shade600,
              blurRadius: 3,
              offset: Offset.fromDirection(2.7)
            )
          ]
          ),
          child: Row(children: <Widget>[
            

            Container(alignment: Alignment.center, 
                width:70,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                 
                  borderRadius: BorderRadius.circular(50)
                  ),
                  child: Icon(ico,size: 34,color: Colors.grey[800],)),
            Container(alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.50,
              height: 70,
              margin: EdgeInsets.fromLTRB(5, 20, 0, 0),
              decoration: BoxDecoration(color: Colors.transparent),
              child: Column(children: <Widget>[
                Text( title, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[800])),
               


              ]),
            ),
            // TextButton(
              
            //   onPressed: () { 
            //     callBackHandler();

            //    },
            // child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.blue[300])
            // )

          ],)
        ));
  }
}