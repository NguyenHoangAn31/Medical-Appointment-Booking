import 'package:flutter/material.dart';

class ScheduleDoctorScreen extends StatefulWidget {
  const ScheduleDoctorScreen({super.key});

  @override
  State<ScheduleDoctorScreen> createState() => _ScheduleDoctorScreenState();
}

class _ScheduleDoctorScreenState extends State<ScheduleDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScheduleDoctorScreen'),
        backgroundColor: Colors.blue, 
      ),
      body: const Center(
        child: Text('ScheduleDoctorScreen'),
      ),
    );
  }
}
