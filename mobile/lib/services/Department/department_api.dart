import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/department.dart';
import 'package:mobile/models/doctor.dart';
import 'package:mobile/utils/ip_app.dart';


Future<List<Department>> getDepartments() async{
  final ipDevice = BaseClient().ip;
  final data = await http.get(Uri.parse("http://$ipDevice:8080/api/department/all"));
  if (data.statusCode == 200) {
    List jsonResponse = json.decode(data.body);
    return jsonResponse.map((department) => Department.fromJson(department)).toList();
  } else {
    throw Exception('Failed to load departments');
  }
}

// findBy Doctor with department
Future<List<Doctor>> getDoctorByDepartmentId(int departmentId) async {
  final ipDevice = BaseClient().ip;
  try {
    if (departmentId <= 0) {
      final response = await http.get(Uri.parse("http://$ipDevice:8080/api/doctor/all"));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((doctor) => Doctor.fromJson(doctor)).toList();
      } else {
        throw Exception('Failed to load all doctors');
      }
    } else {
      final response = await http.get(Uri.parse("http://$ipDevice:8080/api/doctor/related-doctor/$departmentId"));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((data) => Doctor.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load doctors');
      }
    }
  } catch (e) {
    throw Exception('Failed to load doctors. Error: $e');
  }
}



