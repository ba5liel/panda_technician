
import 'package:url_launcher/url_launcher.dart';


void sendSms(String phoneNumber)async{
  Uri sms = Uri.parse('sms:$phoneNumber?body=Dear Customer how can i help you');
  await launchUrl(sms);
}


void callClient(String phoneNumber) async{
  await launchUrl(Uri.parse('tel://$phoneNumber'));
}

// +14041234567
String formatPhoneNumber(String phoneNumber){
  String finalNumber = "";
  String firstPart = "(" + phoneNumber[2] + phoneNumber[3] + phoneNumber[4] +")";
  String secondPart =  phoneNumber[5] + phoneNumber[6] + phoneNumber[7]+"-" + phoneNumber[8] + phoneNumber[9] + phoneNumber[10] + phoneNumber[11];

  finalNumber= firstPart + " " + secondPart;
  return finalNumber;
}