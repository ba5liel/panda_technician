// ignore_for_file: file_names, depend_on_referenced_packages, use_build_context_synchronously, await_only_futures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/components/globalComponents/popUpMessage.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
import 'package:panda_technician/models/messages/message.dart';
import 'package:panda_technician/models/auth/signUp.dart';
import 'package:panda_technician/services/AWSClient.dart';
import 'package:panda_technician/services/validationServices.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final ImagePicker _picker = ImagePicker();
  SignUp userDetail = SignUp();

  var confirmedPassword = "";
  var errorForm = 0;
  var toBeconfirmed = "";
  var updated = true;

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    userDetail.userRole = "technician";
    confirmedPassword = "";
    updated = true;
  }

  bool isAgreed = false;
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  String uriPath = "";
  // Pick an image
  void getImage(String type) async {
    late XFile? image;
    if (type == "CAMERA") {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    final path = image!.path;
    File? croped = await _cropImage(path);
    final bytes = await File(croped!.path).readAsBytesSync();

    var timestamp = DateTime.now().millisecondsSinceEpoch;
    Loading(context);

    bool result = await AWSClientCustom()
        .uploadData("panda/image", "$timestamp" + "tech.jpg", bytes);
    if (result) {}

    userDetail.profilePicture = "${dotenv.env['S3_BUCKET_URL']}panda/image/" +
        "$timestamp" +
        "tech.jpg";

    setState(() {
      uriPath = croped!.path;
      Navigator.pop(context);
    });
  }

  Future<File?> _cropImage(String path) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: const Text("Sign Up", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              height: 140,
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                      top: 0,
                      width: 140,
                      height: 120,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                            getImage("CAMERA");
                          },
                          child: uriPath == ""
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.grey.shade400,
                                  backgroundImage:
                                      const AssetImage("assets/avater.png"))
                              : Container(
                                  alignment: Alignment.center,
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      shape: BoxShape.circle,
                                      color: Colors.transparent),
                                  child: Image.file(File(uriPath),
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center),
                                ))),
                  Positioned(
                      top: 75,
                      left: MediaQuery.of(context).size.width * 0.45,
                      width: 45,
                      height: 45,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  child: Column(children: [
                                    InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 15, 0, 0),
                                        height: 60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.image,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Browse Gallery",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);

                                        getImage("GALLERY");
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Center(
                                      child: Text(
                                        'OR',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 15, 0, 0),
                                        height: 60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Use a Camera",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);

                                        getImage("CAMERA");
                                      },
                                    ),
                                  ]),
                                );
                              });
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey.shade500,
                          size: 45,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFiledCustom(
                    updateCallback: ((value) {
                      userDetail.firstName = value;
                    }),
                    preIcon: Icons.person,
                    hintText: "First Name",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: false,
                    isError: errorForm == 1,
                  ),
                  TextFiledCustom(
                    updateCallback: ((value) {
                      userDetail.lastName = value;
                    }),
                    preIcon: Icons.person,
                    hintText: "Last Name",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: false,
                    isError: errorForm == 2,
                  ),
                  TextFiledCustom(
                    updateCallback: ((value) {
                      userDetail.email = value;
                    }), // this is to avoid they are watching me so i wont' be doing what they are thiking about
                    preIcon: Icons.email,
                    hintText: "Email",
                    isPassword: false,
                    isZipCode: false,
                    isEmail: true,
                    isNumber: false,
                    isError: errorForm == 5,
                  ),
                  TextFiledCustom(
                    updateCallback: ((value) {
                      userDetail.password = value;
                      if (is8Char(value) &&
                          containsLowerCase(value) &&
                          containsUpperCase(value) &&
                          containsSymbols(value) &&
                          containsNumb(value)) {
                        errorForm = 0;
                      }
                      setState(() {
                        confirmedPassword = value;
                        updated = !updated;
                      });
                    }),
                    preIcon: Icons.person,
                    hintText: "Password",
                    isPassword: true,
                    isZipCode: false,
                    isEmail: false,
                    isNumber: false,
                    isError: errorForm == 4,
                  ),
                  ((userDetail.password.isNotEmpty)
                      ? Container(
                          width: 340,
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Icon(
                                  color: is8Char(userDetail.password)
                                      ? Colors.green[400]
                                      : Colors.grey[600],
                                  Icons.circle,
                                  size: 11,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 11),
                                    "Minimem 8 charachters")
                              ]),
                              const SizedBox(
                                width: 5,
                              ),
                              Row(children: <Widget>[
                                Icon(
                                  color: containsNumb(userDetail.password)
                                      ? Colors.green[400]
                                      : Colors.grey[600],
                                  Icons.circle,
                                  size: 11,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 11),
                                    "Numbers[0-9]")
                              ]),
                            ],
                          ),
                        )
                      : const SizedBox()),
                  ((userDetail.password.isNotEmpty)
                      ? Container(
                          width: 340,
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Icon(
                                  color: containsLowerCase(userDetail.password)
                                      ? Colors.green[400]
                                      : Colors.grey[600],
                                  Icons.circle,
                                  size: 11,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 11),
                                    "LowerCase Letters[a-z]")
                              ]),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(children: <Widget>[
                                Icon(
                                  color: containsUpperCase(userDetail.password)
                                      ? Colors.green[400]
                                      : Colors.grey[600],
                                  Icons.circle,
                                  size: 11,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 11),
                                    "UpperCase Letters[A-Z]")
                              ]),
                            ],
                          ),
                        )
                      : const SizedBox()),
                  ((userDetail.password.isNotEmpty)
                      ? Container(
                          width: 340,
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Icon(
                                  color: containsSymbols(userDetail.password)
                                      ? Colors.green[400]
                                      : Colors.grey[600],
                                  Icons.circle,
                                  size: 11,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 11),
                                    "Symbols")
                              ]),
                            ],
                          ),
                        )
                      : const SizedBox()),
                  TextFiledCustom(
                      updateCallback: ((value) {
                        if (userDetail.password != value) {}
                        toBeconfirmed = value;
                      }),
                      preIcon: Icons.person,
                      hintText: "Confirm Password",
                      isPassword: true,
                      isZipCode: false,
                      isEmail: false,
                      isNumber: false,
                      password: confirmedPassword,
                      isUpdated: updated),
                  Container(
                    width: 340,
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InternationalPhoneNumberInput(
                      inputBorder: InputBorder.none,
                      maxLength: Platform.isAndroid ? 12 : 20,
                      onInputChanged: (PhoneNumber number) {
                        userDetail.phoneNumber = number.phoneNumber.toString();
                        controller.selection = TextSelection.collapsed(
                            offset: controller.text.length);
                      },
                      onInputValidated: (bool value) {},
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controller,
                      formatInput: true,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: 340, //
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(51, 188, 132, 1)),
                margin: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () async {
                    if (toBeconfirmed != confirmedPassword) {
                      showPurchaseDialog(context, "Error Occured",
                          "Invalid confirmation password",
                          isApiCall: false);
                    } else {
                      Message message =
                          signUpFormValidation1(userDetail, isAgreed);
                      if (message.success) {
                        Navigator.pushNamed(context, "CreateAccount2",
                            arguments: userDetail);
                      } else {
                        setState(() {
                          errorForm = message.formIndex;
                        });

                        DialogBox(context, "Error Occured", message.message,
                            "Cancel", "Ok", (() {
                          Navigator.pop(context);
                        }), (() {
                          Navigator.pop(context);
                        }));
                        // showPurchaseDialog(
                        //     context, "Error Occured", message.message,
                        //     isApiCall: false);
                      }
                    }
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ]),
        ));
  }
}
