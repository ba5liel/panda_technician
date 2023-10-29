import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/messageComponents/dialogBox.dart';

import 'package:panda_technician/components/tags/singleTag.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/store/StateProvider.dart';
import 'package:panda_technician/store/profileProvider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int diagnosticFee = 0;
  int hourlyFee = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel profile = Provider.of<ProfileProvider>(context, listen: true)
        .profile as ProfileModel;
    bool stateNow = Provider.of<StateProvider>(context, listen: true).active;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text("Settings",
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
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Welcome to the settings Screen.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[400])),
                    )),

                SingleTag(
                    ico: Icons.email,
                    title: "Update Email",
                    callBackHandler: (() async {
                      var response =
                          await ApiHandler().sendOtp(profile.id, context);
                      if (response) {
                        Navigator.pushNamed(context, "EmailVerify");
                      } else {
                        DialogBox(context, "Error", "Something Went Wrong",
                            "Cancel", "Ok", (() {
                          Navigator.pop(context);
                        }), (() {
                          Navigator.pop(context);
                        }));
                      }
                    })),

                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        DialogBox(
                            context,
                            "Message",
                            "Are you sure you want to delete your account",
                            "No",
                            "Yes", (() {
                          Navigator.pop(context);
                        }), (() {
                          ApiHandler().deleteAccount(profile.id, context);
                        }));
                      },
                      child: const Text(
                        "Delete Account",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.left,
                      )),
                ),

                // ToggleTag(isToggleOn: false, title: "Diagnostic Services", callBackHandler: ((){})),
              ],
            ),
          ),
        ));
  }
}
