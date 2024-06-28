import 'dart:convert';
import 'dart:developer';

import 'package:mobile/utils/ip_app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClient {
  final ipDevice = BaseClient().ip;
  final storage = const FlutterSecureStorage();
  Future<String> login(String phone, String smsCode) async {
    var data = {
      'username': phone,
      'keyCode': smsCode,
      'provider': 'phone',
    };
    var url = Uri.parse('https://$ipDevice:8080/api/auth/login');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return 'Otp is Invalid';
    }
  }

  Future<bool> checkToken(String phone) async {
    var data = {
      'username': phone,
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

  Future<bool> sendOtp(String username) async {
    var data = {
      'username': username,
      'provider': 'phone',
    };

    var url = Uri.parse('http://$ipDevice:8080/api/auth/send-otp');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200 && response.body == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getAuthToken() async {
    return await storage.read(key: 'authToken');
  }

  Future<void> setKeyCode(String phone, String keyCode) async {
    var data = {'username': phone, 'keycode': keyCode, 'provider': 'phone'};
    var url = Uri.parse('http://$ipDevice:8080/api/auth/set-keycode');
    await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
  }

  Future<void> logout() async {
    await storage.delete(key: 'authToken');
  }

  Future<bool> checkPhone(String username) async {
    var url = Uri.parse('http://$ipDevice:8080/api/user/search/$username');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkAccount(String username) async {
    log("Call function to check account");

    var data = {
      'username': username,
      'provider': 'phone',
    };
    var url = Uri.parse('http://$ipDevice:8080/api/auth/check-account');

    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 && responseBody['result'] == 'true') {
      log("This account exists");
      return true;
    } else if (responseBody['result'] == 'disable') {
      log("This account has been disabled");
      return false;
    } else {
      log("This account not exist");

      return false;
    }
  }

  Future<String?> register(
      String fullName, String phone, String email, String keyCode) async {
    var data = {
      'fullName': fullName,
      'phone': phone,
      'provider': 'phone',
      'email': email,
      'keyCode': keyCode,
      'status': 1,
      'roleId': 1
    };
    var url = Uri.parse('http://$ipDevice:8080/api/user/register');
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      return null;
    }
  }
}
