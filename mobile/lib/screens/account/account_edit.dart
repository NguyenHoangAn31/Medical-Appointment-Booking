import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../utils/ip_app.dart';
import '../../utils/store_current_user.dart';



class AccountEditScreen extends StatefulWidget {
  const AccountEditScreen({super.key});

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final currentUser = CurrentUser.to.user;
  final ipDevice = BaseClient().ip;

  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController fullNameController;
  late TextEditingController genderController;
  late TextEditingController birthdayController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo các TextEditingController với giá trị rỗng tạm thời
    emailController = TextEditingController();
    phoneController = TextEditingController();
    fullNameController = TextEditingController();
    genderController = TextEditingController();
    birthdayController = TextEditingController();
    addressController = TextEditingController();
    fetchPatientDetail();
  }
  Future<void> fetchPatientDetail() async {
    final response = await http.get(
      Uri.parse(
          'http://$ipDevice:8080/api/patient/get-patient-detail/${currentUser['id']}'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        // Gán giá trị từ API vào các TextEditingController
        emailController.text = result['email'];
        phoneController.text = result['phone'];
        fullNameController.text = result['fullName'];
        genderController.text = result['gender'];
        birthdayController.text = result['birthday'];
        addressController.text = result['address'];
      });
    } else {
      throw Exception('Failed to load doctor detail');
    }
  }
  Future<void> saveChanges() async {
    final url =
        'http://$ipDevice:8080/api/patient/edit-patient/${currentUser['id']}';

    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'phone': phoneController.text,
        'fullName': fullNameController.text,
        'gender': genderController.text,
        'birthday': birthdayController.text,
        'address': addressController.text,
      }),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Information updated successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: 'Failed to update information',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: birthdayController,
              decoration: const InputDecoration(labelText: 'Birthday'),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: InkWell(
              onTap: (){
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
                      Color(0xFF9AC3FF), // Đầu gradient color
                      Color(0xFF93A6FD), // Cuối gradient color
                    ],
                  ),
                ),
                child: const Text('UPDATE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
              ),
            )
        )

    );
  }
}
