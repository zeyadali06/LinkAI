import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class IPManager {
  const IPManager();

  Future<String> getDeviceIP() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

        bool isEmulator = androidInfo.isPhysicalDevice == false ||
            androidInfo.model.toLowerCase().contains("sdk") ||
            androidInfo.manufacturer.toLowerCase().contains("google") ||
            androidInfo.hardware.toLowerCase().contains("goldfish") ||
            androidInfo.fingerprint.contains("generic");

        if (isEmulator) {
          return '10.0.2.2';
        } else {
          return '192.168.1.8';
        }
      } else if (Platform.isWindows || Platform.isMacOS) {
        return '127.0.0.1';
      } else {
        return '0.0.0.0';
      }
    } catch (_) {
      return '0.0.0.0';
    }
  }
}
