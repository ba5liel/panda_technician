// ignore: file_names
import 'package:flutter/material.dart';

class TermAndService extends StatelessWidget {
  const TermAndService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text("Terms And Service",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.all(10),
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
              children: <Widget>[
                Text("Terms & Service",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(40),
                child:Text("You do not legally need to have a Terms of Service agreement. However, having one is very important and comes with a number of benefits for both you and your users.You'll benefit by being able to maintain more control over your website or mobile app. You can terminate accounts that don't follow your terms, control how legal disputes are handled and limit your liability.Your users will benefit by knowing from the start what your rules are and what they must do or not do when using your platform. They can use your Terms of Service agreement to instantly find answers to common questions they may have. You do not legally need to have a Terms of Service agreement. However, having one is very important and comes with a number of benefits for both you and your users.You'll benefit by being able to maintain more control over your website or mobile app. You can terminate accounts that don't follow your terms, control how legal disputes are handled and limit your liability.Your users will benefit by knowing from the start what your rules are and what they must do or not do when using your platform. They can use your Terms of Service agreement to instantly find answers to common questions they may have.",
) ,)

            ])


        ),
      ),
    );
  }
}
