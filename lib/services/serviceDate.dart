


import 'package:intl/intl.dart';




String getUsDateFormat(String date){
  
final DateTime now = DateTime.parse(date);
  final DateFormat formatter = DateFormat('MM-dd-yyyy');
  final String formatted = formatter.format(now);

  if(formatted.split("-").length >0){
    return formatted.split("-").join("/");

  }else{
    return formatted;
  }


}

String changeToAmPm(String time){
final DateTime now = DateTime.parse(time);
  final DateFormat formatter = DateFormat('hh:mm a');
  final String formatted = formatter.format(now);



    return formatted;

}