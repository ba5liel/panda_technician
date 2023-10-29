// ignore_for_file: prefer_const_literals_to_create_immutables

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
            height: MediaQuery.of(context).size.height * 0.75,
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade400, blurRadius: 5)
                ]),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              const Text("Panda Terms and Conditions of Use",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("1. Acceptance of Terms"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "The following terms and conditions govern all use of the Panda mobile app and its related services, features and functionalities (collectively referred to as the \"Service\"). The Service is owned and operated by The Panda M.A.R.S. LLC. Your use of the Serviceis subject to your acceptance of and compliance with these terms. These terms apply toall users of the Service, including, without limitation, users who are browsers,customers, merchants, and/or contributors of content."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("2. Description of Service"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "The Service is a mobile app platform that connects automotive service professionals (referred to as \"Technicians\") with customers in need of automotive repair services.Customers can find, book and pay for services through the Service, while Technicians can manage their business, communicate with customers and accept payments through the Service. The Service is not an automotive repair service provider and is notresponsible for the performance of the services provided by Technicians."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("3. User Accounts"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "In order to use the Service, you must register for an account (\"Account\"). You are responsible for maintaining the confidentiality of your Account information and for all activities that occur under your Account. You agree to immediately notify The Panda M.A.R.S. LLC of any unauthorized use of your Account or any other breach of security. The Panda M.A.R.S. LLC will not be liable for any loss or damage arising from your failure to comply with this section."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("4. User Conduct"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "You agree to use the Service only for lawful purposes and in a manner that does not violate the rights of, or restrict or inhibit the use and enjoyment of the Service by, any third party. You will not use the Service to: (a) transmit or post any content that is illegal, harmful, threatening, abusive, harassing, tortuous, defamatory, vulgar, obscene, libelous, or otherwise objectionable; (b) transmit or post any content that you do not have the right to transmit or post; or (c) transmit or post any content that infringes any patent, trademark, trade secret, copyright, or other proprietary rights of any party."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("5. Payment Terms"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Customers may pay for services provided by Technicians through the Service using a secure payment portal. The Service will charge a commission fee of 10% on each transaction. The Panda M.A.R.S. LLC reserves the right to change its commission fee at any time and without notice."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("6. Disclaimers and Limitations of Liability"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "The Service is provided on an \"as is\" and \"as available\" basis without any representation or warranty, whether express, implied, or statutory. The Panda M.A.R.S. LLC makes no representation or warranty that the Service will be error-free or uninterrupted, and The Panda M.A.R.S. LLC will not be liable for any interruptions or errors."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("7. Indemnification"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "You agree to indemnify, defend and hold harmless The Panda M.A.R.S. LLC, its affiliates, and their respective directors, officers, employees, agents, and representatives from and against any and all claims, damages, losses, costs (including reasonable attorneys' fees), and other expenses that arise directly or indirectly out of or from (a) your breach of these terms and conditions, (b) your violation of any law or the rights of a third party, or (c) your use of the Service."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("8. Modifications to Service"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "The Panda M.A.R.S. LLC reserves the right to modify or discontinue the Service with or without notice at any time and without any liability to you."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("9. Governing Law"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "These terms will be governed by and construed in accordance with the laws of the State of Texas, without giving effect to its conflict of laws provisions.")
                ]),
              )
            ]))),
      ),
    );
  }
}
