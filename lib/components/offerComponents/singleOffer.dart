

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:panda_technician/models/offer.dart';

// class SingleOffer extends StatelessWidget {
//   SingleOffer({super.key,required this.removeOffer,
//   required this.items,
//   required this.updateTitle,
//   required this.updatePrice});

// Function removeOffer;
// Item items;
// Function updateTitle;
// Function updatePrice;
//   final myController = TextEditingController();
//   void onChanges(){
//     print("kkkLL: " + myController.text);
//     items.price = myController.text.toString();
//   }
//   @override
//   Widget build(BuildContext context) {
//   myController.addListener(onChanges);

//     return  Container(
//       width: MediaQuery.of(context).size.width *0.9,
//       margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//       child: 
//       Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         Container(
//     width:MediaQuery.of(context).size.width *0.56,
//     height: 50,
//       // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
    
//     decoration: BoxDecoration(
      
//       color: Colors.white,
//           boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.2),
//         spreadRadius: 1,
//         blurRadius: 2,
//         offset:const Offset(0, 3), 
//       ),
//     ],
//     ),
//     child:   TextField(
//       maxLength: 50,
//             controller: TextEditingController()..text = items.title,
//           onChanged: ((value){
//              items.title = value;
//               updateTitle(value);
//           }),
//           style: TextStyle(fontSize: 16),
//           cursorWidth: 1,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),

//         border: InputBorder.none,
//         hintText: "Line Item",
//       ),
//     )
//   ),
//     Container(
//     width:MediaQuery.of(context).size.width * 0.2,
//     height: 50,
//     decoration: BoxDecoration(
//       color: Colors.white,
//           boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.2),
//         spreadRadius: 1,
//         blurRadius: 2,
//         offset:const Offset(0, 3), 
//       ),
//     ],
//     ),
//     child:   TextField(
//               maxLength: 5,
//               keyboardType: TextInputType.number,
//             controller: myController..text = ((items.price == "0")? "" :items.price),


//       onChanged: ((value){
//         items.price = value;
//         print("KKKK " + value);
//         if(items.price == "0"){
//           // myController.clear();
//         }
       
//         myController.text = value;
//         myController.selection =
//           TextSelection.collapsed(offset: myController.text.length);
//         updatePrice(value);

//       }),
//           style: TextStyle(fontSize: 16),
//           cursorWidth: 1,
//       decoration: InputDecoration(
//       counterText: '',
//         // prefixText:  '\$',
//         // prefix:  Icon(Icons.attach_money) ,
//         prefixIcon: Padding(padding: const EdgeInsetsDirectional.only(end: 0.0), child:Icon(Icons.attach_money) ) ,
//            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

//         border: InputBorder.none,
//         hintText: "0",
//       ),
//     )
//   ),
//   Container(
//     width:40,
//     height: 50,
//     decoration: BoxDecoration(
//       color: Colors.white,
//           boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.2),
//         spreadRadius: 1,
//         blurRadius: 2,
//         offset:const Offset(0, 3), 
//       ),
//     ],
//     ),
//     child: TextButton(onPressed: () { 
//       removeOffer();
//      },
//     child: Icon(Icons.restore_from_trash,color: Colors.red[200],),)
//   )

//     ],));
//   }
// }


class SingleOffer extends StatefulWidget {
  SingleOffer({super.key,required this.removeOffer,
  required this.items,
  required this.updateTitle,
  required this.updatePrice});

Function removeOffer;
Item items;
Function updateTitle;
Function updatePrice;

  @override
  State<SingleOffer> createState() => _SingleOfferState();
}

class _SingleOfferState extends State<SingleOffer> {

   final myController = TextEditingController();
@override
void initState() {
    // TODO: implement initState
    super.initState();
    
    if(widget.items.price != "0"){
      
 myController.text = widget.items.price;

    }else{
    myController.clear();

    }
   
    myController.addListener(onChanges);
  }
   
  void onChanges(){
    // print("kkkLL: " + myController.text);
    widget.items.price = myController.text;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width *0.9,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: 
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
    width:MediaQuery.of(context).size.width *0.56,
    height: 50,
      // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
    
    decoration: BoxDecoration(
      
      color: Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 2,
        offset:const Offset(0, 3), 
      ),
    ],
    ),
    child:   TextField(
      maxLength: 30,
            controller: TextEditingController()..text = widget.items.title,
          onChanged: ((value){
             widget.items.title = value;
              widget.updateTitle(value);
          }),
          style: TextStyle(fontSize: 16),
          cursorWidth: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),

        border: InputBorder.none,
        hintText: "Line Item",
      ),
    )
  ),
    Container(
    width:MediaQuery.of(context).size.width * 0.2,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 2,
        offset:const Offset(0, 3), 
      ),
    ],
    ),
    child:   TextField(
              
             
              keyboardType: TextInputType.number,
            controller: myController,


      onChanged: ((value){
        widget.items.price = value;
        // print("KKKK " + value);
        if(widget.items.price == "0"){
          // myController.clear();
        }
       
        myController.text = value;
        myController.selection =
          TextSelection.collapsed(offset: myController.text.length);
        widget.updatePrice(value);

      }),
          style: TextStyle(fontSize: 12),
          cursorWidth: 1,
      decoration: InputDecoration(
      counterText: '',
        // prefixText:  '\$',
        // prefix:  Icon(Icons.attach_money) ,
        prefixIcon: Padding(padding: const EdgeInsetsDirectional.only(end: 0.0), child:Icon(Icons.attach_money) ) ,
           prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

        border: InputBorder.none,
        hintText: "0",
      ),
    )
  ),
  Container(
    width:40,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 2,
        offset:const Offset(0, 3), 
      ),
    ],
    ),
    child: TextButton(onPressed: () { 
      widget.removeOffer();
     },
    child: Icon(Icons.restore_from_trash,color: Colors.red[200],),)
  )

    ],));
  }
}