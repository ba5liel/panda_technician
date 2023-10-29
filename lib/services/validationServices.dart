import 'package:panda_technician/models/auth/signUp.dart';
import 'package:panda_technician/models/messages/message.dart';

bool emailValidate(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);

  if (emailValid) {
    return true;
  } else {
    return false;
  }
}

Message signUpFormValidation(
    SignUp userDetail, bool termsAndConditions, String zipCode) {
  // ignore: unused_local_variable
  bool isFormValid = true;

  if (userDetail.zipCode.toString().length != 5 &&
      userDetail.street == "" &&
      userDetail.city == "" &&
      userDetail.state == "" &&
      userDetail.hourlyFee == 0 &&
      userDetail.diagnosticFee == 0) {
    isFormValid = false;
    Message message = Message(
        success: false,
        message: "Please fil out the above form",
        formIndex: 404);

    return message;
  }

  if (!emailValidate(userDetail.email)) {
    isFormValid = false;
    Message message = Message(
      success: false,
      message: "Incorrect Email",
    );

    return message;
  }

  if (zipCode.length != 5) {
    isFormValid = false;
    print("ZZZZZZZZZZZZZ: " + zipCode);
    Message message =
        Message(success: false, message: "Invalid Zip Code", formIndex: 4);

    return message;
  }

  if (userDetail.profilePicture == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Profile Picture Not Added");

    return message;
  }

  if (userDetail.city == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "City Not Added", formIndex: 2);

    return message;
  }
  if (userDetail.firstName == "") {
    isFormValid = false;
    Message message = Message(success: false, message: "First Name Not Added");

    return message;
  }
  if (userDetail.lastName == "") {
    isFormValid = false;
    Message message = Message(success: false, message: "Last Name Not Added");

    return message;
  }
  if (userDetail.phoneNumber == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Phone Number  Not Added");

    return message;
  }
  if (userDetail.state == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "State Not Added", formIndex: 3);

    return message;
  }

  if (userDetail.street == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Street Not Added", formIndex: 1);

    return message;
  }

  if (userDetail.diagnosticFee == 0) {
    isFormValid = false;
    Message message = Message(
        success: false, message: "Diagnostic Fee Not Added", formIndex: 6);

    return message;
  }

  if (userDetail.hourlyFee == 0) {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Hourly Fee Not Added", formIndex: 5);

    return message;
  }

  if (!termsAndConditions) {
    isFormValid = false;
    Message message = Message(
        success: false,
        message: "You have to Agree With the Terms & Conditions");
    return message;
  }

  Message message =
      Message(success: true, message: "Account Created Succesfully");

  return message;
}

Message signUpFormValidation1(SignUp userDetail, bool termsAndConditions) {
  // ignore: unused_local_variable
  bool isFormValid = true;

  if (!emailValidate(userDetail.email)) {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Incorrect Email", formIndex: 5);

    return message;
  }

  if (userDetail.profilePicture == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Profile Picture Not Added");

    return message;
  }

  if (userDetail.firstName == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "First Name Not Added", formIndex: 1);

    return message;
  }
  if (userDetail.lastName == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Last Name Not Added", formIndex: 2);

    return message;
  }
  if (userDetail.phoneNumber == "") {
    isFormValid = false;
    Message message = Message(
        success: false, message: "Phone Number  Not Added", formIndex: 3);

    return message;
  }

  if (userDetail.password == "") {
    isFormValid = false;
    Message message =
        Message(success: false, message: "Password  Not Added", formIndex: 4);

    return message;
  } else {
    if (!is8Char(userDetail.password)) {
      isFormValid = false;
      Message message = Message(
          success: false,
          message: "Password must be at list 8 characters",
          formIndex: 4);

      return message;
    } else if (!containsLowerCase(userDetail.password)) {
      isFormValid = false;
      Message message = Message(
          success: false,
          message: "Password must contain lowerCase letters",
          formIndex: 4);

      return message;
    } else if (!containsUpperCase(userDetail.password)) {
      isFormValid = false;
      Message message = Message(
          success: false,
          message: "Password must contain upperCase Letter",
          formIndex: 4);

      return message;
    } else if (!containsNumb(userDetail.password)) {
      isFormValid = false;
      Message message = Message(
          success: false,
          message: "Password must contain numbers",
          formIndex: 4);

      return message;
    } else if (!containsSymbols(userDetail.password)) {
      isFormValid = false;
      Message message = Message(
          success: false,
          message: "Password must contain symbols",
          formIndex: 4);

      return message;
    }
  }

  Message message =
      Message(success: true, message: "Account Created Succesfully");

  return message;
}

bool is8Char(String password) {
  if (password.length >= 8) {
    return true;
  } else {
    return false;
  }
}

bool containsUpperCase(String password) {
  if (password.contains(RegExp(r'[A-Z]'))) {
    return true;
  } else {
    return false;
  }
}

bool containsLowerCase(String password) {
  if (password.contains(RegExp(r'[a-z]'))) {
    return true;
  } else {
    return false;
  }
}

bool containsNumb(String password) {
  if (password.contains(RegExp(r'[0-9]'))) {
    return true;
  } else {
    return false;
  }
}

bool containsSymbols(String password) {
  final symbols = RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']');
  if (password.contains(symbols)) {
    return true;
  } else {
    return false;
  }
}
