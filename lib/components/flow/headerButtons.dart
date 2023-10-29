
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HeaderButton extends StatefulWidget {
   HeaderButton({super.key, required this.selectedIndex,required this.updateComponent});
  int selectedIndex;
  Function updateComponent;
  @override
  State<HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<HeaderButton> {
  @override
  Widget build(BuildContext context) {
    return   Container(alignment: Alignment.center,
          width:320,
          height: 50,
          
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          decoration: BoxDecoration(
            
          borderRadius: BorderRadius.circular(10),
      boxShadow: [BoxShadow(color: Colors.grey.shade300,offset: Offset.fromDirection(1) )],
              color:Colors.white),
            child: Row(children: <Widget>[
              Expanded(child: 
               Container(alignment: Alignment.center,
               height: double.infinity,
               
               decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10) ), color: widget.selectedIndex == 0? Colors.grey[900] : Colors.white),
              child: TextButton(
                onPressed: (){
                  widget.updateComponent(0);

                },
                child: Text("Accepted",style: TextStyle(color:widget.selectedIndex == 0? Colors.white : Colors.grey[900]),)
              )
               ),
              ),
               Expanded(child: 
               Container(alignment: Alignment.center,
               height: double.infinity,
               
               decoration: BoxDecoration(color: widget.selectedIndex == 1? Colors.grey[900] : Colors.white  ),
              child: TextButton(
                onPressed: (){

                  widget.updateComponent(1);

                },
                child: Text("Completed",style: TextStyle(color: widget.selectedIndex == 1? Colors.white : Colors.grey[900] ),)
              )
               ),
              ),
               Expanded(child: 
               Container(alignment: Alignment.center,
               height: double.infinity,
               
               decoration: BoxDecoration(borderRadius: const BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10) ), color: widget.selectedIndex == 2? Colors.grey[900] : Colors.white),
              child: TextButton(
                onPressed: (){
                  widget.updateComponent(2);

                },
                child: Text("Canceled",style: TextStyle(color:widget.selectedIndex == 2? Colors.white : Colors.grey[900]),)
              )
               ),
              ),

              
            ],)  
           );

  }
}