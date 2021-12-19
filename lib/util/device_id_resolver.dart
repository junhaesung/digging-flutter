import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceIdResolver {
  const DeviceIdResolver._();

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> resolveDeviceId() async {
    if (Platform.isAndroid) {
      return Future.value((await _deviceInfoPlugin.androidInfo).androidId!);
    } else if (Platform.isIOS) {
      return Future.value((await _deviceInfoPlugin.iosInfo).identifierForVendor!);
    } else {
      throw Exception("Failed to resolve device id.");
    }
  }
}