// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:intl/intl.dart';
import 'package:panda_technician/components/flow/ProgressTracker.dart';
import 'package:panda_technician/components/flow/ratingCard.dart';
import 'package:panda_technician/components/globalComponents/customButton.dart';
import 'package:panda_technician/components/globalComponents/displayImage.dart';
import 'package:panda_technician/components/imageComponents/curvedImage.dart';
import 'package:panda_technician/components/messageComponents/centredMessage.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
import 'package:panda_technician/models/DetailedOffer.dart';
import 'package:panda_technician/models/globalModels/schedule.dart';
import 'package:panda_technician/models/offer.dart';
import 'package:panda_technician/models/offer/SentOffer.dart';
import 'package:panda_technician/models/requests/detailedRequest.dart';
import 'package:panda_technician/models/requests/detailedRequestM.dart';
import 'package:panda_technician/models/service/service.dart';
import 'package:panda_technician/models/vehicle/vehicle.dart';
import 'package:panda_technician/services/serviceDate.dart';
import 'package:panda_technician/services/serviceMoney.dart';
import 'package:panda_technician/services/serviceLocation.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AcceptJob extends StatefulWidget {
  AcceptJob({super.key, required this.arguments});
  DetailedRequest arguments;
  // int statusIndex;

  @override
  State<AcceptJob> createState() => _AcceptJobState();
}

class _AcceptJobState extends State<AcceptJob> {
  int statusIndex = 0;
// CalendarController _controller;
  late DetailedRequestM request;
  late Vehicle vehicle;
  late Service service;
  Schedule newSchedule = Schedule(
      date: DateTime.now().toIso8601String(),
      time: DateTime.now().toIso8601String());
  late Timer timer;
  bool isAccepted = false;
  bool rejectedOffer = false;
  List<SentOffer> offerList = [];
  bool isOfferCreated = false;
  Offer estimation = Offer(items: []);
  String areaName = "";
  bool modalShowed = false;
  bool isAlreadyAccepted = false;
  String comment = "";
  double rating = 0;
  String feedBack = "";

  @override
  void initState() {
    super.initState();
    // Loading(context);

    newSchedule = Schedule(
        date: DateTime.now().toIso8601String(),
        time: DateTime.now().toIso8601String());
    request = widget.arguments.request;
    vehicle = widget.arguments.vehicle;
    estimation = widget.arguments.estimation;
    service = widget.arguments.service;
    isAccepted = false;
    modalShowed = false;
    isAlreadyAccepted = false;
    feedBack = "";
    statusIndex = widget.arguments.request.requestStatus == "ACCEPTED"
        ? 0
        : widget.arguments.request.requestStatus == "ON_MY_WAY"
            ? 1
            : widget.arguments.request.requestStatus == "ARRIVED"
                ? 2
                : widget.arguments.request.requestStatus == "COMPLETED"
                    ? 4
                    : widget.arguments.request.requestStatus ==
                            "SERVICE_UNDERWAY"
                        ? 9
                        : widget.arguments.request.requestStatus == "ESTIMATED"
                            ? 5
                            : 0;
    // _controller = CalendarController();
    checkIfOfferCreated();
//  if(!modalShowed){
    checkIfAccepted();

//  }
    getAreaName();
    timer = Timer.periodic(
        const Duration(seconds: 30),
        (Timer t) => {
              if (!widget.arguments.estimation.isApproved &&
                  !widget.arguments.estimation.isRejected)
                {isAcceptedEstimation()}
            });
    // timer = Future.delayed(
    //     Duration(seconds: 30),() {isAcceptedEstimation()});
  }

  getAreaName() async {
    List name = jsonDecode(await ApiHandler().getLocationName(
        widget.arguments.request.serviceLocation.latitude,
        widget.arguments.request.serviceLocation.longitude))["results"];
    if (name.length > 0) {
      setState(() {
        areaName = name[0]["formatted_address"];
      });
    } else {
      setState(() {
        areaName = "Find Best Route";
      });
    }
  }

  giveRating() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        context: context,
        builder: (context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                  alignment: Alignment.center,
                  height: 400,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(24),
                  child: Column(children: [
                    Text(
                      "Service Complete",
                      style: TextStyle(fontSize: 17, color: Colors.green[400]),
                    ),
                    RatingBar.builder(
                      initialRating: 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rating = rating;
                        });
                        print(rating);
                      },
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
                          onChanged: ((value) {
                            setState(() {
                              feedBack = value;
                            });
                          }),
                          expands: true,
                          maxLength: 250,
                          minLines: null,
                          maxLines: null,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          cursorWidth: 1,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            border: InputBorder.none,
                            hintText: "Anything to say?",
                          ),
                        )),

                    CustomButton(
                        buttonTitle: "Send Feedback",
                        callBackFunction: (() async {
                          await ApiHandler().sendRating(
                              widget.arguments.request.customerId,
                              rating,
                              widget.arguments.request.id,
                              feedBack,
                              context);
                          Navigator.popAndPushNamed(context, "Home");
                        })),
                    CustomButton(
                        buttonTitle: "Cancel",
                        callBackFunction: (() {
                          Navigator.popAndPushNamed(context, "Home");
                        }))
                    // StarRating(color: Color.fromARGB(250, 175, 9, 9),rating: 4.5, onRatingChanged: (double rating) {  }, )
                  ])));
        });
  }

  isAcceptedEstimation() async {
    List<SentOffer> offersSent =
        await ApiHandler().isOfferCreated(widget.arguments.request.id);

    bool rejectedOffers = offersSent.length == 0
        ? false
        : offersSent[offersSent.length - 1].isRejected;
    bool acceptedOffer = offersSent.length == 0
        ? false
        : offersSent[offersSent.length - 1].isApproved;

    if (acceptedOffer == true && isAlreadyAccepted != true) {
      setState(() {
        isAlreadyAccepted = true;
      });

      // ApiHandler().openStartedJob(widget.arguments.request.id, context);

      widget.arguments.estimation.isApproved = true;
      // ignore: use_build_context_synchronously
      Navigator.popAndPushNamed(context, "JobDetail",
          arguments: DetailedRequest(
              request: widget.arguments.request,
              vehicle: widget.arguments.vehicle,
              service: widget.arguments.service,
              estimation: widget.arguments.estimation));
    } else if (rejectedOffers == true) {
      widget.arguments.estimation.isRejected = true;
      // ignore: use_build_context_synchronously
      Navigator.popAndPushNamed(context, "JobDetail",
          arguments: DetailedRequest(
              request: widget.arguments.request,
              vehicle: widget.arguments.vehicle,
              service: widget.arguments.service,
              estimation: widget.arguments.estimation));
    }
  }

  checkIfAccepted() async {
    if (!isAccepted &&
        statusIndex != 4 &&
        !rejectedOffer &&
        !modalShowed &&
        widget.arguments.request.requestStatus != "SERVICE_UNDERWAY") {
      // bool value =await ApiHandler().isOfferAccepted(widget.arguments.request.id);
      print("QQQQQQQQQQQ: " + widget.arguments.request.id);
      List<SentOffer> offersSent =
          await ApiHandler().isOfferCreated(widget.arguments.request.id);

      bool rejectedOffers = offersSent.length == 0
          ? false
          : offersSent[offersSent.length - 1].isRejected;
      bool acceptedOffer = offersSent.length == 0
          ? false
          : offersSent[offersSent.length - 1].isApproved;

      print("THIS IS VALUE: " + acceptedOffer.toString());
      print("aaaaaaaaaaaaaaaaa: " + modalShowed.toString());
      print("uuuuu: " + offersSent.toString());
      // print("THIS IS VALUE: " + offersSent[offersSent.length - 1].toString());

      if (acceptedOffer == true && !modalShowed) {
        // ApiHandler().openStartedJob(widget.requestData.id, context);

        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            context: context,
            builder: (context) {
              return Container(
                  alignment: Alignment.center,
                  height: 170,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        "Customer has Approved Your Offer you can now start working",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      CustomButton(
                          width: MediaQuery.of(context).size.width * 0.9,
                          buttonTitle: 'Start Work',
                          callBackFunction: (() async {
                            bool value = await ApiHandler()
                                .isOfferAccepted(widget.arguments.request.id);
                            print("VVVVVVVV: " + value.toString());
                            if (value) {
                              ApiHandler().updateJobStatus(
                                  request.id, context, "SERVICE_UNDERWAY", (() {
                                // Navigator.popAndPushNamed(context,"JobDetail");

                                // Navigator.pop(context);
                                ApiHandler().openStartedJob(
                                    widget.arguments.request.id, context);

                                setState(() {
                                  statusIndex = 9;
                                  widget.arguments.request.requestStatus =
                                      "SERVICE_UNDERWAY";
                                });

                                //  finshed();
                              }));
                            } else {
                              DialogBox(
                                  context,
                                  "Message",
                                  "Customer Must Accept Your Offer Before you continue",
                                  "Cancel",
                                  "Ok", (() {
                                Navigator.pop(context);
                              }), (() {
                                Navigator.pop(context);
                              }));
                            }
                          })),
                    ],
                  ));
            });

        setState(() {
          isAccepted = acceptedOffer;
          rejectedOffer = rejectedOffers;
          modalShowed = true;
        });
      } else if (rejectedOffers == true && !modalShowed) {
        showModalBottomSheet(
            isDismissible: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            context: context,
            builder: (context) {
              return Container(
                  alignment: Alignment.center,
                  height: 220,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        "Customer has rejected your offer, you will be paid a dignostic fee",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      CustomButton(
                          width: MediaQuery.of(context).size.width * 0.9,
                          buttonTitle: 'Ok',
                          callBackFunction: (() async {
                            Navigator.popAndPushNamed(context, "Home");
                          })),
                      CustomButton(
                          width: MediaQuery.of(context).size.width * 0.9,
                          buttonTitle: 'Counter Offer',
                          callBackFunction: (() {
                            // bool value =await ApiHandler().isOfferAccepted(widget.arguments.request.id);

                            // DetailedOffer(detailedRequest: widget.arguments , offer: estimation) ;
                            estimation.isCounterOffer = true;
                            estimation.isApproved = false;
                            estimation.isRejected = false;

                            Navigator.popAndPushNamed(context, "EditOffer",
                                arguments: DetailedOffer(
                                    detailedRequest: widget.arguments,
                                    offer: estimation));
                          }))
                    ],
                  ));
            });
        setState(() {
          rejectedOffer = true;
          modalShowed = true;
        });
      }

      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
    }
  }

  checkIfOfferCreated() async {
    offerList = await ApiHandler().isOfferCreated(widget.arguments.request.id);

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          if (offerList.length > 0) {
            isOfferCreated = true;
            if (statusIndex != 4) {
              statusIndex = 5;
            }
            estimation.createdAt = offerList[offerList.length - 1].createdAt;
            estimation.note = offerList[offerList.length - 1].note;
            estimation.sender = offerList[offerList.length - 1].sender;
            estimation.items = offerList[offerList.length - 1].items;
            estimation.id = offerList[offerList.length - 1].id;
            estimation.requestId = offerList[offerList.length - 1].requestId;
            estimation.title = offerList[offerList.length - 1].title;
            estimation.totalEstimation =
                offerList[offerList.length - 1].totalEstimation;

            estimation.discount = offerList[offerList.length - 1].discount;
            estimation.vat = offerList[offerList.length - 1].vat;

            setState(() {
              isAlreadyAccepted = offerList[offerList.length - 1].isApproved;
            });
          } else {}
        }));
  }

  void updateStatus() {
    setState(() {
      statusIndex++;
    });
  }

  void arrived() {
    setState(() {
      statusIndex = 2;
    });
  }

  void finshed() {
    setState(() {
      statusIndex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.grey[700],
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(context, "Requests"),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Job in Progress",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        body: SingleChildScrollView(
          child: WillPopScope(
              onWillPop: () async => false,
              child: SafeArea(
                  top: false,
                  bottom: true,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              service.description,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(changeToAmPm(request.schedule.time),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                textAlign: TextAlign.right)
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 20,
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(children: [
                                Icon(Icons.circle,
                                    color: statusIndex == 0
                                        ? Colors.pink[100]
                                        : statusIndex == 1
                                            ? Colors.blue[100]
                                            : statusIndex == 2
                                                ? Colors.green[100]
                                                : Colors.grey[100],
                                    size: 15),
                                Text(
                                  statusIndex == 0
                                      ? "Open Job"
                                      : statusIndex == 1
                                          ? "On My Way"
                                          : statusIndex == 2
                                              ? "Service UnderWay"
                                              : "",
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                            ),
                            Text(getUsDateFormat(request.schedule.date),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                textAlign: TextAlign.right)
                          ],
                        ),
                      ),

                      ((statusIndex != 4)
                          ? ProgressTracker(
                              statusIndex: statusIndex,
                              arrived: (() {
                                giveRating();
                              }),
                              finshed: finshed,
                              requestId: request.id,
                              OnMyWay: (() {}),
                            )
                          : Container(
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.grey.shade400,
                                        offset: Offset.fromDirection(1.3))
                                  ]),
                              child: Column(children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Text("COMPLETED",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                                "\$ ${widget.arguments.estimation.totalEstimation.toString().replaceAll(".0", "")}",
                                                style: const TextStyle(
                                                    height: 1.5, fontSize: 14)),
                                          )),
                                    ],
                                  ),
                                ),
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                          "Service Completed successfully",
                                          style: TextStyle(
                                              height: 1.5, fontSize: 14)),
                                    )),
                              ]))),
                      RatingCard(
                        profile: request.customerInfo,
                        vehicleImage: vehicle.image,
                      ),
                      ((statusIndex == 4 &&
                              widget.arguments.request.requestStatus !=
                                  "SERVICE_UNDERWAY")
                          ? CustomButton(
                              buttonTitle: "Give Rating",
                              callBackFunction: (() {
                                giveRating();
                              }))
                          : const SizedBox()),

                      ((statusIndex != 4 &&
                              statusIndex != 2 &&
                              request.requestStatus != "CANCELED" &&
                              (request.requestStatus != "SERVICE_UNDERWAY"))
                          ? CustomButton(
                              buttonColor: Colors.blue.shade300,
                              width: MediaQuery.of(context).size.width * 0.9,
                              buttonTitle: (statusIndex == 5 && !isAccepted)
                                  ? (rejectedOffer)
                                      ? "Offer Rejected"
                                      : 'Waiting For Customer Approval'
                                  : (statusIndex == 0)
                                      ? 'On My Way'
                                      : (statusIndex == 1)
                                          ? 'Arrived'
                                          : (isAccepted)
                                              ? 'Start Work'
                                              : 'Complete',
                              callBackFunction: (() async {
                                if (!rejectedOffer) {
                                  if (statusIndex == 0) {
                                    ApiHandler().updateJobStatus(
                                        request.id, context, "ON_MY_WAY", (() {
                                      setState(() {
                                        statusIndex = 1;
                                      });
                                    }));
                                  } else if (statusIndex == 1) {
                                    ApiHandler().updateJobStatus(
                                        request.id, context, "ARRIVED", (() {
                                      arrived();
                                    }));
                                  } else if (statusIndex == 2) {
                                    DialogBox(
                                        context,
                                        "Message",
                                        "Create Estimation Before You continue",
                                        "Cancel",
                                        "Ok", (() {
                                      Navigator.pop(context);
                                    }), (() {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, "CreateOffer",
                                          arguments: widget.arguments);
                                    }));
                                  } else if (statusIndex == 5) {
                                    bool value = await ApiHandler()
                                        .isOfferAccepted(
                                            widget.arguments.request.id);
                                    if (value) {
                                      // ignore: use_build_context_synchronously
                                      ApiHandler().updateJobStatus(request.id,
                                          context, "SERVICE_UNDERWAY", (() {
                                        //  finshed();
                                        setState(() {
                                          statusIndex = 9;
                                        });

                                        widget.arguments.request.requestStatus =
                                            "SERVICE_UNDERWAY";
                                        // ApiHandler().openStartedJob(widget.requestData.id, context);
                                        Navigator.popAndPushNamed(
                                            context, "JobDetail",
                                            arguments: DetailedRequest(
                                                request:
                                                    widget.arguments.request,
                                                vehicle:
                                                    widget.arguments.vehicle,
                                                service:
                                                    widget.arguments.service,
                                                estimation: estimation));
                                      }));
                                    } else {
                                      DialogBox(
                                          context,
                                          "Message",
                                          "Customer Must Accept Your Offer Before you continue",
                                          "Cancel",
                                          "Ok", (() {
                                        Navigator.pop(context);
                                      }), (() {
                                        Navigator.pop(context);
                                      }));
                                    }
                                  }
                                }
                              }),
                            )
                          : const SizedBox()),
                      ((request.requestStatus == "SERVICE_UNDERWAY")
                          ? CustomButton(
                              buttonTitle: "Complete",
                              callBackFunction: (() {
                                ApiHandler().updateJobStatus(
                                    request.id, context, "COMPLETED", (() {
                                  // Navigator.popAndPushNamed(context,"Requests");
                                  widget.arguments.request.requestStatus =
                                      "COMPLETED";

                                  Navigator.popAndPushNamed(
                                      context, "JobDetail",
                                      arguments: DetailedRequest(
                                          request: widget.arguments.request,
                                          vehicle: widget.arguments.vehicle,
                                          service: widget.arguments.service,
                                          estimation: estimation));

                                  finshed();
                                }));
                              }))
                          : const SizedBox()),
                      const SizedBox(
                        height: 8,
                      ),
                      ((statusIndex == 5)
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.grey.shade400,
                                        offset: Offset.fromDirection(1.3))
                                  ]),
                              child: Column(children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Text(
                                              widget.arguments.estimation.title,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                                "\$" +
                                                    widget.arguments.estimation
                                                        .totalEstimation,
                                                style: const TextStyle(
                                                    height: 1.5, fontSize: 14)),
                                          )),
                                    ],
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                          widget.arguments.estimation.note,
                                          style: const TextStyle(
                                              height: 1.5, fontSize: 14)),
                                    )),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.9, //
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade700),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    child: TextButton(
                                      onPressed: () {
                                        if (rejectedOffer) {
                                          estimation.isCounterOffer = true;
                                          estimation.isApproved = false;
                                          estimation.isRejected = false;
                                          Navigator.popAndPushNamed(
                                              context, "EditOffer",
                                              arguments: DetailedOffer(
                                                  detailedRequest:
                                                      widget.arguments,
                                                  offer: estimation));
                                        } else {
                                          Navigator.pushNamed(
                                              context, "OnlyDisplayOffer",
                                              arguments: DetailedOffer(
                                                  detailedRequest:
                                                      widget.arguments,
                                                  offer: estimation));
                                        }
                                      },
                                      child: Text(
                                        "View Estimation " +
                                            (rejectedOffer
                                                ? "/ Counter Offer"
                                                : request.requestStatus !=
                                                        "CANCELED"
                                                    ? "/Edit"
                                                    : ""),
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ]))
                          : const SizedBox()),
                      (statusIndex == 2)
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.9, //
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(51, 188, 132, 1)),
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "CreateOffer",
                                      arguments: widget.arguments);
                                },
                                child: const Text(
                                  'Create Estimate',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                          : Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.grey.shade400,
                                        offset: Offset.fromDirection(1.3))
                                  ]),
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 500,
                              child: Column(children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    child: Row(
                                      children: <Widget>[
                                        const Image(
                                          height: 60,
                                          width: 60,
                                          image: AssetImage("assets/car.png"),
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent),
                                            child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    service.description,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      request.description.title,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey[400])),
                                                )
                                              ],
                                            )),
                                        Text(
                                            removeZero(
                                                request.price.diagnosticFee),
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green[200])),
                                      ],
                                    )),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: const Text(
                                    "Where",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.fade,
                                        color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade400,
                                            offset: Offset.fromDirection(2.1),
                                            blurRadius: 1)
                                      ]),
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      navigateTo(
                                          request.serviceLocation.latitude,
                                          request.serviceLocation.longitude);
                                    },
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(children: [
                                          Icon(Icons.location_on_outlined,
                                              color: Colors.grey[400]),
                                          Text(request.serviceLocation.name,
                                              style: TextStyle(
                                                  overflow: TextOverflow.fade,
                                                  color: Colors.grey[400]))
                                        ])),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: const Text(
                                    "Vechicle",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    height: 50,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        // Image(height: 60,width:60, image: NetworkImage("https://stimg.cardekho.com/images/carexteriorimages/630x420/MG/Hector/8259/1632911780671/front-left-side-47.jpg?impolicy=resize&imwidth=480"),)

                                        Container(
                                          width: 50,
                                          height: 50,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.fromLTRB(
                                              5, 0, 5, 0),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    vehicle.image)),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8.0)),
                                            color: Colors.transparent,
                                          ),
                                        ),

                                        Container(
                                            alignment: Alignment.topLeft,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: 50,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      vehicle.brand,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.start,
                                                    )),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    vehicle.model,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.grey[400]),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  'FF' +
                                                      vehicle.color
                                                          .replaceAll("#", ""),
                                                  radix: 16)),
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        )
                                      ],
                                    )),
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Text("Additional Detail",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    )),
                                Container(
                                  height: 100,
                                  decoration: const BoxDecoration(),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                      child: Text(request.description.note,
                                          style: const TextStyle(
                                              overflow: TextOverflow.fade,
                                              height: 1.5,
                                              fontSize: 14))),
                                ),
                                //   Align(

                                //   alignment: Alignment.topLeft,
                                //   child:
                                //   Padding(padding: const EdgeInsets.all(10),
                                //   child: Text(request.description.note,style: const TextStyle(overflow: TextOverflow.fade,height:1.5, fontSize: 14)),
                                //   )

                                // ),
                                Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 100,
                                  child: (request
                                              .description.attachments.length ==
                                          0)
                                      ? CentredMessage(
                                          messageWidget: const Text(
                                              "No Attachments Available",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)))
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: request
                                              .description.attachments.length,
                                          itemBuilder: (context, index) {
                                            return CurvedImage(
                                                callback: () {
                                                  DisplayImage(
                                                      context,
                                                      request.description
                                                          .attachments[index]);
                                                },
                                                imageUrl: request.description
                                                    .attachments[index]);
                                          }),
                                )
                              ]),
                            ),

                      ((request.requestStatus == "ACCEPTED" ||
                                  request.requestStatus == "ARRIVED" ||
                                  request.requestStatus == "ON_MY_WAY") &&
                              statusIndex != 5 &&
                              !rejectedOffer)
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.9, //
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade700),
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                              child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                            alignment: Alignment.center,
                                            height: 300,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  child: DateTimePicker(
                                                    use24HourFormat: false,
                                                    type: DateTimePickerType
                                                        .dateTimeSeparate,
                                                    dateMask: 'd MMM, yyyy',
                                                    initialValue: DateTime.now()
                                                        .toString(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2100),
                                                    icon:
                                                        const Icon(Icons.event),
                                                    dateLabelText: 'Date',
                                                    timeLabelText: "Hour",
                                                    selectableDayPredicate:
                                                        ((date) {
                                                      if (date.year <
                                                          DateTime.now().year) {
                                                        return false;
                                                      } else if (date.month <
                                                          DateTime.now()
                                                              .month) {
                                                        return false;
                                                      } else if (date.day <
                                                          DateTime.now().day) {
                                                        return false;
                                                      }
                                                      print(":::::" +
                                                          date.toString());

                                                      return true;
                                                    }),
                                                    onChanged: (val) {
                                                      print("CccccCC: " + val);
                                                      var forma = new DateFormat(
                                                          "yyyy-MM-dd HH:mm a");
                                                      DateTime dd =
                                                          DateTime.now();
                                                      String dds =
                                                          forma.format(dd);

                                                      print(
                                                          "sfsdfsdfsd: " + dds);

                                                      DateTime newDate =
                                                          new DateFormat(
                                                                  "yyyy-MM-dd HH:mm a")
                                                              .parse(val);
                                                      print("sdfsdf: " +
                                                          newDate
                                                              .toIso8601String());

                                                      setState(() {
                                                        newSchedule.date = newDate
                                                            .toIso8601String();
                                                        newSchedule.time = newDate
                                                            .toIso8601String();
                                                      });
                                                    },
                                                    validator: (val) {
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      print(
                                                          "CCCC: " + "INSIDE ");
                                                      setState(() {
                                                        newSchedule
                                                            .date = DateTime
                                                                .parse(val!)
                                                            .toIso8601String();
                                                        newSchedule
                                                            .time = DateTime
                                                                .parse(val)
                                                            .toIso8601String();
                                                      });
                                                    },
                                                  ),
                                                ),
                                                (((request.requestStatus ==
                                                                "ACCEPTED" ||
                                                            request.requestStatus ==
                                                                "ARRIVED" ||
                                                            request.requestStatus ==
                                                                "ON_MY_WAY") &&
                                                        !rejectedOffer &&
                                                        statusIndex != 5 &&
                                                        request.requestStatus !=
                                                            "ESTIMATED")
                                                    ? CustomButton(
                                                        buttonTitle:
                                                            "Reschedule",
                                                        callBackFunction: (() {
                                                          ApiHandler()
                                                              .reschedule(
                                                                  newSchedule,
                                                                  request.id,
                                                                  context);
                                                        }))
                                                    : const SizedBox())
                                              ],
                                            ));
                                      });
                                },
                                child: const Text(
                                  "Reschedule",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                          : const SizedBox(),

// PENDING
// ACCEPTED
// ARRIVED
// COMPLETED
// CANCELED
                      ((!rejectedOffer)
                          ? (((request.requestStatus == "ACCEPTED" ||
                                      request.requestStatus == "ARRIVED" ||
                                      request.requestStatus == "ON_MY_WAY") &&
                                  statusIndex != 5)
                              ? CustomButton(
                                  buttonColor:
                                      const Color.fromARGB(255, 233, 129, 129),
                                  buttonTitle: "Cancel",
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  callBackFunction: (() {
                                    DialogBox(
                                        context,
                                        "Message",
                                        "Are you sure you want to cancel this Job",
                                        "No",
                                        "Yes", (() {
                                      Navigator.pop(context);
                                    }), (() {
                                      Navigator.pop(context);
                                      ApiHandler().updateJobStatus(
                                          request.id, context, "CANCELED", (() {
                                        Navigator.popAndPushNamed(
                                            context, "Requests");
                                      }));
                                      //  ApiHandler().rejectJob(request.id,request.technicianInfo.id,request.customerId,context);
                                    }));
                                  }))
                              : const SizedBox())
                          : const SizedBox()),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ))),
        ));
  }
}
