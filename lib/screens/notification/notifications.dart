import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_technician/app/modules/job_offer/job_offer.controller.dart';
import 'package:panda_technician/components/globalComponents/emptyScreen.dart';
import 'package:panda_technician/components/offerComponents/SpecificSingleOfferCard.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:panda_technician/services/serviceDate.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<ServiceRequestModel> statusRequest = [];
  final JobOfferController jobOfferController = Get.find<JobOfferController>();
  List<int> canceldList = [];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getOffers();
  }

  void getOffers() async {
    List<ServiceRequestModel> tempStatusRequest =
        await jobOfferController.getTechnicianRequests();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          statusRequest = tempStatusRequest;
        }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  isEmpty() {
    return !statusRequest.any((element) => element.requestStatus == "PENDING");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text("Notifications",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(0),
            child: !isEmpty()
                ? ListView.builder(
                    itemCount: statusRequest.length,
                    itemBuilder: (context, index) {
                      return (statusRequest[index].requestStatus == "PENDING" &&
                              !canceldList.contains(index))
                          ? SpecificSingleOfferCard(
                              time: changeToAmPm(
                                  statusRequest[index].schedule.time),
                              date: getUsDateFormat(
                                  statusRequest[index].schedule.date),
                              requestId: statusRequest[index].id,
                              request: statusRequest[index],
                              cancelOffer: (() {
                                setState(() {
                                  canceldList.add(index);
                                });
                              }))
                          : SizedBox();
                    })
                : EmptyScreen(
                    title: "There Are No Notifications",
                    subTitle: 'Empty Notifications')));
  }
}
