



import 'package:flutter/foundation.dart';
import 'package:panda_technician/models/profile.dart';


class ProfileProvider with ChangeNotifier{

ProfileModel profile =  ProfileModel(createdAt: DateTime.now(), updatedAt: DateTime.now());
ProfileProvider({
  required this.profile 
});

void changeProfileProvider(ProfileModel newProfile){
    profile = newProfile;
    notifyListeners();
}


}


// bool active = false;
// StateProvider({
//   this.active = false
// });

// void changeTechnicianState(bool newState){
//   active = newState;
//  notifyListeners();
// }