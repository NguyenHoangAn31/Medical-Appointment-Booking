import 'package:flutter/material.dart';

class ProfileDoctorScreen extends StatefulWidget {
  const ProfileDoctorScreen({super.key});

  @override
  State<ProfileDoctorScreen> createState() => _ProfileDoctorScreenState();
}

class _ProfileDoctorScreenState extends State<ProfileDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileDoctorScreen'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('ProfileDoctorScreen'),
      ),
    );
  }
}
