

import 'package:panda_technician/models/offer.dart';
import 'package:panda_technician/models/requests/detailedRequest.dart';

class DetailedOffer{
  DetailedRequest detailedRequest;
  Offer offer;

  DetailedOffer({
    required this.detailedRequest,
    required this.offer,
  });
  
}