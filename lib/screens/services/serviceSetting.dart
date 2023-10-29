
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/components/globalComponents/customButton.dart';
import 'package:panda_technician/components/messageComponents/centredMessage.dart';

import 'package:panda_technician/components/tags/feeTag.dart';
import 'package:panda_technician/components/tags/toggleTag.dart';
import 'package:panda_technician/models/auth/signUp.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/services/serviceLocation.dart';
import 'package:panda_technician/store/StateProvider.dart';
import 'package:panda_technician/store/profileProvider.dart';
import 'package:provider/provider.dart';



class ServiceSetting extends StatefulWidget {
  const ServiceSetting({super.key});

  @override
  State<ServiceSetting> createState() => _ServiceSettingState();
}

class _ServiceSettingState extends State<ServiceSetting> {
  int diagnosticFee = 0;
  int hourlyFee = 0;
var profileDetail = ProfileModel(createdAt: DateTime.now(), updatedAt: DateTime.now());
bool loaded = false;
@override
void initState() {
    // TODO: implement initState
    super.initState();
    getProfiles();
  }


      void getProfiles()async {
    
    profileDetail = (await ApiHandler().getProfile())!;
    
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
      profileDetail = profileDetail;
      loaded= true;
    })); 

  
}


  @override
  Widget build(BuildContext context) {
   
  ProfileModel profile  = Provider.of<ProfileProvider>(context,listen: true).profile as ProfileModel;
 bool stateNow =  Provider.of<StateProvider>(context,listen: true).active;

    return Scaffold(
      
     appBar: AppBar(
       centerTitle: true,
       foregroundColor: Colors.black, title: const Text("Services",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black)), backgroundColor: Colors.white,),
      body: (true)? Container(
       
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding:const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[ 
            
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300,width: 1))),
                height: 100,
                child: Padding(padding:const EdgeInsets.all(10),
                child: Text("Select the services you offer and set the rate for each one. You can toggle them on and off at anytime.", textAlign: TextAlign.center,
                 style: TextStyle(
                   
                   color: Colors.grey[400])),
                )
                
                
              )
,
                 Container(
            alignment: Alignment.center,
            
            height: 140,
            width: double.infinity,
            child:const Image(image: AssetImage("assets/transparentCar.png"))
            
          ),
               Container(
            alignment: Alignment.center,
            
            height: 20,
            width: double.infinity,
            child:const Text("Mobile Technician", style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
            
          ),
             Container(
            alignment: Alignment.center,
            
            height: 60,
            width: double.infinity,
            child:Text("Mobile diagnostic and repair services.", style: TextStyle(fontSize: 16,color: Colors.grey[500]),)
            
          ),

          // ToggleTag(isToggleOn: false, title: "Diagnostic Services", callBackHandler: ((){})),
          FeeTag(title: "Diagnostic Fee",hintTexts: profile.diagnosticFee.toString() , callBackHandler: ((value){
            print("CCCC: " + value);
setState(() {
diagnosticFee = int.parse(value) ;
  

});
          })),
          FeeTag(title: "Hourly Fee",hintTexts: profile.hourlyFee.toString(), callBackHandler: ((value){
            setState(() {
            hourlyFee = int.parse(value) ;
              
            });
          })),
        SizedBox(height: 5,),
          // ToggleTag(isToggleOn: true, title: "Repair Services", callBackHandler: ((){})),
        CustomButton(buttonTitle: "Update", width: MediaQuery.of(context).size.width * 0.9, callBackFunction: ((){
          SignUp userData = SignUp();
  if(userData.city == ""){
                            userData.city = profile.city;
                          }
                          if(userData.companyName == ""){
                              userData.companyName = "";
                          }

                          // if(diagnosticFee == 0){
                          //   userData.diagnosticFee = profile.diagnosticFee;
                          // }else{
                            userData.diagnosticFee = diagnosticFee;
                          // }

                          if(userData.email == ""){
                            userData.email == profile.id;
                          }

                          if(userData.firstName == ""){
                            userData.firstName = profile.fullName.split(" ")[0];
                          }

                          if(userData.lastName == ""){
                            userData.lastName = profile.fullName.split(" ")[1];
                          }

                         
                         
                            userData.hourlyFee = hourlyFee;
                          

                          if(userData.state == ""){
                            userData.state = profile.state;
                          }

                          if(userData.street == ""){
                            userData.street = profile.street;
                          }

                          if(userData.profilePicture == ""){
                            userData.profilePicture = profile.profilePicture;
                          }

                          if(userData.zipCode == ""){
                            userData.zipCode = profile.zipCode;
                          }

                          if(userData.phoneNumber == ""){
                            userData.phoneNumber = profile.phoneNumber;
                          }

                            


                          ApiHandler().updateProfile(userData, context,profile.id);
        }))

          ],
        ),
      ),
      ) : CentredMessage(messageWidget:   Container(
  width: 100.0,
  height: 100.0,
  margin:  EdgeInsets.fromLTRB(0, 0, 10, 2),
  decoration: BoxDecoration(
    image: DecorationImage(
      
        fit: BoxFit.cover, image: AssetImage("assets/Loading.gif")),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    color: Colors.grey[300],
  ),
),)
    );
  }
}