import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/ip_app.dart';
import 'dart:convert';

import 'package:mobile/utils/store_current_user.dart';

class EditDoctorScreen extends StatefulWidget {
  const EditDoctorScreen({super.key});

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  final currentUser = CurrentUser.to.user;
  final ipDevice = BaseClient().ip;

  late TextEditingController emailController;
  // late TextEditingController phoneController;
  late TextEditingController fullNameController;
  late TextEditingController titleController;
  late TextEditingController genderController;
  late TextEditingController birthdayController;
  late TextEditingController addressController;
  late TextEditingController bioController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Khởi tạo các TextEditingController với giá trị rỗng tạm thời
    emailController = TextEditingController();
    // phoneController = TextEditingController();
    fullNameController = TextEditingController();
    titleController = TextEditingController();
    genderController = TextEditingController();
    birthdayController = TextEditingController();
    addressController = TextEditingController();
    bioController = TextEditingController();

    fetchDoctorDetail();
  }

  Future<void> fetchDoctorDetail() async {
    final response = await http.get(
      Uri.parse(
          'http://$ipDevice:8080/api/doctor/getdoctordetail/${currentUser['id']}'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      setState(() {
        // Gán giá trị từ API vào các TextEditingController
        emailController.text = result['email'];
        // phoneController.text = result['phone'];
        fullNameController.text = result['fullName'];
        titleController.text = result['title'];
        genderController.text = result['gender'];
        birthdayController.text = result['birthday'];
        addressController.text = result['address'];
        bioController.text = result['bio'];
      });
    } else {
      throw Exception('Failed to load doctor detail');
    }
  }

  Future<void> saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final url =
          'http://$ipDevice:8080/api/doctor/editdoctor/${currentUser['id']}';
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          // 'phone': phoneController.text,
          'fullName': fullNameController.text,
          'title': titleController.text,
          'gender': genderController.text,
          'birthday': birthdayController.text,
          'address': addressController.text,
          'bio': bioController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Nếu cập nhật thành công
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Information updated successfully')));
      } else {
        // Nếu cập nhật thất bại
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update information')));
      }
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('Information', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // Đặt màu trắng cho nút back
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: phoneController,
              //   decoration: const InputDecoration(labelText: 'Phone'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your phone number';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: birthdayController,
                decoration: const InputDecoration(labelText: 'Birthday'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  await _selectDate(context, birthdayController);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your birthday';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            saveChanges();
          },
          child: Container(
            height: 50,
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF9AC3FF),
                  Color(0xFF93A6FD),
                ],
              ),
            ),
            child: const Center(
              child: Text(
                'Save',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
