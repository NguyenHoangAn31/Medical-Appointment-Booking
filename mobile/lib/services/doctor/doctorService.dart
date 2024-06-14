import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/doctor.dart';



// Lấy all doctor
Future<List<Doctor>> getDoctors() async {
  var url = 'http://8080/api/doctor/all';
  var data = await http.get(url as Uri);
  var jsonData = json.decode(data.body);
  List<Doctor>  doctorList = [];
  for (var i = 0; i < jsonData.length; i++) {
    doctorList.add(Doctor.fromJson(jsonData[i]));
  }
  return doctorList;
}