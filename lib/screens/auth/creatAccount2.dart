// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
// ignore: depend_on_referenced_packages
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:panda_technician/components/globalComponents/popUpMessage.dart';
import 'package:panda_technician/models/messages/message.dart';
import 'package:panda_technician/models/auth/signUp.dart';

import 'package:panda_technician/services/validationServices.dart';

// ignore: must_be_immutable
class CreateAccount2 extends StatefulWidget {
  CreateAccount2({super.key, required this.arguments});
  SignUp arguments;
  @override
  State<CreateAccount2> createState() => _CreateAccount2State();
}

class _CreateAccount2State extends State<CreateAccount2> {
  String zipcode = "";
  bool isCompany = false;
  int errorForm = 0;
  bool updater = false;
  String street = "";
  String city = "";
  String state = "";
  List<dynamic> streetList = [];
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    streetList = [];
  }

  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text("Sign Up", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      width: 340,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: errorForm != 1
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.red,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        enabled: true,
                        controller: streetController,
                        onChanged: (value) async {
                          var listStreet =
                              await ApiHandler().autoComplete(value);

                          this.setState(() {
                            streetList = jsonDecode(listStreet)["predictions"];
                          });
                        },
                        style: const TextStyle(fontSize: 16),
                        cursorWidth: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "Street",
                          prefixIcon: Icon(Icons.location_city),
                        ),
                      )),
                  Container(
                      height: streetList.length * 50,
                      child: ListView.builder(
                          itemCount: streetList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    updater = !updater;
                                    streetController.text = streetList[index]
                                            ["description"]
                                        .split(",")[0];
                                    cityController.text = streetList[index]
                                            ["description"]
                                        .split(",")[1];
                                    stateController.text = streetList[index]
                                            ["description"]
                                        .split(",")[2];
                                    widget.arguments.street = streetList[index]
                                            ["description"]
                                        .split(",")[0];
                                    widget.arguments.city = streetList[index]
                                            ["description"]
                                        .split(",")[1];
                                    widget.arguments.state = streetList[index]
                                            ["description"]
                                        .split(",")[2];
                                    street = streetList[index]["description"]
                                        .split(",")[0];
                                    city = streetList[index]["description"]
                                        .split(",")[1];
                                    state = streetList[index]["description"]
                                        .split(",")[2];

                                    streetList = [];
                                  });
                                }),
                                child: ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                        streetList[index]["description"])));
                          })),
                  Container(
                      width: 340,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: errorForm != 1
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.red,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        enabled: true,
                        controller: cityController,
                        onChanged: (value) async {},
                        style: const TextStyle(fontSize: 16),
                        cursorWidth: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "City",
                          prefixIcon: Icon(Icons.location_city),
                        ),
                      )),
                  Container(
                      width: 340,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: errorForm != 1
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.red,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        enabled: true,
                        controller: stateController,
                        onChanged: (value) async {},
                        style: const TextStyle(fontSize: 16),
                        cursorWidth: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: "State",
                          prefixIcon: Icon(Icons.location_city),
                        ),
                      )),
                  TextFiledCustom(
                    updateCallback: ((value) {
                      zipcode = value;
                      widget.arguments.zipCode = int.parse(value);
                    }),
                    preIcon: Icons.code,
                    hintText: "Zip Code",
                    isPassword: false,
                    isZipCode: true,
                    isEmail: false,
                    isNumber: true,
                    isError: widget.arguments.zipCode.toString().length != 5
                        ? (errorForm == 404)
                            ? true
                            : errorForm == 4
                        : false,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 30,
                    width: 340,
                    margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: const Text(
                      "Hourly Fee:",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextFiledCustom(
                    updateCallback: ((value) {
                      widget.arguments.hourlyFee = int.parse(value);
                    }),
                    preIcon: Icons.attach_money,
                    hintText: "Hourly Fee",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: true,
                    isError: widget.arguments.hourlyFee == 0
                        ? (errorForm == 404)
                            ? true
                            : errorForm == 5
                        : false,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 30,
                    width: 340,
                    margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: const Text(
                      "Diagnostic Fee:",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  TextFiledCustom(
                    updateCallback: ((value) {
                      widget.arguments.diagnosticFee = int.parse(value);
                    }),
                    preIcon: Icons.attach_money,
                    hintText: "Diagnostic Fee",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: true,
                    isError: widget.arguments.diagnosticFee == 0
                        ? (errorForm == 404)
                            ? true
                            : errorForm == 6
                        : false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.white,
                            value: !isCompany,
                            onChanged: (bool? value) {
                              setState(() {
                                isCompany = !isCompany;
                              });
                            },
                          ),
                          const Text("Individual")
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.white,
                            value: isCompany,
                            onChanged: (bool? value) {
                              setState(() {
                                isCompany = !isAgreed;
                              });
                            },
                          ),
                          const Text("Company")
                        ],
                      ),
                    ],
                  ),
                  ((isCompany)
                      ? TextFiledCustom(
                          updateCallback: ((value) {
                            widget.arguments.companyName = value;
                          }),
                          preIcon: Icons.house,
                          hintText: "Company Name",
                          isPassword: false,
                          isZipCode: false,
                          isEmail: false,
                          isNumber: false)
                      : const SizedBox()),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    child: Row(children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: isAgreed,
                        onChanged: (bool? value) {
                          setState(() {
                            isAgreed = !isAgreed;
                          });
                        },
                      ),
                      const Text(
                        "I Agree To ",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "TermsAndService");
                        },
                        child: const Text(
                          "Terms & Conditions",
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            Container(
                width: 340, //
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(51, 188, 132, 1)),
                margin: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () async {
                    Message message = signUpFormValidation(
                        widget.arguments, isAgreed, zipcode);
                    if (message.success) {
                      Loading(context);
                      var response = await ApiHandler()
                          .createAccount(widget.arguments, context);
                    } else {
                      setState(() {
                        errorForm = message.formIndex;
                      });
                      showPurchaseDialog(
                          context, "Error Occured", message.message,
                          isApiCall: false);
                    }
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ]),
        ));
  }
}
