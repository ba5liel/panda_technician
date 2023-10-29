import 'package:flutter/material.dart';
import 'package:panda_technician/components/offerComponents/SpecificSingleOfferCard.dart';
import 'package:panda_technician/models/RequestsModel.dart';
import 'package:panda_technician/screens/requests/MapScreen.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';

class JobList extends StatelessWidget {
  // Wrapper Widget
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Container(
      child: const Text(""),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      children: <Widget>[
                        const Image(
                          height: 60,
                          width: 60,
                          image: AssetImage("assets/car.png"),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Column(
                              children: <Widget>[
                                const Text(
                                  "Mobile Technician",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Diagnostic Service",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[400])),
                              ],
                            )),
                      ],
                    )),
                Container(
                    height: 70,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: 120, //
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 44, 42, 42)),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "Home");
                              },
                              child: const Text(
                                'Cancel',
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
                                color: const Color.fromARGB(255, 92, 86, 86)),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "JobDetail",
                                    arguments:
                                        new ServiceRequestModelodel(id: 1));
                              },
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    ))
              ],
            ));
      },
    );
  }
}

getSpecificJobs(context, List<ServiceRequestModel> statusRequest,
    List<int> canceld, Function callBack) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: statusRequest.length,
              itemBuilder: (context, index) {
                return (statusRequest[index].requestStatus == "PENDING" &&
                        !canceld.contains(index))
                    ? SpecificSingleOfferCard(
                        time: statusRequest[index].schedule.time,
                        date: statusRequest[index].schedule.date,
                        requestId: statusRequest[index].id,
                        request: statusRequest[index],
                        cancelOffer: (() {
                          callBack();
                        }),
                      )
                    : SizedBox();
              }),
        );
      });
}

// ignore: unused_element
void _showJobList(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.white),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    children: <Widget>[
                      const Image(
                        height: 60,
                        width: 60,
                        image: AssetImage("assets/car.png"),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "Mobile Technician",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text("Diagnostic Service",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[400])),
                            ],
                          )),
                    ],
                  )),
              Container(
                  height: 70,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 120, //
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 44, 42, 42)),
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              //TODO: use Get.toinstead
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapScreen()),
                              );
                            },
                            child: const Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 92, 86, 86)),
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "JobDetail",
                                  arguments:
                                      new ServiceRequestModelodel(id: 0));
                            },
                            child: const Text(
                              'Accept',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ],
                  ))
            ],
          ));
    },
  );
}
