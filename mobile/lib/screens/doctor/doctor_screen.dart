import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        title: const Text('Doctor', style: TextStyle(color: Colors.white, fontSize: 30)),
        centerTitle: true,
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       // Navigate to Create Account screen
        //       Navigator.pushNamed(context, '/sign-in');
        //     },
        //     child: const Text(
        //       'Sign in',
        //       style: TextStyle(
        //         color: Color(0xFF92A3FD),
        //         fontSize: 14,
        //         fontFamily: 'Poppins',
        //         fontWeight: FontWeight.w600,
        //         letterSpacing: 0.11,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: const Center(
        child: Text('Doctor Screen'),
      ),
      // bottomNavigationBar: BottomNavigationBarItem(
      //     icon: Icon(Icons.home)),
    );
  }
}
