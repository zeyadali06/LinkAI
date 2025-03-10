import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class IPManager {
  IPManager();

  late final String ip;

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
          ip = '10.0.2.2';
          return '10.0.2.2';
        } else {
          ip = '192.168.1.8';
          return '192.168.1.8';
        }
      } else if (Platform.isWindows || Platform.isMacOS) {
        ip = '127.0.0.1';
        return '127.0.0.1';
      } else {
        ip = '0.0.0.0';
        return '0.0.0.0';
      }
    } catch (_) {
      ip = '0.0.0.0';
      return '0.0.0.0';
    }
  }
}
