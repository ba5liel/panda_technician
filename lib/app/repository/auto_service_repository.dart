import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:panda_technician/app/service/app_api_service.dart';
import 'package:panda_technician/models/requests/detailedRequestM.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:amplify_core/src/types/api/graphql/graphql_response.dart'
    as gql;

class AutoServiceRepository {
  AppApiService _apiService = Get.find<AppApiService>();

  Future<void> rejectJob(
      String requestId, String technicianId, String customerId) async {
    await _apiService.authPost("canceledByTechnician", data: {
      "requestId": requestId,
      "technicianId": technicianId,
      "customerId": customerId
    });
  }

  Future<DetailedRequestM> acceptJob(
      String requestId, ServiceRequestModel request) async {
    //TODO: implement appsync
    var response =
        await _apiService.authPatch("/request/accept/$requestId", data: {});

    return DetailedRequestM.fromMap(response.data);
  }

  Future<List<ServiceRequestModel>> getAllServiceRequests() async {
    var response = await _apiService.authGet("/request/all");

    List<ServiceRequestModel> _model = List.from(response.data)
        .map<ServiceRequestModel>((e) => ServiceRequestModel.fromMap(e))
        .toList();

    return _model;
  }

  Future<List<ServiceRequestModel>> getTechnicianRequests() async {
    var response = await _apiService.authGet("/request/technician");

    List<ServiceRequestModel> _model = List.from(response.data["list"])
        .map<ServiceRequestModel>((e) => ServiceRequestModel.fromJson(e))
        .toList();

    return _model;
  }

  Future<ServiceRequestModel> getServiceRequestById(String requestId) async {
    var response = await _apiService.authGet("/request/$requestId");

    return ServiceRequestModel.fromMap(response.data);
  }

  Stream<gql.GraphQLResponse<dynamic>> onNewServiceRequest(String customerId) {
    String graphQLDocument = '''
    subscription OnNewServiceRequest(\$customerId: String!) {
      onNewServiceRequest(customerId: \$customerId) {
        id
        technicianId
        requestStatus
      }
    }
  ''';

    var operation = Amplify.API.subscribe(
      GraphQLRequest<dynamic>(
        document: graphQLDocument,
        variables: {"customerId": customerId},
      ),
      onEstablished: () => print('Subscription established'),
    );

    return operation;
  }

  Stream<gql.GraphQLResponse<dynamic>> onUpdateServiceRequest(
      String technicianId) {
    String graphQLDocument = '''
    subscription onUpdateServiceRequest {
      onUpdateServiceRequest {
        id
        customerId
        technicianId
        requestStatus
      }
    }
  ''';

    var operation = Amplify.API.subscribe(
      GraphQLRequest<dynamic>(
        document: graphQLDocument,
        variables: {"technicianId": technicianId},
      ),
      onEstablished: () {
        print('Subscription established');
      },
    );
    operation.listen((event) {
      print(event);
    });
    return operation;
  }
}
