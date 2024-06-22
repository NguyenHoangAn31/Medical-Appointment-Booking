import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart';


class IPAddress {
  Future<String> getIpv4Address() async {
    try {
      final List<NetworkInterface> interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            return addr.address;
          }
        }
      }
      return 'Failed to get IPv4 address';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
