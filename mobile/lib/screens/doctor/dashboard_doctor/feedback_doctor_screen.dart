import 'package:flutter/material.dart';

class FeedbackDoctorScreen extends StatefulWidget {
  const FeedbackDoctorScreen({super.key});

  @override
  State<FeedbackDoctorScreen> createState() => _FeedbackDoctorScreenState();
}

class _FeedbackDoctorScreenState extends State<FeedbackDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedbackDoctorScreen'),
        backgroundColor: Colors.blue, 
      ),
      body: const Center(
        child: Text('FeedbackDoctorScreen'),
      ),
    );
  }
}