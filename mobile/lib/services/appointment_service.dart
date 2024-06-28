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
      return result.map((appointment) => Appointment.fromJson(appointment)).toList();
    } else {
      throw Exception('Failed to load appointment');
    }
  }

  Future<int> getDoctorIdByScheduleId(int scheduleId) async {
    final response = await http.get(Uri.parse("http://$ipDevice:8080/api/schedules/schedule-doctor/$scheduleId"));
    if (response.statusCode == 200) {
      //var jsonData = json.decode(response.body);
      print('testing');
      //int doctorId = jsonData['doctorId']; // Giả sử bạn muốn lấy doctorId từ jsonData
      return 1;
    } else {
      throw Exception('Failed to load schedule');
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


  Future<bool> checkAppointmentForPatient(int doctorId, int patientId, String dayCurrent ) async {
    final response = await http.get(
      Uri.parse(
          'http://$ipDevice:8080/api/appointment/check-schedule-for-patient/$doctorId/$patientId/$dayCurrent'),
    );

    if (response.statusCode == 200 && response.body == 'true') {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> checkAppointmentForPatientClinic(int patientId, String dayCurrent, String clinicHour ) async {
    final response = await http.get(
      Uri.parse(
          'http://$ipDevice:8080/api/appointment/check-schedule-for-patient-clinic/check/$patientId/$dayCurrent/$clinicHour'),
    );

    if (response.statusCode == 200 && response.body == 'true') {
      return true;
    } else {
      return false;
    }
  }

  // Future<Appointment> appointmentCreate() async {
  //   final response = await http.get(
  //     Uri.parse(
  //         'http://$ipDevice:8080/api/appointment/$appointmentId'),
  //   );
  //   if (response.statusCode == 200) {
  //     final result = json.decode(response.body);
  //     return Appointment.fromJson(result);
  //   } else {
  //     throw Exception('Failed to load appointment');
  //   }
  // }





}