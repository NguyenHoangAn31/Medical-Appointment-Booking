import 'package:network_info_plus/network_info_plus.dart';

Future<String> getIPAddress() async {
  final info = NetworkInfo();
  String? wifiIP = await info.getWifiIP();
  return wifiIP ?? '';
}