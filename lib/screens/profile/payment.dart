import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/components/globalComponents/customButton.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:panda_technician/components/tags/singleTag.dart';
import 'package:panda_technician/models/bankInfo.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/services/AWSClient.dart';
import 'package:panda_technician/store/profileProvider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panda_technician/services/imageServices.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int diagnosticFee = 0;
  int hourlyFee = 0;
  final ImagePicker _picker = ImagePicker();
  String bankName = "";
  String accountNumber = "";
  String routingNumber = "";
  String wwwi = "";
  bool w9err = false;
  bool bankNameError = false;
  bool accountNumberError = false;
  bool routingNumberError = false;
  List<BankInfo> bankBody = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBankInfo();
    w9err = false;
  }

  getBankInfo() async {
    List<BankInfo> newInfo = await ApiHandler().getBankDetail();
    setState(() {
      bankBody = newInfo;
    });
  }

  getImage() async {
    //  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ["jpeg","jpg","png"] );

// if (result != null) {
//   File file = File(result.files.single.path);
// } else {

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    final path = image!.path;

    File? croped = await CropImage(path);
    final bytes = await File(croped!.path).readAsBytes();

    var timestamp = DateTime.now().millisecondsSinceEpoch;
    Loading(context);

    bool result = await AWSClientCustom()
        .uploadData("panda/image", "$timestamp" + "tech.jpg", bytes);
    if (result) {
      setState(() {
        wwwi = "${dotenv.env['S3_BUCKET_URL']}panda/image/" +
            "$timestamp" +
            "tech.jpg";
        Navigator.pop(context);
      });
      DialogBox(
          context, "Success", "SuccessFully uploaded w9 image", "Cancel", "Ok",
          (() {
        Navigator.pop(context);
        this.setState(() {
          w9err = false;
        });
      }), (() {
        this.setState(() {
          w9err = false;
        });
        Navigator.pop(context);
      }));
    } else {
      Navigator.pop(context);

      DialogBox(context, "Error", "Something went wrong", "Cancel", "Ok", (() {
        Navigator.pop(context);
      }), (() {
        Navigator.pop(context);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel profile = Provider.of<ProfileProvider>(context, listen: true)
        .profile as ProfileModel;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text("Payment Info",
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 1))),
                    height: 50,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                                "Fill in your bank Information and W9 agreement",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[400])),
                            //  TextButton(
                            //     onPressed: () async {
                            //       // await launchUrl(Uri.parse("https://w9.pdffiller.com/"));
                            //       await launch("https://smallpdf.com/handle-widget#url=https://assets.ctfassets.net/l3l0sjr15nav/4xRfXx1TQwGtHK3ERORlY7/507fd38210d22f4ca5fc49efa85e32de/fw9.pdf");
                            //     },
                            //     child: const Text(
                            //       "W9 Form Filler",
                            //       style: TextStyle(
                            //           fontSize: 14, color: Color.fromRGBO(51, 188, 132, 1)),
                            //       textAlign: TextAlign.left,
                            //     )
                            //     ),
                          ],
                        ))),
                Container(
                    alignment: Alignment.center,
                    height: 140,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 70,
                        ),
                        Text(
                          "Bank Information",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    )),
                SizedBox(
                  height: 5,
                ),
                SingleTag(
                    ico: Icons.format_align_justify,
                    title: "Upload W9 Form",
                    err: w9err,
                    callBackHandler: (() {
                      getImage();
                    })),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: const Text(
                    "Bank Name",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                TextFiledCustom(
                    updateCallback: ((value) {
                      setState(() {
                        bankName = value;
                        bankNameError = false;
                      });
                    }),
                    preIcon: Icons.food_bank,
                    isError: bankNameError,
                    width: MediaQuery.of(context).size.width * 0.9,
                    hintText: bankBody.length > 0
                        ? bankBody[0].bankName
                        : "Bank Name",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: false),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: const Text(
                    "Account Number",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                TextFiledCustom(
                    updateCallback: ((value) {
                      setState(() {
                        accountNumber = value;
                        accountNumberError = false;
                      });
                    }),
                    preIcon: Icons.numbers,
                    isError: accountNumberError,
                    width: MediaQuery.of(context).size.width * 0.9,
                    hintText:
                        bankBody.length > 0 ? bankBody[0].id : "Account Number",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: true),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: const Text(
                    "Routing Number",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                TextFiledCustom(
                    updateCallback: ((value) {
                      setState(() {
                        routingNumber = value;
                        routingNumberError = false;
                      });
                    }),
                    preIcon: Icons.numbers,
                    isError: routingNumberError,
                    width: MediaQuery.of(context).size.width * 0.9,
                    hintText: bankBody.length > 0
                        ? bankBody[0].routingNumber
                        : "Routing Number",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: true),

                SizedBox(
                  height: 5,
                ),

                // ToggleTag(isToggleOn: true, title: "Repair Services", callBackHandler: ((){})),
                CustomButton(
                    buttonTitle: bankBody.length == 0 ? "Add" : "Update",
                    width: MediaQuery.of(context).size.width * 0.9,
                    callBackFunction: (() {
                      if (bankBody.length == 0) {
                        if (wwwi == "") {
                          this.setState(() {
                            w9err = true;
                          });
                          DialogBox(
                              context,
                              "Missing Field",
                              "Upload W9 Form before adding details",
                              "Close",
                              "Ok", (() {
                            Navigator.pop(context);
                          }), (() {
                            Navigator.pop(context);
                          }));
                        } else if (bankName == "") {
                          this.setState(() {
                            bankNameError = true;
                          });
                          DialogBox(context, "Missing Field",
                              "Bank Name Not Added", "Close", "Ok", (() {
                            Navigator.pop(context);
                          }), (() {
                            Navigator.pop(context);
                          }));
                        } else if (accountNumber == "") {
                          this.setState(() {
                            accountNumberError = true;
                          });
                          DialogBox(context, "Missing Field",
                              "Account Number Not Added", "Close", "Ok", (() {
                            Navigator.pop(context);
                          }), (() {
                            Navigator.pop(context);
                          }));
                        } else if (routingNumber == "") {
                          this.setState(() {
                            routingNumberError = true;
                          });
                          DialogBox(context, "Missing Field",
                              "Routing Number Not Added", "Close", "Ok", (() {
                            Navigator.pop(context);
                          }), (() {
                            Navigator.pop(context);
                          }));
                        } else {
                          ApiHandler().addBankInfo(wwwi, bankName,
                              accountNumber, routingNumber, context);
                        }
                      } else {
                        ApiHandler().updateBankInfo(
                            wwwi == "" ? bankBody[0].w9 : wwwi,
                            bankName == "" ? bankBody[0].bankName : bankName,
                            accountNumber == ""
                                ? bankBody[0].id
                                : accountNumber,
                            routingNumber == ""
                                ? bankBody[0].routingNumber
                                : routingNumber,
                            context);
                      }
                    })),

                (bankBody.length != 0
                    ? CustomButton(
                        buttonTitle: "View Info",
                        width: MediaQuery.of(context).size.width * 0.9,
                        callBackFunction: (() {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: Column(children: <Widget>[
                                      Image.network(bankBody[0].w9),
                                      Text(
                                        "Bank Name: ${bankBody[0].bankName}",
                                      ),
                                      Text("Account Number: ${bankBody[0].id}"),
                                      Text(
                                          "Routing Number: ${bankBody[0].routingNumber}"),
                                    ]),
                                  ),
                                );
                              });
                        }))
                    : SizedBox(height: 15)),

                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ));
  }
}
