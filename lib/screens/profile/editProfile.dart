// ignore_for_file: depend_on_referenced_packages, unrelated_type_equality_checks, use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/components/globalComponents/customButton.dart';
import 'package:panda_technician/components/loading.dart';
import 'package:panda_technician/components/messageComponents/centredMessage.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';
import 'package:panda_technician/models/auth/signUp.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/services/AWSClient.dart';

import 'package:provider/provider.dart';
import 'package:panda_technician/store/profileProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panda_technician/services/imageServices.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late SignUp userData = SignUp();
  late ProfileModel profile;
  final ImagePicker _picker = ImagePicker();

  var profileDetail =
      ProfileModel(createdAt: DateTime.now(), updatedAt: DateTime.now());
  bool loaded = false;

  late String uriPath;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getProfiles();
  }

  void getProfiles() async {
    profile = (await ApiHandler().getProfile())!;

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          profile = profile;
          loaded = true;
        }));
  }

  void getImage(String type) async {
    late XFile? image;
    if (type == "CAMERA") {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    final path = image!.path;
    File? croped = await CropImage(path);

    final bytes = await File(croped!.path).readAsBytes();

    var timestamp = DateTime.now().millisecondsSinceEpoch;
    Loading(context);
    bool result = await AWSClientCustom()
        .uploadData("panda/image", "$timestamp" + "tech.jpg", bytes);
    if (result) {
      userData.profilePicture = "${dotenv.env['S3_BUCKET_URL']}panda/image/" +
          "$timestamp" +
          "tech.jpg";
      profile.profilePicture = "${dotenv.env['S3_BUCKET_URL']}panda/image/" +
          "$timestamp" +
          "tech.jpg";
    } else {
      DialogBox(context, "Error", "Something went wrong", "Cancel", "Ok", (() {
        Navigator.pop(context);
      }), (() {
        Navigator.pop(context);
      }));
    }

    setState(() {
      uriPath = croped!.path;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    profile = Provider.of<ProfileProvider>(context, listen: true).profile;
    firstName.text = profile.fullName.split(" ")[0];
    lastName.text = profile.fullName.split(" ")[1];
    street.text = profile.street;
    city.text = profile.city;
    state.text = profile.state;
    zipCode.text = profile.zipCode.toString();

    return SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 243, 243, 243),
            appBar: AppBar(
              centerTitle: true,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.black,
              title: const Text("Edit Profile",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              backgroundColor: Colors.white,
            ),
            body: (true)
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            )
                          ]),
                          child: Row(children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width * 0.32,
                              height: 130,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              color: Colors.transparent,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      left: 1,
                                      width: 140,
                                      height: 120,
                                      child: CircleAvatar(
                                          radius: 80,
                                          backgroundColor: Colors.grey.shade400,
                                          backgroundImage: NetworkImage(
                                              profile.profilePicture))),
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      width: 45,
                                      height: 45,
                                      child: TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 220,
                                                  child: Column(children: [
                                                    InkWell(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                              borderRadius: BorderRadius.circular(20),

                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 2,
                                                              offset: const Offset(
                                                                  0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            0, 15, 0, 0),
                                                        height: 60,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                              Icons.image,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 5,),
                                                            Text("Browse Gallery", style: TextStyle(fontWeight: FontWeight.bold),)
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
                                                        alignment:
                                                            Alignment.center,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        decoration:
                                                            BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 2,
                                                              offset: const Offset(
                                                                  0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            0, 15, 0, 0),
                                                        height: 60,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: const [
                                                            Icon(
                                                              Icons.camera_alt_outlined,
                                                              size: 28,
                                                            ),
                                                            SizedBox(width: 5,),
                                                            Text("Use a Camera", style: TextStyle(fontWeight: FontWeight.bold),)
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 100,
                              child: Column(children: <Widget>[
                                Text(profile.fullName,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Text(profile.id,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[500]))
                              ]),
                            )
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Text(
                            "First Name",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        TextFiledCustom(
                            useController: true,
                            updateCallback: ((value) {
                              userData.firstName = value;
                            }),
                            preIcon: Icons.person,
                            hintText: profile.fullName.split(" ")[0],
                            isPassword: false,
                            isZipCode: false,
                            isEmail: false,
                            isNumber: false,
                            width: MediaQuery.of(context).size.width * 0.9),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Text(
                            "Last Name",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        TextFiledCustom(
                            useController: true,
                            updateCallback: ((value) {
                              userData.lastName = value;
                            }),
                            preIcon: Icons.person,
                            hintText: profile.fullName.split(" ")[1],
                            isPassword: false,
                            isZipCode: false,
                            isEmail: false,
                            isNumber: false,
                            width: MediaQuery.of(context).size.width * 0.9),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Text(
                            "Street",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        TextFiledCustom(
                            useController: true,
                            updateCallback: ((value) {
                              userData.street = value;
                            }),
                            preIcon: Icons.home,
                            hintText: profile.street,
                            isPassword: false,
                            isZipCode: false,
                            isEmail: false,
                            isNumber: false,
                            width: MediaQuery.of(context).size.width * 0.9),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Text(
                            "City",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        TextFiledCustom(
                            useController: true,
                            updateCallback: ((value) {
                              userData.city = value;
                            }),
                            preIcon: Icons.location_city,
                            hintText: profile.city,
                            isPassword: false,
                            isZipCode: false,
                            isEmail: false,
                            isNumber: false,
                            width: MediaQuery.of(context).size.width * 0.9),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Text(
                            "State",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        TextFiledCustom(
                            useController: true,
                            updateCallback: ((value) {
                              userData.state = value;
                            }),
                            preIcon: Icons.location_city,
                            hintText: profile.state,
                            isPassword: false,
                            isZipCode: false,
                            isEmail: false,
                            isNumber: false,
                            width: MediaQuery.of(context).size.width * 0.9),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: const Text(
                            "ZipCode",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        TextFiledCustom(
                            useController: true,
                            updateCallback: ((value) {
                              userData.zipCode = int.parse(value);
                            }),
                            preIcon: Icons.code,
                            hintText: profile.zipCode.toString(),
                            isPassword: false,
                            isZipCode: true,
                            isEmail: false,
                            isNumber: true,
                            width: MediaQuery.of(context).size.width * 0.9),
                        CustomButton(
                          buttonTitle: "Edit Password",
                          callBackFunction: () {
                            Navigator.pushNamed(context, "EditPassword");
                          },
                          width: MediaQuery.of(context).size.width * 0.9,
                          buttonColor: Colors.grey.shade800,
                        ),
                        CustomButton(
                          buttonTitle: "Update",
                          callBackFunction: () {
                            if (userData.city == "") {
                              userData.city = profile.city;
                            }
                            if (userData.companyName == "") {
                              userData.companyName = "";
                            }

                            if (userData.diagnosticFee == "") {
                              userData.diagnosticFee = profile.diagnosticFee;
                            }

                            if (userData.email == "") {
                              userData.email == profile.id;
                            }

                            if (userData.firstName == "") {
                              userData.firstName =
                                  profile.fullName.split(" ")[0];
                            }

                            if (userData.lastName == "") {
                              userData.lastName =
                                  profile.fullName.split(" ")[1];
                            }

                            if (userData.hourlyFee == 0) {
                              userData.hourlyFee = profile.hourlyFee;
                            }

                            if (userData.diagnosticFee == 0) {
                              userData.diagnosticFee = profile.diagnosticFee;
                            }

                            if (userData.state == "") {
                              userData.state = profile.state;
                            }

                            if (userData.street == "") {
                              userData.street = profile.street;
                            }

                            if (userData.profilePicture == "") {
                              userData.profilePicture = profile.profilePicture;
                            }

                            if (userData.zipCode == 0) {
                              userData.zipCode = profile.zipCode;
                            }

                            if (userData.phoneNumber == "") {
                              userData.phoneNumber = profile.phoneNumber;
                            }

                            ApiHandler()
                                .updateProfile(userData, context, profile.id);
                          },
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    )),
                  )
                // ignore: dead_code
                : CentredMessage(
                    messageWidget: Container(
                      width: 100.0,
                      height: 100.0,
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/Loading.gif")),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.grey[300],
                      ),
                    ),
                  )));
  }
}
