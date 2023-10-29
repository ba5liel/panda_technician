import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
import 'package:panda_technician/components/offerComponents/singleOffer.dart';
import 'package:panda_technician/models/DetailedOffer.dart';
import 'package:panda_technician/models/offer.dart';
import 'package:panda_technician/models/requests/detailedRequest.dart';

class CreateOffer extends StatefulWidget {
  CreateOffer({super.key, required this.arguments});
  final DetailedRequest arguments;

  @override
  State<CreateOffer> createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  int _offerCount = 3;
  int offe = 1;
  Offer offerList = Offer(items: []);
  TextEditingController taxController = TextEditingController();
  double discount = 0;

  @override
  void initState() {
    super.initState();
    // Future(_showJobList(context));
    // Use either of them.
    _offerCount = 13;
    offe = 1;
    //  offerList = Offer(items: []);
    offerList.title = widget.arguments.request.description.title;
    offerList.note = "";
    offerList.items.add(Item(title: "", price: "0"));

    // Requires import: 'dart:async'
  }

  void addOffer() {
    setState(() {
      // offe++;
      offerList.items.add(Item(title: "", price: "0"));
    });
  }

  void addDataToOffer(String lineD, int price, int index) {
    setState(() {
      offerList.items[index].title = lineD;
      offerList.items[index].price = price.toString();
    });
  }

  double getTotal() {
    double total = 0;
    for (int x = 0; x < offerList.items.length; x++) {
      total = total +
          (offerList.items[x].price == ""
              ? 0
              : double.parse(offerList.items[x].price));
// total = total + offerList[x].price;
    }

    if (total > 0 && total > discount) {
      total = total - discount;
    } else {}
    total = ((total) + ((offerList.vat * total) / 100));

    return double.parse(total.toStringAsFixed(2));
    // return total.roundToDouble();
  }

  void removeOffer(int index) {
    setState(() {
      offerList.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            body: Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: 120, //
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[500]),
                              margin: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'CANCEL',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          Container(
                              width: 120, //
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 17, 168, 143)),
                              margin: const EdgeInsets.fromLTRB(0, 40, 10, 0),
                              child: TextButton(
                                onPressed: () {
                                  offerList.requestId =
                                      widget.arguments.request.id;
                                  offerList.totalEstimation =
                                      getTotal().toString();

                                  widget.arguments.request.requestStatus =
                                      "ESTIMATED";
                                  widget.arguments.estimation = offerList;
                                  if (offerList.title == "") {
                                    DialogBox(
                                        context,
                                        "Error",
                                        "You must enter a title ",
                                        "Cancel",
                                        "Ok", (() {
                                      Navigator.pop(context);
                                    }), (() {
                                      Navigator.pop(context);
                                    }));
                                  } else if (offerList.items.length == 0) {
                                    DialogBox(
                                        context,
                                        "Error",
                                        "You must add at list one item ",
                                        "Cancel",
                                        "Ok", (() {
                                      Navigator.pop(context);
                                    }), (() {
                                      Navigator.pop(context);
                                    }));
                                  } else if (offerList.note == "") {
                                    DialogBox(
                                        context,
                                        "Error",
                                        "You must add a Note ",
                                        "Cancel",
                                        "Ok", (() {
                                      Navigator.pop(context);
                                    }), (() {
                                      Navigator.pop(context);
                                    }));
                                  } else {
                                    Navigator.pushNamed(context, "DisplayOffer",
                                        arguments: DetailedOffer(
                                            detailedRequest: widget.arguments,
                                            offer: offerList));
                                  }
                                  // Navigator.pushNamed(context, "JobDetail",arguments:  ServiceRequestModelodel(id: 3) );
                                  // ApiHandler().sendOffer(offerList, context, widget.arguments);
                                },
                                child: const Text(
                                  'SAVE',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ],
                      ),

                      Container(
                        height: 90,
                        alignment: Alignment.center,
                        child: const Text(
                          "Create Estimate",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: ((value) {
                              offerList.title = value;
                            }),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            controller: TextEditingController()
                              ..text = offerList.title,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              border: InputBorder.none,
                              hintText:
                                  widget.arguments.request.description.title,
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: offerList.items.length * 80,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1),
                                top: BorderSide(color: Colors.grey, width: 1)),
                            color: Colors.transparent),
                        child: ListView.builder(
                            itemCount: offerList.items.length,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            itemBuilder: (context, index) {
                              return SingleOffer(
                                  items: offerList.items[index],
                                  updatePrice: ((price) {
                                    setState(() {
                                      offerList.items[index] = price;
                                    });
                                  }),
                                  updateTitle: ((title) {
                                    setState(() {
                                      offerList.items[index] = title;
                                    });
                                  }),
                                  removeOffer: (() {
                                    removeOffer(index);
                                  }));
                            }),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: const Text(
                          "Discount ",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      TextFiledCustom(
                          updateCallback: ((value) {
                            double total = 0;
                            for (int x = 0; x < offerList.items.length; x++) {
                              total = total +
                                  (offerList.items[x].price == ""
                                      ? 0
                                      : double.parse(offerList.items[x].price));
// total = total + offerList[x].price;
                            }
                            if (double.parse(value) >
                                ((total) + ((offerList.vat * total) / 100))) {
                              var message = SnackBar(
                                  content: Text(
                                      "You can't descount more than total"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(message);
                            }
                            setState(() {
                              offerList.discount = double.parse(value);
                              discount = double.parse(value);
                            });
                          }),
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.9,
                          preIcon: Icons.attach_money,
                          hintText: "Discount",
                          isPassword: false,
                          isZipCode: false,
                          isEmail: false,
                          isNumber: true),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: const Text(
                          "Tax ",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
//   TextFiledCustom(updateCallback: ((value){
// offerList.vat = double.parse(value);
//   }), preIcon: Icons.percent, hintText: "Tax", width: MediaQuery.of(context).size.width * 0.9, isPassword: false, isZipCode: false, isEmail: false, isNumber: true),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 40,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: true
                                    ? Colors.grey.withOpacity(0.2)
                                    : Colors.red,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: taxController,
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                if (int.parse(val) >= 100) {
                                  taxController.text = "100";
                                  offerList.vat = double.parse("100");
                                } else {
                                  offerList.vat = double.parse(val);
                                }
                              }
                            },
                            style: const TextStyle(fontSize: 16),
                            cursorWidth: 1,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: "Tax",
                              prefixIcon: Icon(Icons.percent),
                            ),
                          )),
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: const Text(
                          "Detailed Job Description ",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 120,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            controller: TextEditingController()
                              ..text = offerList.note,
                            onChanged: ((value) {
                              offerList.note = value;
                            }),
                            expands: true,
                            maxLength: 450,
                            minLines: null,
                            maxLines: null,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              border: InputBorder.none,
                              hintText: "",
                            ),
                          )),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  addOffer();
                                },
                                child: Container(
                                    alignment: Alignment.topRight,
                                    height: 50,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.green[200],
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    width: 50,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.add,
                                          color: Colors.white, size: 30),
                                    )),
                              )),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Total",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "\$" + getTotal().toString(),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.green[200]),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ))));
  }
}
