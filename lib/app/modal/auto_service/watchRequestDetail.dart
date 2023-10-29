import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:panda_technician/models/service/service.dart';
import 'package:panda_technician/models/vehicle/vehicle.dart';

class WatchDetailedRequest {
  WatchDetailedRequest({
    required this.request,
    required this.vehicle,
    required this.service,
  });

  ServiceRequestModel request;
  Vehicle vehicle;
  Service service;
}
