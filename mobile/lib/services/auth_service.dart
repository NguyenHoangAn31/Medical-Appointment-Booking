import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile/ultils/ip_app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClient{
  final ipDevice = BaseClient().ip;
  final storage = const FlutterSecureStorage();
  Future<dynamic> login(String phone, String smsCode) async{
    var data = {
      'phone': phone,
      'smsCode': smsCode,
      'provider': 'phone',
    };
    var url = Uri.parse('https://$ipDevice:8080/api/auth/login');
    var response = await http.post(url, body: data);

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    }else{
      print(response.statusCode);
    }
  }

  Future<bool> checkToken(String phone) async{
    var data = {
      'phone': phone,
      'provider': 'phone',
    };
    var url = Uri.parse('https://$ipDevice:8080/api/auth/check-refresh-token');
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['token'] != null) {
        // Lưu token vào secure storage
        await storage.write(key: 'authToken', value: jsonResponse['token']);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }

  }

  Future<String?> getAuthToken() async {
    return await storage.read(key: 'authToken');
  }

  Future<void> setKeyCode(String smsCode) async {
    var url = Uri.parse('https://$ipDevice:8080/api/auth/set-keycode');
    await http.post(url, body: smsCode);
  }

  Future<void> logout() async {
    await storage.delete(key: 'authToken');
  }
}