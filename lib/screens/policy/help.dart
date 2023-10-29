// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/customButton.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/store/profileProvider.dart';

import 'package:provider/provider.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileModel profile =
        Provider.of<ProfileProvider>(context, listen: true).profile;

    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title:
              const Text("User Guide", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Panda Help Section",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome to the Help section for the Technician section of the Panda app! We understand that using a new platform can be challenging, so we have compiled a list of frequently asked questions to assist you with using our app. If you need further assistance, please don't hesitate to reach out to us at information@panda-mars.com.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("How do I sign up as a technician on Panda?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "1.To sign up as a technician on Panda, simply download the app from the App Store or Google Play, and follow the steps to create a new account. Be sure to provide accurate information about your qualifications and experience as a mobile mechanic. ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101))),
                      SizedBox(height: 5),
                      Text(
                        "How do I set up my profile and services offered?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "2.Once you have created your account, you can set up your profile by providing information about your qualifications and services offered. This information will help customers find and book you for their auto repair needs.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101))),
                      Text(
                        "How do I receive and accept appointments from customers?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "3. Once you have set up your profile and services offered, customers will be able to search for and book you for their auto repair needs. You will receive a notification on the app when a customer has requested your services, and you can accept or decline the appointment. ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101))),
                      Text(
                        "How do I receive payment for my services?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "4.Once you have completed a service, the customer will be prompted to pay through the secure payment portal within the app. You will receive payment directly through the app, and can track your earnings in the app's dashboard. ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101))),
                      Text(
                        "How do I resolve any disputes with customers?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "5. In the unlikely event of a dispute with a customer, Panda has a dispute resolution process in place. Please contact us at information@panda-mars.com, and we will assist you in resolving the issue. ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101))),
                      SizedBox(height: 5),
                      Text(
                          "We hope this Help section has been useful in assisting you with using the Technician section of the PandaTech app. If you have any further questions or need additional support, please don't hesitate to reach out to us",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101)))
                    ]))));
  }
}
