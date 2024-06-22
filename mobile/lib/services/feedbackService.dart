import 'package:mobile/models/feedback.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ultils/ip_app.dart';

Future<List<Feedback>> getFeedbackByDoctorIdTake2(int doctorId) async {
  final ipDevice = BaseClient().ip;
  final response = await http.get(Uri.parse("http://$ipDevice:8080/api/feedback/$doctorId"));
  if (response.statusCode == 200) {
    List feedbackJson = json.decode(response.body);
    return feedbackJson.map((json) => Feedback.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load feedback');
  }
}

Future<List<Feedback>> getFeedbackByDoctorId(int doctorId) async {
  final ipDevice = BaseClient().ip;
  final data = await http.get(Uri.parse("http://$ipDevice:8080/api/feedback/$doctorId"));
  if (data.statusCode == 200) {
    List jsonResponse = jsonDecode(data.body);
    return jsonResponse.map((feedback) => Feedback.fromJson(feedback)).toList();
  } else {
    throw Exception('Failed to load feedback by doctorId');
  }
}