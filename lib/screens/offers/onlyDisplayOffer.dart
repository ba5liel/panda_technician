

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/customButton.dart';
import 'package:panda_technician/models/DetailedOffer.dart';
import 'package:panda_technician/models/offer.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/routes/route.dart';
import 'package:panda_technician/screens/offers/listOffers.dart';
import 'package:panda_technician/services/serviceDate.dart';
import 'package:intl/intl.dart';
import 'package:panda_technician/store/profileProvider.dart';
import 'package:provider/provider.dart';

class OnlyDisplayOffer extends StatelessWidget {
   OnlyDisplayOffer({super.key , required this.detailedOffer});

  DetailedOffer detailedOffer;


    double getTotal(){
  double total = 0;
  for(int x = 0 ; x < detailedOffer.offer.items.length;x++){
    total = total + (detailedOffer.offer.items[x].price == ""? 0 : double.parse(detailedOffer.offer.items[x].price)) ;
// total = total + detailedOffer.offer[x].price;
  }
 

 if(total > 0 && total > detailedOffer.offer.discount){
   total = total -detailedOffer.offer.discount;
 }else{
  
 }

  return double.parse(total.toStringAsFixed(2));
  // return total.roundToDouble();
}
  @override
  Widget build(BuildContext context) {
  ProfileModel profile  = Provider.of<ProfileProvider>(context,listen: true).profile as ProfileModel;

    return Scaffold(
           appBar: AppBar(foregroundColor: Colors.black, title: const Text("Estimations",style: TextStyle(color: Colors.black)), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: 
        Column(children: [

         Container(
            height: MediaQuery.of(context).size.height * 0.80,
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5
              )
            ]
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(child: Row(children: [
                 Text("Service Type: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("${detailedOffer.offer.title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
                 Container(child: Row(children: [
                 Text("Requester: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("${profile.fullName}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
                 
                Container(child: Row(children: [
                 Text("Id: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("${detailedOffer.offer.requestId.split("-")[4]}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
                Container(child: Row(children: [
                 Text("Date: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("${getUsDateFormat((detailedOffer.offer.createdAt == "")? DateTime.now().toIso8601String() : DateTime.parse(detailedOffer.offer.createdAt).toIso8601String() )}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
                Container(child: Row(children: [
                 Text("Time: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text(" ${changeToAmPm((detailedOffer.offer.createdAt == "")? DateTime.now().toIso8601String() :  DateTime.parse(detailedOffer.offer.createdAt).toIso8601String())}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
              

                const SizedBox(height: 10,),
               
            
                const SizedBox(height: 10,),

              Container(
                height: 35,
                decoration: BoxDecoration(color: Colors.grey[500]),
                width:  MediaQuery.of(context).size.width, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Padding(padding: EdgeInsets.all(5), child:Text("Title", style: TextStyle(color: Colors.white),)  ,),
                 Padding(padding: EdgeInsets.all(5), child:Text("Price", style: TextStyle(color: Colors.white))  ,),

              ],)
               ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child:     ListView.builder(
            itemCount: detailedOffer.offer.items.length,
            itemBuilder: (
            context,index){
               return
                (index == detailedOffer.offer.items.length-1)?
              Column(children: [
  Container( 
                 height: 50,
                 decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400,width: 1))),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
// Text("Title: " + detailedOffer.offer.items[index].title),

 Container(child: Row(children: [
                //  Text("Title: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("${detailedOffer.offer.items[index].title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
 Container(child: Row(children: [
                //  Text("Price: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("\$${detailedOffer.offer.items[index].price}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
// Text("Price: \$" + detailedOffer.offer.items[index].price,style: TextStyle(fontWeight: FontWeight.bold),),

               ])),
               Container(child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                 
                 Text("Tax: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("\$ ${((detailedOffer.offer.vat * getTotal())/100).roundToDouble()}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
                  ((detailedOffer.offer.discount != 0.0)?
                  Container(child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                    
                    children: [
                 Text("Discount: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text(" ${detailedOffer.offer.discount}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),) : SizedBox()),
                 Container(
                   
                   
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                 Text("Total: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  Text("\$${(double.parse(detailedOffer.offer.totalEstimation ).roundToDouble())}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
              ],)

               :
                Container( 
                 height: 50,
                 decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade400,width: 1))),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
// Text("Title: " + detailedOffer.offer.items[index].title),

 Container(child: Row(children: [
                //  Text("Title: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("${detailedOffer.offer.items[index].title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),
 Container(child: Row(children: [
                //  Text("Price: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 Text("\$${detailedOffer.offer.items[index].price}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),


                ]),),


               ]));



          }),
          
                ),
              
                // Text("Total Estimation: \$" + detailedOffer.offer.totalEstimation),
                  
              
                Container(child: Row(children: [
                   Text("Detailed Job Description: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                 


                ]),),
                 Text(detailedOffer.offer.note,),


                const SizedBox(height: 10,),

                
            
            ])


        ),
        ((detailedOffer.detailedRequest.request.requestStatus != "CANCELED")?
        CustomButton(buttonTitle: "Edit", callBackFunction: ((){
              Navigator.pushNamed(context, "EditOffer", arguments: detailedOffer );

        }))
        : SizedBox()),
        SizedBox(height: 20,)
      
      ])
        
      ),
    );
  }
}