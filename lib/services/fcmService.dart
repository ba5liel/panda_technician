import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';


getTokenFCM () async{
  FirebaseMessaging.instance.getToken().then((token) async {
    final prefs = await SharedPreferences.getInstance();
prefs.setString("fcmToken", token.toString());
        print("MY TOKEN: " + token.toString());
    });
}

getTokenFcmFast()async{
    FirebaseMessaging.instance.getToken().then((token)  {
    // final prefs = await SharedPreferences.getInstance();
// prefs.setString("fcmToken", token.toString());
//         print("MY TOKEN: " + token.toString());
        return token.toString();
    });
}

Future<void> firebaseMessagingBackgroundHandler(message) async{
  await Firebase.initializeApp();
  

  print("THIS IS THE MESSAGE " + message.toString());
  print("THIS IS THE MESSAGE " + message.id);
}