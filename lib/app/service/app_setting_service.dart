import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:panda_technician/app/modal/setting/app_config.dart';
import 'package:panda_technician/app/modal/setting/app_setting.dart';
import 'package:panda_technician/app/service/app_storage_service.dart';
import 'package:panda_technician/core/constants/storage_keys.dart';

class AppSettingService extends GetxService {
  late AppSetting setting;
  late AppConfig config;

  AppStorageService appStorageService = Get.find<AppStorageService>();

  AppSettingService() {
    Map<String, dynamic> data = appStorageService.readMap(
        StorageKeys.settingBoxKey, AppSetting().toMap())!;

    setting = AppSetting.fromMap(data);
  }

  Future<void> init() async {
    await dotenv.load(fileName: ".env");
    config = AppConfig.fromMap(dotenv.env);
  }

  void save() {
    appStorageService.write(StorageKeys.settingBoxKey, setting.toMap());
  }
}
