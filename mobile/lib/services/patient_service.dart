

import 'dart:convert';

import '../models/patient.dart';
import '../utils/ip_app.dart';
import 'package:http/http.dart' as http;

class PatientClient{
  final ipDevice = BaseClient().ip;

  Future<Patient> getPatientById(int patientId) async {
    var url = Uri.parse('http://$ipDevice:8080/api/patient/patientid/$patientId');
    final result = await http.get(url);
      if (result.statusCode == 200) {
        var jsonResponse = json.decode(result.body);
        // print(jsonResponse);
        return Patient.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load patient by patientId');
      }
  }

  Future<Patient> getPatientByUserId(int userId) async{
      var url = Uri.parse('http://$ipDevice:8080/api/patient/$userId');
      final result = await http.get(url);
      if(result.statusCode == 200){
        var jsonResponse = json.decode(result.body);
        return Patient.fromJson(jsonResponse);
      }else{
        throw Exception('Failed to load patient by userId');
      }
  }

}