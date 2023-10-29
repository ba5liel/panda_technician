import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:panda_technician/apiHandler/apiHandler.dart';
import 'package:panda_technician/app/modal/auto_service/subscription_request_event.dart';
import 'package:panda_technician/app/modules/base_controller.dart';
import 'package:panda_technician/app/repository/auto_service_repository.dart';
import 'package:panda_technician/app/service/app_auth_service.dart';
import 'package:panda_technician/app/service/app_logger.dart';
import 'package:panda_technician/helper/dialog_helper.dart';
import 'package:panda_technician/models/offer.dart';
import 'package:panda_technician/models/requests/detailedRequest.dart';
import 'package:panda_technician/app/modal/auto_service/watchRequestDetail.dart';
import 'package:panda_technician/models/service/service.dart';
import 'package:panda_technician/models/vehicle/vehicle.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';

class JobOfferController extends BaseController {
  final AutoServiceRepository _repository = AutoServiceRepository();
  final AppAuthService _appAuthService = Get.find<AppAuthService>();
  final AppLoggerService _l = Get.find<AppLoggerService>();

  final StreamController<ServiceRequestModel> requestStreamController =
      StreamController.broadcast();

  RxList<ServiceRequestModel> serviceRequests = RxList<ServiceRequestModel>([]);

  Rx<ServiceRequestModel?> acceptedServiceRequest =
      Rx<ServiceRequestModel?>(null);

  void listenForRequestCreate() {
    _repository
        .onNewServiceRequest(_appAuthService.user!.id)
        .asyncMap((event) async {
      _l.logger.i("[listenForRequest] $event");
      if (event.data != null) {
        SubscriptionRequestEvent data =
            SubscriptionRequestEvent.fromMap(event.data!);

        var detailedRequest = await _repository.getServiceRequestById(data.id);
        serviceRequests.add(detailedRequest);
        requestStreamController.add(detailedRequest);
      }
    });
  }

  void listenForRequestUpdate() {
    _repository
        .onUpdateServiceRequest(_appAuthService.user!.id)
        .listen((event) async {
      _l.logger.i("[listenForRequest] $event");
      if (event.data != null) {
        print("[event.data type] ${event.data?.runtimeType}");
        var rawData = json.decode(event.data);
        SubscriptionRequestEvent data =
            SubscriptionRequestEvent.fromMap(rawData["onUpdateServiceRequest"]);
        var detailedRequest = await _repository.getServiceRequestById(data.id);
        if (data.requestStatus != 'PENDING') return;
        serviceRequests.add(detailedRequest);

        print("serviceRequests ${serviceRequests.length} $serviceRequests");
        requestStreamController.add(detailedRequest);
      }
    });
  }

  // void listenForStatusRequest(String status) {
  //   requestStreamController.stream.asyncMap((event) {
  //     if (event.status == status) {}
  //   });
  // }

  Future<void> rejectJob(
      String requestId, String technicianId, String customerId) async {
    try {
      showGetXLoading();
      await _repository.rejectJob(requestId, technicianId, customerId);
      hideGetXLoading();
      DialogHelper.showGetXDialogBox(
          "Success", "Successfully Rejected Job", "Cancel", "Ok", () {
        Get.offAndToNamed("Offers");
      }, () {
        Get.offAndToNamed("Offers");
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> acceptJob(String requestId, ServiceRequestModel request) async {
    try {
      showGetXLoading();
      var detailedRequest = await _repository.acceptJob(requestId, request);
      hideGetXLoading();

      Vehicle vehicles = await ApiHandler().getVehicle(request.vehicleId[0]);
      Service service = await ApiHandler().getService(request.serviceId);

      Get.toNamed("JobDetail",
          arguments: DetailedRequest(
              request: detailedRequest,
              vehicle: vehicles,
              service: service,
              estimation: Offer(items: [])));
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<ServiceRequestModel>> getRequests() async {
    try {
      return await _repository.getAllServiceRequests();
    } catch (e) {
      handleError(e);
    }
    return [];
  }

  Future<List<ServiceRequestModel>> getTechnicianRequests() async {
    try {
      return await _repository.getTechnicianRequests();
    } catch (e) {
      handleError(e);
    }
    return [];
  }

  @override
  void dispose() {
    requestStreamController.close();
    super.dispose();
  }

  Future<void> goToServiceRequestDetailPage(
      String id, ServiceRequestModel request) async {
    showGetXLoading();

    var detailedRequest = await _repository.getServiceRequestById(id);
    Vehicle vehicles = await ApiHandler().getVehicle(request.vehicleId[0]);
    Service service = await ApiHandler().getService(request.serviceId);
    hideGetXLoading();
    Get.toNamed("ViewJob",
        arguments: WatchDetailedRequest(
            request: detailedRequest, vehicle: vehicles, service: service));
  }
}
