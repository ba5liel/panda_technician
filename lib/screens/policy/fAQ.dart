import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text("FAQ", style: TextStyle(color: Colors.black)),
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
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Frequently asked questions",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "What is ThePanda app?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "1. ThePanda is a mobile auto repair and services APP. Our all-in-one software helps you run your business efficiently by taking care of marketing, scheduling appointments, point of sale, and revenue.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101))),
                      SizedBox(height: 5),
                      Text(
                        "How do I charge for my services through the app?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "2. You set your hourly rate and diagnostic fee. Payments are processed through a secured portal with Stripe and sent directly to your bank account.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101))),
                      Text(
                        "Is the app free for technicians to use?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "3. The technicians may have an annual subscription fee or opt to give a commission fee of 10% per transaction to ThePanda",
                          style: TextStyle(
                              color: Color.fromARGB(255, 104, 101, 101)))
                    ]))),
      ),
    );
  }
}
