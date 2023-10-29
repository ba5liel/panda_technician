// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:panda_technician/services/serviceDate.dart';

class MobileTechnicianComponent extends StatefulWidget {
  MobileTechnicianComponent(
      {super.key,
      required this.requestData,
      required this.diagnosticFee,
      required this.sender});

//  ServiceRequestModelodel requestData;
  ServiceRequestModel requestData;
  int diagnosticFee;
  String sender;

  @override
  State<MobileTechnicianComponent> createState() =>
      _MobileTechnicianComponentState();
}

class _MobileTechnicianComponentState extends State<MobileTechnicianComponent> {
  String totalEstimation = "";
  @override
  void initState() {
    // TODO: implement initState
    totalEstimation = "0";
    getTotalEstimation();
    super.initState();
  }

  getTotalEstimation() {
    print("PROFILE: " + widget.sender);
    for (int x = 0; x < widget.requestData.offerDetail!.length; x++) {
      if (widget.requestData.offerDetail![x].sender == widget.sender) {
        setState(() {
          totalEstimation = widget.requestData.offerDetail![x].totalEstimation
              .toString()
              .replaceAll(".0", "");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          ApiHandler().openStartedJob(widget.requestData.id, context);
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.95,
          height: 175,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    offset: Offset.fromDirection(2))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "${changeToAmPm(widget.requestData.schedule.time)} | ${getUsDateFormat(widget.requestData.schedule.date)}",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                          textAlign: TextAlign.left),
                      Expanded(
                        child: Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            "\$" +
                                (widget.requestData.offerDetail!.length > 0
                                    ? widget.requestData.offerDetail!.any(
                                            (element) => (element.sender ==
                                                    widget.sender &&
                                                element.isRejected))
                                        ? widget.diagnosticFee.toString()
                                        : totalEstimation
                                    : widget.diagnosticFee.toString()),
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    (widget.requestData.offerDetail!.length > 0)
                                        ? Colors.blue[300]
                                        : Colors.black),
                            textAlign: TextAlign.end),
                      )
                    ],
                  )),
              Container(
                  alignment: Alignment.topLeft,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent),
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image(
                        height: 60,
                        width: 60,
                        image: AssetImage("assets/car.png"),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.requestData.serviceDetail.title,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.requestData.serviceDetail.description,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[400])),
                            ],
                          )),
                    ],
                  )),
              Container(
                  alignment: Alignment.topLeft,
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.transparent),
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 40,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 2),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget
                                    .requestData.vehiclesDetail![0].image)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 5,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                                widget.requestData.customerInfo.profilePicture),
                          )),
                      Positioned(
                          left: 100,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 50,
                              decoration:
                                  BoxDecoration(color: Colors.transparent),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.requestData.customerInfo.fullName,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[400]),
                                  ),
                                  Text(
                                      widget
                                          .requestData.vehiclesDetail![0].model,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[400])),
                                ],
                              )))
                    ],
                  )),
            ],
          ),
        ));
  }
}
