import 'package:mobile/models/feedback.dart';
import 'package:mobile/models/working.dart';

import 'department.dart';

class Doctor{
  late final int id;
  late final String fullName;
  late final String title;
  late final String gender;
  late final String birthday;
  late final String address;
  late final String image;
  late final double price;
  late final String biography;
  late final int experience;
  late final double rate;
  late final int userId;
  late final bool status;
  late final Department department;

  final List<Working> working;
  final List<Feedback> feedback;
  Doctor({required this.id, required this.fullName, required this.title, required this.gender, required this.birthday,
  required this.address, required this.image, required this.price, required this.biography, required this.experience, required this.rate,
     required this.userId, required this.status, required this.department, required this.working, required this.feedback});

  factory Doctor.fromJson(Map<String, dynamic> json){
    var workingJson = json['working'] as List<dynamic>?; // Handle potential null value
    List<Working> workingList = workingJson != null
        ? workingJson.map((e) => Working.fromJson(e as Map<String, dynamic>)).toList()
        : [];
    var feedbackJson = json['feedback'] as List<dynamic>?; // Handle potential null value
    List<Feedback> feedbackList = feedbackJson != null
    ? feedbackJson.map((e) => Feedback.fromJson(e as Map<String, dynamic>)).toList()
        : [];
    return Doctor(
      id: json['id'],
      fullName: json['fullName'],
      title: json['title'],
      gender: json['gender'],
      birthday: json['birthday'],
      address: json['address'],
      image: json['image'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      biography: json['biography'] ?? '',
      experience: json['experience'] ?? 0,
      rate: json['rate'] != null ? (json['rate'] as num).toDouble() : 0.0,
      userId: json['userId'],
      status: json['status'] as bool,
      department: Department.fromJson(json['department']),
      working: workingList,
      feedback: feedbackList,
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'fullName': fullName,
      'title': title,
      'gender': gender,
      'birthday': birthday,
      'address': address,
      'image': image,
      'price': price,
      'biography': biography,
      'experience': experience,
      'rate': rate,
      'userId': userId,
      'status': status,
      'department': department.toJson(),
      'working': working.map((e) => e.toJson()).toList(),
      'feedback': feedback.map((e) => e.toJson()).toList(),
    };
  }
}