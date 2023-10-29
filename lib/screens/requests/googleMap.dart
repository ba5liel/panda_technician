import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:panda_technician/app/modal/auto_service/service_request_model.dart';
import 'package:panda_technician/app/modules/job_offer/job_offer.controller.dart';
import 'package:panda_technician/components/messageComponents/centredMessage.dart';
import 'package:panda_technician/services/serviceLocation.dart';
import 'package:image/image.dart' as IMG;
import 'package:http/http.dart' as http;

class MapCard extends StatefulWidget {
  MapCard({super.key, required this.myLocation, required this.locationFound});
  final LatLng myLocation;
  final bool locationFound;
  @override
  State<MapCard> createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  late GoogleMapController mapController;
  late LatLng _center;
  bool locationFound = false;
  Set<Marker> markers = Set();

  final JobOfferController jobOfferController = Get.find<JobOfferController>();

  void getOffers() async {
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void getCustomers() async {
    List<ServiceRequestModel> tempStatusRequest =
        await jobOfferController.getRequests();

    for (int x = 0; x < tempStatusRequest.length; x++) {
      if (tempStatusRequest[x].requestStatus == "PENDING") {
        var request = await http
            .get(Uri.parse(tempStatusRequest[x].vehiclesDetail![0].image));
        var bytes = await request.bodyBytes;
        IMG.Image? img = IMG.decodeImage(bytes);
        IMG.Image resized = IMG.copyResize(img!, width: 100);
        Uint8List resizedImg = Uint8List.fromList(IMG.encodePng(resized));
        Marker resultMarker = Marker(
            icon: BitmapDescriptor.fromBytes(resizedImg,
                size: Size.fromRadius(30)),
            consumeTapEvents: true,
            markerId: MarkerId(x.toString()),
            infoWindow: InfoWindow(
              //popup info
              title: 'Car Point ',
              snippet: 'Car Marker',
            ),
            position: LatLng(tempStatusRequest[x].serviceLocation.latitude,
                tempStatusRequest[x].serviceLocation.longitude),
            onTap: () {
              jobOfferController.goToServiceRequestDetailPage(
                  tempStatusRequest[x].id, tempStatusRequest[x]);
            });

        markers.add(resultMarker);
      }
    }

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    //this will be uncomnted when this is fully implmnted
  }

  @override
  void initState() {
    super.initState();
    locationFound = widget.locationFound;

    getMyLocation();
    getCustomers();
  }

  getMyLocation() async {
    permissionWithCallback(context, (() async {
      Position posi = await getLocation();
      setState(() {
        _center = LatLng(posi.latitude, posi.longitude);
        locationFound = true;
      });
    }));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _currentLocation(GoogleMapController controller) async {
    try {} on Exception {}
    Position posi = await getLocation();

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(posi.latitude, posi.longitude),
        zoom: 17.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return (widget.locationFound
        ? Container(
            margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            height: MediaQuery.of(context).size.height * 0.80,
            width: double.infinity,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              markers: markers,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.65,
              ),
              //  markers: widget.markers,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.myLocation,
                zoom: 11.0,
              ),
            ),
          )
        : CentredMessage(messageWidget: const CircularProgressIndicator()));
  }
}
