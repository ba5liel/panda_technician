// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panda_technician/models/profile.dart';
import 'package:panda_technician/store/StateProvider.dart';
import 'package:panda_technician/store/profileProvider.dart';
import 'package:provider/provider.dart';

class AllProviders extends StatelessWidget {
  AllProviders({super.key, required this.initialApp});
  GetMaterialApp initialApp;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => StateProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(
            profile: ProfileModel(
                createdAt: DateTime.now(), updatedAt: DateTime.now())),
      )
    ], child: initialApp);
  }
}
