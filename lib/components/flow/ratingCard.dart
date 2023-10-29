// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/models/requests/detailedRequestM.dart';
import 'package:panda_technician/services/servicePhone.dart';
import 'package:url_launcher/url_launcher.dart';


class RatingCard extends StatefulWidget {
   RatingCard({super.key, required this.profile, required this.vehicleImage });
   Info profile;
   String vehicleImage;
  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(color: Colors.transparent,
      border: Border(top: BorderSide(color: Colors.grey.shade400,width: 1))
      ),
      width: MediaQuery.of(context).size.width,
      height: 350,
      alignment:Alignment.center,
      child:  Column(children: <Widget>[

        Container( 
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 180,
          child:  
          Stack(
            alignment: Alignment.center,
            children : <Widget>[
      Positioned(
                top:35,
                width: 120,
                height: 140,
                child:      Container(
 
  alignment: Alignment.center,
  margin:  EdgeInsets.fromLTRB(0, 0, 0, 2),
  decoration:  BoxDecoration(
    image: DecorationImage(
        fit: BoxFit.cover, image: NetworkImage(widget.vehicleImage)),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    color: Colors.transparent,
  ),
))
    ,
              Positioned(
                
                top:10,
               left:MediaQuery.of(context).size.width*0.25,
child:   Container(alignment: Alignment.center, 
                width:60,
                height: 60,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade400,
                  width:2),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[200]),
                  child:    CircleAvatar(
                
                radius: 90,
                backgroundColor: Colors.grey.shade400,
                foregroundImage: NetworkImage(widget.profile.profilePicture),
             
              )),
              ),




            ]
          
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            alignment: Alignment.center,
              child:Text(widget.profile.fullName, style: TextStyle(color: Colors.black,))

          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,size: 20),
              Text("4.5")

            ],)
          ),
            Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width *0.4,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                 Container(
                height: 50,
                width:50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.green[100]),
                child: TextButton(onPressed: () async {  
                 callClient(widget.profile.phoneNumber);
                }, child:Icon(Icons.phone,color: Colors.green[600],)) ,

             ),
                 Container(
                height: 50,
                width:50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.green[100]),
                child: TextButton(onPressed: (){

                  sendSms(widget.profile.phoneNumber);
                }, child:Icon(Icons.message,color: Colors.green[600],)) ,

             )
            
              

            ],)
          ),
          
          ]),


      
    );
  }
}



//  Container(alignment: Alignment.center, 
//                 width:60,
//                 margin: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.green.shade400,
//                   width:2),
//                   borderRadius: BorderRadius.circular(50),
//                   color: Colors.green[200]),
//                   child:    CircleAvatar(
                
//                 radius: 100,
//                 backgroundColor: Colors.grey.shade400,
//                 foregroundImage: NetworkImage("https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_3.jpg"),
             
//               )),