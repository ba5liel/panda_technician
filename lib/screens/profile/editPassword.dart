
import 'package:flutter/material.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/TextFiledCustom.dart';
import 'package:panda_technician/components/globalComponents/customButton.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/routes/route.dart';
import 'package:panda_technician/store/profileProvider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';


class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

 var newPassword = "";
 var currentPassword = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    newPassword = "";
  }

  
  
TextEditingController a = TextEditingController();
TextEditingController b = TextEditingController();
TextEditingController c = TextEditingController();
TextEditingController d = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
      ProfileModel profile  = Provider.of<ProfileProvider>(context,listen: true).profile as ProfileModel;

    return Scaffold(

      body: SingleChildScrollView(child: Column(children: <Widget>[

  Container(
            alignment: Alignment.center,
            height: 300,
            width: double.infinity,
            margin:const EdgeInsets.fromLTRB(0, 40, 0,50),
            child: Image(image: NetworkImage(profile.profilePicture))
            
          ),

          const Text("Please Fill The Forms below",textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
,
const SizedBox(
  height: 20,
),

  const SizedBox(height: 15,),

 

  TextFiledCustom(updateCallback: ((value){
setState((){
            currentPassword = value;
        });
  }), preIcon: Icons.password  , hintText: "Current Password", isPassword: true, isZipCode: false, isEmail: false, isNumber: false,width: MediaQuery.of(context).size.width * 0.9,),

  const SizedBox(height: 15,),
  TextFiledCustom(updateCallback: ((value){
setState((){
            newPassword = value;
        });
  }), preIcon: Icons.password  , hintText: "New Password", isPassword: true, isZipCode: false, isEmail: false, isNumber: false,width: MediaQuery.of(context).size.width * 0.9,),

  const SizedBox(height: 15,),
  

  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      CustomButton(buttonTitle: "Reset Password", callBackFunction: (){
          ApiHandler().changePassword(currentPassword, newPassword, context);

      },width: MediaQuery.of(context).size.width * 0.9,)
        
  ],)
      
      ]) ,
     ) );;
  }
}