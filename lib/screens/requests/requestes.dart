import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/app/modules/job_offer/job_offer.controller.dart';
import 'package:panda_technician/components/flow/headerButtons.dart';
import 'package:panda_technician/components/flow/mobileTechnician.dart';
import 'package:panda_technician/components/globalComponents/Footer.dart';
import 'package:panda_technician/components/globalComponents/emptyScreen.dart';
import 'package:panda_technician/models/RequestsModel.dart';
import 'package:panda_technician/models/offer/RejectedOffers.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/models/requests/canceld.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:panda_technician/store/profileProvider.dart';
import 'package:provider/provider.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  int _selectedIndex = 0;
  bool loading = false;
  late List<ServiceRequestModel> statusRequest = [];
  List<Canceld> canceld = [];
  // bool isCanceldEmpty = true;
  var profileDetail =
      ProfileModel(createdAt: DateTime.now(), updatedAt: DateTime.now());
  List<RejectedOffer> estimationList = [];
  bool loaded = false;

  final JobOfferController jobOfferController = Get.find<JobOfferController>();

  @override
  void initState() {
    super.initState();
    loading = false;
    // _getRequests();
    getProfiles();
    _getTechnicianRequests();

    // getCanceld();
  }

  void getProfiles() async {
    profileDetail = await ApiHandler().getProfile();
    //  estimationList =  (await ApiHandler().getMyEstimation(profileDetail.id))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          profileDetail = profileDetail;
          loaded = true;
        }));
  }

  void changeRequestComponent(int index) {
    if (index == 2) {}
    setState(() {
      _selectedIndex = index;
    });
  }

  late ServiceRequestModelodel reque = ServiceRequestModelodel(
    customerAvater:
        "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png",
    customerName: "Tadiiyos",
    customerCar:
        "https://www.autocar.co.uk/sites/autocar.co.uk/files/range-rover-2022-001-tracking-front.jpg",
  );

  void _getTechnicianRequests() async {
    loading = true;

    statusRequest = await jobOfferController.getTechnicianRequests();
    canceld = (await ApiHandler().getCanceldRequest())!;

    if (canceld.length > 0) {
      // isCanceldEmpty = false;
    }

// print("YESS: "+ statusRequest[0].customerId);
    loading = false;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void getCanceld() async {
    loading = true;
    canceld = (await ApiHandler().getCanceldRequest())!;

    loading = false;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  isAcceptedEmpty() {
    var accepted =
        statusRequest.any((element) => element.requestStatus == "ACCEPTED");
    var arrived =
        statusRequest.any((element) => element.requestStatus == "ARRIVED");
    var onMyWay =
        statusRequest.any((element) => element.requestStatus == "ON_MY_WAY");
    var underWay = statusRequest
        .any((element) => element.requestStatus == "SERVICE_UNDERWAY");
    //  var rejectedO =  statusRequest.any((element) => (element.offerDetail.length > 0? !element.offerDetail[element.offerDetail.length-1].isRejected : true));
    if (accepted || arrived || onMyWay || underWay) {
      return false;
    } else {
      return true;
    }
  }

  isCompletedEmpty() {
    var completed = statusRequest.any((element) =>
        element.requestStatus == "COMPLETED" ||
        (element.offerDetail!.length > 0
            ? element.offerDetail![element.offerDetail!.length - 1].isRejected
            : false));
    return !completed;
  }

  isCanceldEmpty() {
    var canceld =
        statusRequest.any((element) => element.requestStatus == "CANCELED");
    return !canceld;
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel profile =
        Provider.of<ProfileProvider>(context, listen: true).profile;

    return SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: Footer(
              screenIndex: 2,
              homeButton: GlobalKey(),
              requestButton: GlobalKey(),
              offerButton: GlobalKey(),
              profileButton: GlobalKey(),
            ),
            backgroundColor: Colors.grey[200],
            body: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: Column(children: <Widget>[
                HeaderButton(
                    selectedIndex: _selectedIndex,
                    updateComponent: changeRequestComponent),
                (isAcceptedEmpty() && _selectedIndex == 0 && !loading)
                    ? Column(children: [
                        SizedBox(
                          height: 40,
                        ),
                        EmptyScreen(
                            title: "No Accepted Requests",
                            subTitle: " Accepted Requests")
                      ])
                    : (isCompletedEmpty() && _selectedIndex == 1 && !loading)
                        ? Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              EmptyScreen(
                                  title: "No Completed Requests",
                                  subTitle: " Completed Requests")
                            ],
                          )
                        : (isCanceldEmpty() && _selectedIndex == 2 && !loading)
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  EmptyScreen(
                                      title: "No Canceld Requests",
                                      subTitle: " Canceld Requests")
                                ],
                              )
                            : Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                width: MediaQuery.of(context).size.width * 0.95,
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                decoration: const BoxDecoration(
                                    color: Colors.transparent),
                                child: (!loading)
                                    ? ListView.builder(
                                        itemCount: statusRequest.length,
                                        itemBuilder: (context, index) {
                                          return (_selectedIndex == 0)
                                              ? ((statusRequest[index].requestStatus == "ACCEPTED" ||
                                                          statusRequest[index].requestStatus ==
                                                              "ARRIVED" ||
                                                          statusRequest[index].requestStatus ==
                                                              "ON_MY_WAY" ||
                                                          statusRequest[index].requestStatus ==
                                                              "SERVICE_UNDERWAY") &&
                                                      !statusRequest[index]
                                                          .isScheduled &&
                                                      !(canceld.any((can) =>
                                                          can.requestId ==
                                                          statusRequest[index]
                                                              .id)) &&
                                                      (statusRequest[index].offerDetail!.length > 0
                                                          ? !statusRequest[index]
                                                              .offerDetail![
                                                                  statusRequest[index].offerDetail!.length -
                                                                      1]
                                                              .isRejected
                                                          : true))
                                                  ? MobileTechnicianComponent(
                                                      requestData:
                                                          statusRequest[index],
                                                      diagnosticFee:
                                                          profileDetail
                                                              .diagnosticFee,
                                                      sender: profile.id,
                                                    )
                                                  : ((statusRequest[index].requestStatus == "ACCEPTED" ||
                                                              statusRequest[index].requestStatus ==
                                                                  "ARRIVED" ||
                                                              statusRequest[index].requestStatus ==
                                                                  "ON_MY_WAY") &&
                                                          statusRequest[index].isScheduled &&
                                                          !(canceld.any((can) => can.requestId == statusRequest[index].id)) &&
                                                          (statusRequest[index].offerDetail!.length > 0 ? !statusRequest[index].offerDetail![statusRequest[index].offerDetail!.length - 1].isRejected : true))
                                                      ? Container(
                                                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                          decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10))),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "Rescheduled",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              MobileTechnicianComponent(
                                                                requestData:
                                                                    statusRequest[
                                                                        index],
                                                                diagnosticFee:
                                                                    profileDetail
                                                                        .diagnosticFee,
                                                                sender:
                                                                    profile.id,
                                                              )
                                                            ],
                                                          ))
                                                      : SizedBox()
                                              : (_selectedIndex == 1)
                                                  ? ((statusRequest[index].requestStatus == "COMPLETED" && !(canceld.any((can) => can.requestId == statusRequest[index].id)) || (statusRequest[index].offerDetail!.length > 0 ? statusRequest[index].offerDetail!.any((element) => (element.sender == profile.id && element.isRejected)) : false))
                                                      ? MobileTechnicianComponent(
                                                          requestData:
                                                              statusRequest[
                                                                  index],
                                                          diagnosticFee:
                                                              profileDetail
                                                                  .diagnosticFee,
                                                          sender: profile.id,
                                                        )
                                                      : SizedBox())
                                                  : ((_selectedIndex == 2)
                                                      ? statusRequest[index].requestStatus == "CANCELED"
                                                          ? MobileTechnicianComponent(
                                                              requestData:
                                                                  statusRequest[
                                                                      index],
                                                              diagnosticFee:
                                                                  profileDetail
                                                                      .diagnosticFee,
                                                              sender:
                                                                  profile.id,
                                                            )
                                                          : SizedBox()
                                                      : SizedBox());

                                          //  (canceld.any((can)=> can.requestId != statusRequest[index].id))?

                                          // mobileTechnician(requestData: statusRequest[index]) :
                                          // CentredMessage(messageWidget: const Text("No Canceld job so far",style: TextStyle(fontSize: 15),)) :
                                          // mobileTechnician(requestData: statusRequest[index]) : SizedBox();
                                        })
                                    : Container(
                                        width: 100.0,
                                        height: 100.0,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 10, 2),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/Loading.gif")),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: Colors.grey[300],
                                        ),
                                      )),
              ]),
            )));
  }
}
