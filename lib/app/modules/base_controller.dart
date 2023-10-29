import 'package:get/get.dart';
import 'package:panda_technician/core/exceptions/app_http_exceptions.dart';
import 'package:panda_technician/helper/dialog_helper.dart';

class BaseController extends GetxController {
  bool loading = true;

  void showGetXLoading([hide = true]) {
    // if (!hide) uncomment to disable spinner
    DialogHelper.showGetXLoading();
  }

  void hideGetXLoading([hide = true]) {
    // if (!hide) uncomment to disable spinner
    DialogHelper.hideGetXLoading();
  }

  void handleError(Object error) {
    hideGetXLoading();
    String message = "Something went wrong!";

    // if (error is GqlBadRequestException) {
    //   message = error.message;
    // }

    // if (error is GqlForbiddenException) {
    //   message = error.message;
    // }

    // if (error is GqlInternalServerException) {
    //   message = error.message;
    // }

    // if (error is GqlUnauthenticatedException) {
    //   message = error.message;
    // }

    // if (error is GqlUnknownException) {
    //   message = error.message;
    // }
    if (error is HttpException) {
      message = error.message;
    }

    // if (ConfigReader.showDevExceptions) {
    //   message += " $error";
    // }

    DialogHelper.showGetXError(message);
  }
}
