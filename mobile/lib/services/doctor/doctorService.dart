import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/doctor.dart';

import '../../ultils/ip_app.dart';

// Lấy all doctor
Future<List<Doctor>> getDoctors() async {
  final ipDevice = BaseClient().ip;
  var url = 'http://$ipDevice:8080/api/doctor/all';
  var data = await http.get(url as Uri);
  var jsonData = json.decode(data.body);
  List<Doctor>  doctorList = [];
  for (var i = 0; i < jsonData.length; i++) {
    doctorList.add(Doctor.fromJson(jsonData[i]));
  }
  return doctorList;
}


// Lấy doctor theo id
Future<Doctor> getDoctorById(int id) async {
  final ipDevice = BaseClient().ip;
  final response = await http.get(Uri.parse("http://$ipDevice:8080/api/doctor/$id"));
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return Doctor.fromJson(jsonData);
  } else {
    throw Exception('Failed to load doctors');
  }
}