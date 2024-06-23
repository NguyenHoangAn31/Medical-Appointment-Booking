import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/ultils/ip_app.dart';
import 'dart:convert';
import 'package:mobile/ultils/storeCurrentUser.dart';

class EditDoctorScreen extends StatefulWidget {
  const EditDoctorScreen({super.key});

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  final currentUser = CurrentUser.to.user;
  final ipDevice = BaseClient().ip;

  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController fullNameController;
  late TextEditingController titleController;
  late TextEditingController genderController;
  late TextEditingController birthdayController;
  late TextEditingController addressController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo các TextEditingController với giá trị rỗng tạm thời
    emailController = TextEditingController();
    phoneController = TextEditingController();
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
          'http://${ipDevice}:8080/api/doctor/getdoctordetail/${currentUser['id']}'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      setState(() {
        // Gán giá trị từ API vào các TextEditingController
        emailController.text = result['email'];
        phoneController.text = result['phone'];
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
    final url =
        'http://${ipDevice}:8080/api/doctor/editdoctor/${currentUser['id']}';

    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'phone': phoneController.text,
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
          SnackBar(content: Text('Information updated successfully')));
    } else {
      // Nếu cập nhật thất bại
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update information')));
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
        child: ListView(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: birthdayController,
              decoration: InputDecoration(labelText: 'Birthday'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 20),
          ],
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
