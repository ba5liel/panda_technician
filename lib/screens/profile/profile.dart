// ignore_for_file: depend_on_referenced_packages, unnecessary_cast

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/app/service/app_setting_service.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:panda_technician/components/messageComponents/centredMessage.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
import 'package:panda_technician/components/tags/singleTag.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/screens/profile/stripeWebview.dart';
import 'package:panda_technician/services/firstTimeRun.dart';
import 'package:panda_technician/store/profileProvider.dart';
import '../../components/globalComponents/Footer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // ProfileModel profile = ProfileModel(updatedAt: DateTime.now(), createdAt: DateTime.now());
  var profile =
      ProfileModel(createdAt: DateTime.now(), updatedAt: DateTime.now());
  bool loaded = false;

  String strapiToken = "";
  Map<String, dynamic> stripeRetrieveAccountData = {};
  AppSettingService _appSettingService = Get.find<AppSettingService>();

  @override
  void initState() {
    super.initState();
    // profile  = Provider.of<ProfileProvider>(context,listen: true).profile as ProfileModel;
    getStripeToken();
    stripeRetrieveAccount();
    getProfiles();
  }

  Future<void> getStripeToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("apiToken");

    var response = await http.get(
      Uri.parse(
          '${_appSettingService.config.baseURL}/account/connectAccountLink'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    setState(() {
      strapiToken = json.decode(response.body)["url"] ?? "empty";
    });
    // strapiToken = json.decode(response.body)["url"];
  }

  Future<void> stripeRetrieveAccount() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("apiToken");

    var response = await http.post(
      Uri.parse(
          '${_appSettingService.config.baseURL}/account/get/connectedAccount'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    setState(() {
      stripeRetrieveAccountData = json.decode(response.body)["data"];
    });
  }

  void getProfiles() async {
    profile = (await ApiHandler().getProfile());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        profile = profile;
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel profile =
        Provider.of<ProfileProvider>(context, listen: true).profile;
    if (profile.id == "") {
      Provider.of<ProfileProvider>(context, listen: false)
          .changeProfileProvider(profile);
    }

    return SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: Footer(
                screenIndex: 3,
                homeButton: GlobalKey(),
                requestButton: GlobalKey(),
                offerButton: GlobalKey(),
                profileButton: GlobalKey()),
            backgroundColor: Colors.white,
            body: (true)
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 80,
                          margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade600,
                                    blurRadius: 3,
                                    offset: Offset.fromDirection(2.7))
                              ]),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
                                  width: 60,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.green[200]),
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.grey.shade400,
                                    foregroundImage:
                                        NetworkImage(profile.profilePicture),
                                  )),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width * 0.50,
                                height: 70,
                                margin: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                                decoration: const BoxDecoration(
                                    color: Colors.transparent),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(profile.fullName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Text(profile.id,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[400]))
                                    ]),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "EditProfile");
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.blue[300]),
                                ),
                              )
                            ],
                          )),
                      SingleTag(
                          ico: Icons.miscellaneous_services_sharp,
                          title: "Services",
                          callBackHandler: (() {
                            Navigator.pushNamed(context, "ServiceSetting");
                          })),
                      SingleTag(
                          ico: Icons.payments_outlined,
                          title:
                              stripeRetrieveAccountData["details_submitted"] ==
                                          null ||
                                      stripeRetrieveAccountData[
                                              "details_submitted"] ==
                                          false
                                  ? "Payments"
                                  : "Payment Already linked",
                          callBackHandler: (() async {
                            if (stripeRetrieveAccountData[
                                        "details_submitted"] !=
                                    null ||
                                stripeRetrieveAccountData[
                                        "details_submitted"] ==
                                    false) {
                              // Navigator.pop(context);
                              DialogBox(context, "Message", "Already Connected",
                                  "Cancel", "Ok", (() {
                                Navigator.pop(context);
                              }), (() {
                                Navigator.pop(context);
                              }));
                              return;
                            }
                            // Navigator.pushNamed(context, "Payment");
                            final prefs = await SharedPreferences.getInstance();
                            var token = prefs.getString("apiToken");
                            Loading(context);
                            var response = await http.get(
                              Uri.parse(
                                  '${_appSettingService.config.baseURL}/account/connectAccountLink'),
                              headers: {
                                HttpHeaders.authorizationHeader: "Bearer $token"
                              },
                            );

                            // setState(() {
                            //   strapiToken = json.decode(response.body)["url"] ?? "empty";
                            // });

                            var authUrl =
                                json.decode(response.body)["url"] ?? "empty";

                            if (authUrl == "empty") {
                              Navigator.pop(context);
                              DialogBox(context, "Message", "Already Connected",
                                  "Cancel", "Ok", (() {
                                Navigator.pop(context);
                              }), (() {
                                Navigator.pop(context);
                              }));
                            } else {
                              Navigator.pop(context);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => StripeWebView(
                                            stripeUrl: Uri.parse(strapiToken),
                                          )));
                            }
                          })),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 22,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: const Text(
                          "More",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SingleTag(
                          ico: Icons.pause_presentation_rounded,
                          title: "Terms of Service",
                          callBackHandler: (() {
                            Navigator.pushNamed(context, "TermsAndService");
                          })),
                      SingleTag(
                          ico: Icons.privacy_tip,
                          title: "Privacy Policy",
                          callBackHandler: (() {
                            Navigator.pushNamed(context, "PrivacyPolicy");
                          })),
                      SingleTag(
                          ico: Icons.help,
                          title: "Help",
                          callBackHandler: (() {
                            Navigator.pushNamed(context, "Help");
                          })),
                      SingleTag(
                          ico: Icons.question_answer,
                          title: "FAQ",
                          callBackHandler: (() {
                            Navigator.pushNamed(context, "Faq");
                          })),
                      SingleTag(
                          ico: Icons.settings,
                          title: "Settings",
                          callBackHandler: (() {
                            Navigator.pushNamed(context, "Settings");
                          })),
                      SingleTag(
                          ico: Icons.logout,
                          title: "LogOut",
                          callBackHandler: (() {
                            logout(context);
                          })),
                      SizedBox(
                        height: 20,
                      )
                      //  Align(
                      //       alignment: Alignment.center,
                      //       child: TextButton(
                      //           onPressed: () {
                      //             DialogBox(context, "Message", "Are you sure you want to delete your account", "No", "Yes", ((){
                      //                 Navigator.pop(context);
                      //             }), ((){
                      //               ApiHandler().deleteAccount(profile.id, context);
                      //             }));

                      //           },
                      //           child: const Text(
                      //             "Delete Account",
                      //             style: TextStyle(
                      //                 fontSize: 16, color: Colors.red),
                      //             textAlign: TextAlign.left,
                      //           )),
                      //     ),
                    ])),
                  )
                : CentredMessage(
                    messageWidget: Container(
                      width: 100.0,
                      height: 100.0,
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 2),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/Loading.gif")),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.grey[300],
                      ),
                    ),
                  )));
  }
}
