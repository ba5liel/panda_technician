import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:panda_technician/app/modules/job_offer/job_offer.controller.dart';
import 'package:panda_technician/components/flow/ratingCard.dart';
import 'package:panda_technician/components/globalComponents/displayImage.dart';
import 'package:panda_technician/components/imageComponents/curvedImage.dart';
import 'package:panda_technician/components/messageComponents/centredMessage.dart';
import 'package:panda_technician/app/modal/auto_service/watchRequestDetail.dart';
import 'package:panda_technician/models/service/service.dart';
import 'package:panda_technician/models/vehicle/vehicle.dart';
import 'package:panda_technician/services/serviceDate.dart';
import 'package:panda_technician/services/serviceLocation.dart';

class JobDetail extends StatefulWidget {
  JobDetail({super.key, required this.arguments});
  final WatchDetailedRequest arguments;
  // int statusIndex;

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  int statusIndex = 0;
// CalendarController _controller;
  late ServiceRequestModel request;
  late Vehicle vehicle;
  late Service service;
  String areaName = "";

  final JobOfferController jobOfferController = Get.find<JobOfferController>();

  @override
  void initState() {
    super.initState();
    request = widget.arguments.request;
    vehicle = widget.arguments.vehicle;
    service = widget.arguments.service;
    getAreaName();
    statusIndex = widget.arguments.request.requestStatus == "ACCEPTED"
        ? 0
        : widget.arguments.request.requestStatus == "ON_MY_WAY"
            ? 1
            : widget.arguments.request.requestStatus == "ARRIVED"
                ? 2
                : widget.arguments.request.requestStatus == "COMPLETED"
                    ? 3
                    : 0;
    // _controller = CalendarController();
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Job Detail",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              top: false,
              bottom: true,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    decoration: const BoxDecoration(color: Colors.transparent),
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
                    decoration: const BoxDecoration(color: Colors.transparent),
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
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.right)
                      ],
                    ),
                  ),
                  RatingCard(
                    profile: request.customerInfo,
                    vehicleImage: vehicle.image,
                  ),
                  ((statusIndex == 3)
                      ? Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 200,
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Text("Changing Battery",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("\$ 4500",
                                            style: TextStyle(
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
                                      "The note created in the estimations is writing under here",
                                      style:
                                          TextStyle(height: 1.5, fontSize: 14)),
                                )),
                            Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.9, //
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade700),
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: TextButton(
                                  onPressed: () {
                                    updateStatus();
                                  },
                                  child: const Text(
                                    "View Estimation",
                                    style: TextStyle(
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
                              //           Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const CreateOffer()),
                              // );
                            },
                            child: const Text(
                              'CREATE ESTIMATE',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                style: TextStyle(
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
                                                      color: Colors.grey[400])),
                                            )
                                          ],
                                        )),
                                    // Text(request.price.diagnosticFee.toString(), style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.green[200])),
                                  ],
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: const Text(
                                "Where",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
                                      color: Colors.grey.shade400, width: 1),
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
                                  navigateTo(request.serviceLocation.latitude,
                                      request.serviceLocation.longitude);
                                },
                                child: Row(children: [
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.grey[400]),
                                  Text(request.serviceLocation.name,
                                      style: TextStyle(color: Colors.grey[400]))
                                ]),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // Image(height: 60,width:60, image: NetworkImage("https://stimg.cardekho.com/images/carexteriorimages/630x420/MG/Hector/8259/1632911780671/front-left-side-47.jpg?impolicy=resize&imwidth=480"),)

                                    Container(
                                      width: 50,
                                      height: 50,
                                      alignment: Alignment.center,
                                      margin:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(vehicle.image)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        color: Colors.transparent,
                                      ),
                                    ),

                                    Container(
                                        alignment: Alignment.topLeft,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Colors.transparent),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  vehicle.brand,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                )),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                vehicle.model,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[400]),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Text("Additional Detail",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                  child: Text(request.description.note,
                                      style: TextStyle(
                                          overflow: TextOverflow.fade,
                                          height: 1.5,
                                          fontSize: 14))),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 100,
                              child:
                                  (request.description.attachments.length == 0)
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
                  (request.requestStatus == "PENDING")
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.9, //
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade700),
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: TextButton(
                            onPressed: () {
                              jobOfferController.acceptJob(request.id, request);
                            },
                            child: Text(
                              "Accept Job",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ))
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.9, //
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade700),
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: TextButton(
                            onPressed: () {
                              ApiHandler()
                                  .cancelJob(request.id, context, (() {}));
                            },
                            child: Text(
                              "Cancel Job",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                ],
              ))),
    );
  }
}
