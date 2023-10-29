import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:panda_technician/app/modules/job_offer/job_offer.controller.dart';
import 'package:panda_technician/components/globalComponents/Footer.dart';
import 'package:panda_technician/components/globalComponents/emptyScreen.dart';
import 'package:panda_technician/components/offerComponents/SingleOfferCard.dart';
import 'package:panda_technician/models/requests/canceld.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  late List<ServiceRequestModel> _requestModel;
  bool loading = false;
  List canceldIndex = [];
  List<Canceld> canceld = [];

  final JobOfferController jobOfferController = Get.find<JobOfferController>();

  @override
  void initState() {
    super.initState();
    loading = false;
    _getRequests();
    _requestModel = [];
    canceldIndex = [];
    getCanceld();
  }

  void getCanceld() async {
    loading = true;
    canceld = (await ApiHandler().getCanceldRequest())!;

    loading = false;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getRequests() async {
    loading = true;
    _requestModel = await jobOfferController.getRequests();
    print("LLLLLLLLLLLLLLLLLLLL: " + _requestModel.length.toString());
    loading = false;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  isRequestEmpty() {
    bool isEmpty = true;
    for (int x = 0; x < _requestModel.length; x++) {
      if (_requestModel[x].requestStatus == "PENDING" &&
          !canceldIndex.contains(x) &&
          !canceld.any((element) => element.requestId == _requestModel[x].id)) {
        isEmpty = false;
      }
    }

    return isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              foregroundColor: Colors.black,
              title:
                  const Text("Offers", style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
            ),
            bottomNavigationBar: Footer(
                screenIndex: 1,
                homeButton: GlobalKey(),
                requestButton: GlobalKey(),
                offerButton: GlobalKey(),
                profileButton: GlobalKey()),
            body: RefreshIndicator(
                onRefresh: (() async {
                  _getRequests();
                }),
                child: (!loading)
                    ? (isRequestEmpty())
                        ? EmptyScreen(
                            title: "There Are No Offers",
                            subTitle: 'Empty Offers')

                        // CentredMessage(messageWidget: const  Text("No Jobs Avialable For Now",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.85,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: _requestModel.length,
                                itemBuilder: (context, index) {
                                  return (_requestModel[index].requestStatus ==
                                              "PENDING" &&
                                          !canceldIndex.contains(index) &&
                                          !(canceld.any((element) =>
                                              element.requestId ==
                                              _requestModel[index].id)))
                                      ? SingleOfferCard(
                                          time: _requestModel[index]
                                              .schedule
                                              .time,
                                          date: _requestModel[index]
                                              .schedule
                                              .date,
                                          requestId: _requestModel[index].id,
                                          request: _requestModel[index],
                                          cancelOffer: (() {
                                            setState(() {
                                              canceldIndex.add(index);
                                            });
                                          }),
                                        )
                                      : SizedBox();
                                }),
                          )
                    : Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 2),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/Loading.gif")),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.grey[300],
                          ),
                        ),
                      ))));
  }
}
