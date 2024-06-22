import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/ultils/storeCurrentUser.dart';

class AppointmentDoctorScreen extends StatelessWidget {
  const AppointmentDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppointmentDoctorScreen'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: GetBuilder<CurrentUser>(
          builder: (controller) {
            var userData = controller.user;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Name: ${userData['fullName']}'), 
              ],
            );
          },
        ),
      ),
    );
  }
}
