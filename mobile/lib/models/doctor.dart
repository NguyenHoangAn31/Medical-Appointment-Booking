import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Doctor{
  late final int id;
  late final String fullName;
  late final String title; //Chức danh
  late final String gender; // giới tính
  late final String birthday; // ngày sinh
  late final String address; // Địa chỉ
  late final String image; // Image
  late final Double price;
  late final String biography;
  late final Double rate;
  late final bool status;
  late final int userId;
  Doctor({required this.id, required this.fullName, required this.title, required this.gender, required this.birthday,
  required this.address, required this.image, required this.price, required this.biography, required this.rate,
    required this.status, required this.userId});
  factory Doctor.fromJson(Map<String, dynamic> json){
    return Doctor(
      id: json['id'],
      fullName: json['fullName'],
      title: json['title'],
      gender: json['gender'],
      birthday: json['birthday'],
      address: json['address'],
      image: json['image'],
      price: json['price'],
      biography: json['biography'],
      rate: json['rate'],
      status: json['status'],
      userId: json['userId'],
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
      'rate': rate,
      'status': status,
      'userId': userId,
    };
  }
}