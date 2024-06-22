import 'package:mobile/models/patient.dart';

class Feedback{
  late final int id;
  late final double rate;
  late final String comment;
  late final bool status;
  late final Patient patient;
  Feedback({
    required this.id,
    required this.rate,
    required this.comment,
    required this.status,
    required this.patient,
  });
  factory Feedback.fromJson(Map<String, dynamic> json){
    return Feedback(
      id: json['id'],
      rate: json['rate'],
      comment: json['comment'],
      status: json['status'] as bool,
      patient: Patient.fromJson(json['patient']),
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'rate': rate,
      'comment': comment,
     'status': status,
      'patient': patient.toJson(),
    };
  }
}