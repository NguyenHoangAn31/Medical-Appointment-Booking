import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/appointment.dart';
import '../utils/ip_app.dart';

class AppointmentClient{
  final ipDevice = BaseClient().ip;

  Future<List<Appointment>> fetchAppointmentPatient(int patientId, String status) async {
    final response = await http.get(
      Uri.parse(
          'http://$ipDevice:8080/api/appointment/appointment-schedule-patientId-and-status/$patientId/$status'),
    );
    if (response.statusCode == 200) {
      List result = json.decode(response.body);
      //print(result);
      return result.map((appointment) => Appointment.fromJson(appointment)).toList();
    } else {
      throw Exception('Failed to load appointment');
    }
  }

  Future<Appointment> fetchAppointmentById(int appointmentId) async {
    final response = await http.get(
      Uri.parse(
          'http://$ipDevice:8080/api/appointment/$appointmentId'),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return Appointment.fromJson(result);
    } else {
      throw Exception('Failed to load appointment');
    }
  }

}