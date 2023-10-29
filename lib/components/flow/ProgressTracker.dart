

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
class ProgressTracker extends StatefulWidget {
   ProgressTracker({super.key, required this.statusIndex, required this.arrived,
   required this.finshed,
   required this.requestId,
   required this.OnMyWay
      });
  int statusIndex;
  Function arrived;
  Function OnMyWay;
  Function finshed;
  String requestId;
  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  @override
  Widget build(BuildContext context) {
    return Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: 120,
            child:
           
                Stack(
                fit: StackFit.expand,
                  children: <Widget>[
Positioned(
  top: 40,
  left: MediaQuery.of(context).size.width * 0.2,
  child: 
Container(
  alignment: Alignment.center,
  width: MediaQuery.of(context).size.width*0.65,
height: 3,
decoration: BoxDecoration(color: Colors.green[200]),
)),

              Positioned(
              
                left: MediaQuery.of(context).size.width * 0.05,
                child: 
                 Column(children: <Widget>[
    Container(
                height: widget.statusIndex == 0? 65 : 60,
                width:widget.statusIndex == 0? 65 : 60,
                margin:const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: widget.statusIndex == 0? Colors.pink[300] : Colors.pink[50] ),
                child: TextButton(onPressed: (){}, child:const Icon(Icons.check,color: Colors.white,)) ,

             ),
           const  Text(style: TextStyle(fontSize:10), "Job Accepted")
                ],),
              )
,
    

             
         
              Positioned(
              
                left: MediaQuery.of(context).size.width * 0.30,
                child: 


                Column(children: <Widget>[
    Container(
                height: widget.statusIndex == 1? 65 : 60,
                width:widget.statusIndex == 1? 65 : 60,
                margin:const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: widget.statusIndex == 1? Colors.blue[300] : Colors.blue[50]),
                child: TextButton(onPressed: (){

            //       ApiHandler().updateJobStatus(widget.requestId, context, "ON_MY_WAY",((){
            // widget.OnMyWay();
            //       }) );

                }, child:Icon(Icons.location_on_outlined,color: Colors.green[600],)) ,

             ),
           const  Text(style: TextStyle(fontSize:10), "On My Way")
                ],),
              ),

               Positioned(
              
                left: MediaQuery.of(context).size.width * 0.55,
                child: 
                         Column(children: <Widget>[
    Container(
                height: widget.statusIndex == 2? 65 : 60,
                width:widget.statusIndex == 2? 65 : 60,
                margin:const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: widget.statusIndex == 2? Colors.green[400] : Colors.green[50]),
                child: TextButton(onPressed: (){
//                   ApiHandler().updateJobStatus(widget.requestId, context, "ARRIVED", ((){ 
// widget.arrived();
//                   }) );
  widget.arrived();
               

                }, child:Icon(Icons.miscellaneous_services_sharp,color: Colors.green[600],)) ,

             ),
            const Text(style: TextStyle(fontSize:10), "Arrived")
                ],),
              
               ),
                   Positioned(
              
                left: MediaQuery.of(context).size.width * 0.80,
                child: 
                         Column(children: <Widget>[
    Container(
                height: widget.statusIndex == 3? 65 : 60,
                width:widget.statusIndex == 3? 65 : 60,
                margin:const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: widget.statusIndex == 2? Colors.green[100] : Colors.green[50]),
                child: TextButton(onPressed: (){
  //                 if(widget.statusIndex == 5){
  // //  ApiHandler().updateJobStatus(widget.requestId, context, "COMPLETED",((){
  // //               widget.finshed();
  // //                 }) );

  //               }else{
  //                   DialogBox(context, "Message", "You have to create Estimation before you complete the Job", "Close", "Ok", ((){
  //                     Navigator.pop(context);
  //                   }), ((){

  //                     Navigator.pop(context);

  //                   }));
  //               }

                }, child:Icon(Icons.done_all ,color: Colors.green[600],)) ,

             ),
            const Text(style: TextStyle(fontSize:10), "Completed")
                ],),
              
               )
               ],
                ),

          );
  }
}