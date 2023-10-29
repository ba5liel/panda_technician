

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panda_technician/components/flow/ratingCard.dart';
import 'package:panda_technician/screens/createOffer.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptedJob extends StatefulWidget {
  const AcceptedJob({super.key});

  @override
  State<AcceptedJob> createState() => _AcceptedJobState();
}

class _AcceptedJobState extends State<AcceptedJob> {
int statusIndex = 0;
bool createOffer = false;
void updateStatus(){
   

    setState(() {
      statusIndex++;
    });
}



static void navigateTo(double lat, double lng) async {
   var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
  //  if (await canLaunch(uri.toString())) {
      await launchUrl(uri);
  //  } else {
  //     throw 'Could not launch ${uri.toString()}';
  //  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child:SafeArea(
           top:false,
      bottom: true,
           child: Column(
        children: <Widget>[
           Container(
              alignment: Alignment.center,
              height: 20,
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              decoration: const BoxDecoration(color:Colors.transparent),
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const <Widget>[
                Text("Diagnostic", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              
                Text("ASAP", style: TextStyle(fontSize: 14, color: Colors.grey),textAlign: TextAlign.right)

              ],  )
             ,),
               Container(
              alignment: Alignment.centerLeft,
              height: 20,
              decoration: const BoxDecoration(color:Colors.transparent),
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Container(
                  child: Row(children: [
  Icon(Icons.circle,color: statusIndex == 0? Colors.pink[100] : statusIndex == 1? Colors.blue[100] : statusIndex == 2? Colors.green[100] : Colors.grey[100] ,size:15),
                Text(statusIndex == 0? "Open Job" : statusIndex == 1? "On My Way" : statusIndex == 2? "Service UnderWay" : "", style: const TextStyle(fontSize: 13,color: Colors.grey),textAlign: TextAlign.left,),
                  ]),
                )
              ,
              
                const Text("Today", style: TextStyle(fontSize: 14, color: Colors.grey),textAlign: TextAlign.right)

              ],  )
             ,),
             
    
            // Text("Jobs are available on a first-come first-serve basis. Act quickly to secure this job!", textAlign: TextAlign.center, style: TextStyle(height: 1.5, fontSize: 14,color: Colors.grey[600]))

           

         (createOffer)?
       Container(  
              width:340,//
              height:50,
              
              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(10), color:const Color.fromRGBO(51, 188, 132, 1)),
              margin:const EdgeInsets.fromLTRB(0, 10, 0, 0),  
              child:TextButton(
                
         onPressed: () {
  //           Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => const CreateOffer()),
  // );
          },
          child:const Text('Create Offer', style: TextStyle(fontSize: 14,color: Colors.white), textAlign: TextAlign.center,),
)  
            )
         :
         Container(
           alignment: Alignment.center,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: Colors.white,
             boxShadow:[ BoxShadow(
             blurRadius: 2,
             color: Colors.grey.shade400,
             offset: Offset.fromDirection(1.3)
           )]),
           width: MediaQuery.of(context).size.width * 0.95,
           height: 500,
           child: Column(
              children: <Widget>[
                
                
                Container(
                  margin: const EdgeInsets.all(10), 
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Row( children: <Widget>[
              const Image(height: 60,width:60, image: AssetImage("assets/car.png"),)
              , Container(alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(children: <Widget>[

              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Mobile Mechanic", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                 )
                  ,
                   Align(
                  alignment: Alignment.topLeft,
                  child:  Text("Diagnostic Service", style: TextStyle(fontSize: 14, color: Colors.grey[400])),
                   )
                 

              ],)),
                  Text("\$45.00", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.green[200])),
             

          ],)
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: const Text("Where",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.left, ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color:Colors.white, border: Border.all(color: Colors.grey.shade400, width: 1),borderRadius: BorderRadius.circular(10), boxShadow: [

            BoxShadow(color: Colors.grey.shade400,offset: Offset.fromDirection(2.1), blurRadius: 1)

          ]),
          alignment: Alignment.center,
          child:
          TextButton(
                
         onPressed: () {
              navigateTo(2.5, 3.4);

          },
          child:Row(children: [
            
            Icon(Icons.location_on_outlined,color: Colors.grey[400]),
            Text("2021 India River Rd, Austin Tx", style: TextStyle(color: Colors.grey[400]) )
          ]),
)  
           ,
        ),
          Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.fromLTRB(20, 10, 10,10),
          child: const Text("Vechicle",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.left, ),
        ),
         Container(
                  margin: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[

                Container(
 width: 50,
 height:50,
  alignment: Alignment.center,
  margin:  const EdgeInsets.fromLTRB(5, 0, 5, 0),
  decoration: const BoxDecoration(
    image: DecorationImage(
        fit: BoxFit.cover, image: NetworkImage("https://stimg.cardekho.com/images/carexteriorimages/630x420/MG/Hector/8259/1632911780671/front-left-side-47.jpg?impolicy=resize&imwidth=480")),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    color: Colors.transparent,
  ),
),
             
             
               Container(alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child:   Text("Red Baby", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.start ,)
                )
                ,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("2008 Blue BMW 3 Series", style: TextStyle(fontSize: 14, color: Colors.grey[400]),textAlign: TextAlign.start,),
                ),
                  

              ],)),
                  Container(
                    width:20,
                    height:20,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(2)),
                  )
             

          ],)
        ),
     const   Align(

          alignment: Alignment.topLeft,
          child: 
          Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text("Additional Detail",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
           
        ),
       const   Align(

          alignment: Alignment.topLeft,
          child: 
          Padding(padding: EdgeInsets.all(10),
          child: Text("Vechicle won't start. it's making strange noises when i try too start it. There is some fluid that's been leaking out of the bottom for a long time. Please help!",style: TextStyle(height:1.5, fontSize: 14)),
          )
           
        ),
        Container(alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        height: 100,
        child: ListView(
	scrollDirection: Axis.horizontal,
  children: <Widget>[
           
                Container(
 width: 100,
 height:80,
  alignment: Alignment.center,
  margin:  const EdgeInsets.fromLTRB(5, 0, 5, 0),
  decoration: const BoxDecoration(
    image: DecorationImage(
        fit: BoxFit.cover, image: NetworkImage("https://media.istockphoto.com/id/186033189/photo/modern-car-interior.jpg?s=612x612&w=0&k=20&c=L0boHdLHPdpdut5wfcjsj1UmeTmXtzKxVWWNIRaI7d8=")),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    color: Colors.transparent,
  ),
),
        
                Container(
 width: 100,
 height:80,
  alignment: Alignment.center,
  margin:  const EdgeInsets.fromLTRB(5, 0, 5, 0),
  decoration: const BoxDecoration(
    image: DecorationImage(
        fit: BoxFit.cover, image: NetworkImage("https://media.istockphoto.com/id/1212042426/photo/car-interior-part-of-front-seats-close.jpg?b=1&s=170667a&w=0&k=20&c=PJGLxUtSzyRKgO1wj6f02QUEDv6Hc_i3q-1o9Jslh1g=")),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    color: Colors.transparent,
  ),
),
             
        ]),
        )
        

        
        ]),
           
         ),
  Container(  
              width:MediaQuery.of(context).size.width * 0.95,//
              height:50,
              decoration:  BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade700),
              margin:const EdgeInsets.all(25),  
              child:TextButton(
                
         onPressed: () {
   updateStatus();
          },
          child: Text(statusIndex == 0? "Accept Job" : statusIndex == 1? "RESCHEDULE" : statusIndex == 2? "SERVICE FINSHED" :  "", style: const TextStyle(fontSize: 14,color: Colors.white), textAlign: TextAlign.center,),
)  
            ),


        ],

      )
      )),
    );
  }
}