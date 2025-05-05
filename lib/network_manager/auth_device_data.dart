import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:status/components/print_value.dart';
import 'package:status/helpers/storage_helper.dart';

class UserAuthenticationApis{

  ///****************** Get Device Unique ID ******************///

  Future<String> getId() async {
    DeviceInfoPlugin? deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      printValue("Device Id:- ${iosDeviceInfo.identifierForVendor}");
      StorageHelper().setDeviceId(iosDeviceInfo.identifierForVendor!);
      StorageHelper().setDeviceType('iOS');
      return iosDeviceInfo.identifierForVendor!;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      printValue("Device Id:- ${androidDeviceInfo.id}");
      StorageHelper().setDeviceId(androidDeviceInfo.id);
      StorageHelper().setDeviceType('Android');
      return androidDeviceInfo.id;
    }
  }
}
