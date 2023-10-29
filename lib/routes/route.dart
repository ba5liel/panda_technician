import 'package:flutter/material.dart';
import 'package:panda_technician/models/DetailedOffer.dart';
import 'package:panda_technician/models/auth/signUp.dart';
import 'package:panda_technician/models/requests/detailedRequest.dart';
import 'package:panda_technician/app/modal/auto_service/watchRequestDetail.dart';

import 'package:panda_technician/screens/auth/LoginScreen.dart';
import 'package:panda_technician/screens/auth/creatAccount2.dart';
import 'package:panda_technician/screens/auth/emailVerify.dart';
import 'package:panda_technician/screens/auth/signUpVerification.dart';
import 'package:panda_technician/screens/auth/verificationScreen.dart';
import 'package:panda_technician/screens/createOffer.dart';
import 'package:panda_technician/screens/notification/notifications.dart';
import 'package:panda_technician/screens/offers/displayOffer.dart';
import 'package:panda_technician/screens/offers/editOffer.dart';
import 'package:panda_technician/screens/offers/onlyDisplayOffer.dart';
import 'package:panda_technician/screens/offers/updateDIsplayOffer.dart';
import 'package:panda_technician/screens/policy/fAQ.dart';
import 'package:panda_technician/screens/policy/help.dart';
import 'package:panda_technician/screens/policy/privacyPolicy.dart';
import 'package:panda_technician/screens/policy/termAndService.dart';
import 'package:panda_technician/screens/offers/listOffers.dart';
import 'package:panda_technician/screens/profile/editPassword.dart';
import 'package:panda_technician/screens/profile/editProfile.dart';
import 'package:panda_technician/screens/profile/payment.dart';
import 'package:panda_technician/screens/profile/profile.dart';
import 'package:panda_technician/screens/requestFlow/jobDetail.dart';
import 'package:panda_technician/screens/requests/MapScreen.dart';
import 'package:panda_technician/screens/requestFlow/acceptJob.dart';
import 'package:panda_technician/screens/requests/requestes.dart';
import 'package:panda_technician/screens/services/serviceSetting.dart';
import 'package:panda_technician/screens/settings/settings.dart';

const String loginPage = 'Login';
const String homePage = 'Home';
const String jobs = 'Jobs';
const String jobDetail = 'JobDetail';
const String viewJob = 'ViewJob';
const String profile = 'Profile';
const String requests = 'Requests';
const String offers = 'Offers';
const String displayOffer = 'DisplayOffer';
const String onlyDisplayOffer = "OnlyDisplayOffer";
const String createOffer = 'CreateOffer';
const String termsAndService = 'TermsAndService';
const String privacyPolicy = 'PrivacyPolicy';
const String signup = 'Signup';
const String signupVerification = "SignupVerification";
const String serviceSetting = 'ServiceSetting';
const String editProfile = "EditProfile";
const String editPassword = "EditPassword";
const String verification = "Verification";
const String settingsName = "Settings";
const String createAccount2 = "CreateAccount2";
const String notification = "Notification";
const String emailVerify = "EmailVerify";
const String updateDisplayOffer = "UpdateDisplayOffer";
const String faq = "Faq";
const String editOffer = "EditOffer";
const String webView = "webView";
const String payment = "Payment";
const String help = "Help";

Route<dynamic> routeController(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => const Login());
    case homePage:
      return MaterialPageRoute(builder: (context) => const MapScreen());
    case jobDetail:
      return MaterialPageRoute(
          builder: (context) =>
              AcceptJob(arguments: settings.arguments as DetailedRequest));
    case createOffer:
      return MaterialPageRoute(
          builder: (context) =>
              CreateOffer(arguments: settings.arguments as DetailedRequest));
    case requests:
      return MaterialPageRoute(builder: (context) => const Requests());
    case termsAndService:
      return MaterialPageRoute(builder: (context) => const TermAndService());
    case offers:
      return MaterialPageRoute(builder: (context) => const Offers());
    case profile:
      return MaterialPageRoute(builder: (context) => const Profile());
    case privacyPolicy:
      return MaterialPageRoute(builder: (context) => const PrivacyPolicy());
    case signup:
      return MaterialPageRoute(
          builder: (context) => const SignUpVerification());
    case signupVerification:
      return MaterialPageRoute(
          builder: (context) => const SignUpVerification());
    case serviceSetting:
      return MaterialPageRoute(builder: (context) => const ServiceSetting());
    case editProfile:
      return MaterialPageRoute(builder: (context) => const EditProfile());
    case editPassword:
      return MaterialPageRoute(builder: (context) => const EditPassword());
    case help:
      return MaterialPageRoute(builder: (context) => const Help());
    case verification:
      return MaterialPageRoute(builder: (context) => const VerficationScreen());
    case createAccount2:
      return MaterialPageRoute(
          builder: (context) =>
              CreateAccount2(arguments: settings.arguments as SignUp));
    case viewJob:
      return MaterialPageRoute(
          builder: (context) =>
              JobDetail(arguments: settings.arguments as WatchDetailedRequest));
    case displayOffer:
      return MaterialPageRoute(
          builder: (context) =>
              DisplayOffer(detailedOffer: settings.arguments as DetailedOffer));
    case onlyDisplayOffer:
      return MaterialPageRoute(
          builder: (context) => OnlyDisplayOffer(
              detailedOffer: settings.arguments as DetailedOffer));
    case payment:
      return MaterialPageRoute(builder: (context) => const Payment());
    case settingsName:
      return MaterialPageRoute(builder: (context) => const Settings());
    case notification:
      return MaterialPageRoute(builder: (context) => const Notifications());
    case faq:
      return MaterialPageRoute(builder: (context) => const Faq());
    case emailVerify:
      return MaterialPageRoute(builder: (context) => const EmailVerify());
    case editOffer:
      return MaterialPageRoute(
          builder: (context) =>
              EditOffer(detailedOffer: settings.arguments as DetailedOffer));
    case updateDisplayOffer:
      return MaterialPageRoute(
          builder: (context) => UpdateDisplayOffer(
              detailedOffer: settings.arguments as DetailedOffer));
    default:
      throw ('404');
  }
}
