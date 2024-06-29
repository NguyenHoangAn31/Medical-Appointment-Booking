
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../utils/ip_app.dart';

class VNPayment{
  final ipDevice = BaseClient().ip;
  Future<void> _launchURL(String url) async {
    //const url = 'medicare-app://';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> _createPayment(String amount, String orderType, String returnUrl) async {
    final response = await http.get(
      Uri.parse('http://$ipDevice:8080/api/payment/create_payment_url?amount=$amount&orderType=$orderType&returnUrl=$returnUrl')
    );
    if (response.statusCode == 200) {
      final paymentUrl = jsonDecode(response.body);
      print(paymentUrl);
      //_launchURL(paymentUrl);
    } else {
      throw Exception('Failed to create payment');
    }
  }
}