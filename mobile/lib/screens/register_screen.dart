import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to Create Account screen
              Navigator.pushNamed(context, '/sign-in');
            },
            child: const Text(
              'Sign in',
              style: TextStyle(
                color: Color(0xFF92A3FD),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.11,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            height: 812,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x07000000),
                  blurRadius: 40,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.25,
                      ),
                    ),
                    // Text(
                    //   'Account',
                    //   style: TextStyle(
                    //     color: Color(0xFF1A1A1A),
                    //     fontSize: 32,
                    //     fontFamily: 'Poppins',
                    //     fontWeight: FontWeight.w600,
                    //     letterSpacing: 0.25,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 200),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter full name',
                            counter: SizedBox.shrink(), // Ẩn counter cho nhập chữ số duy nhất
                            //alignLabelWithHint: true, // Canh giữa với dòng văn bản
                            //counterText: '',
                            hintStyle: TextStyle(
                              color: Color(0xFF98A2B2),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your phone number',
                            counter: SizedBox.shrink(), // Ẩn counter cho nhập chữ số duy nhất
                            //alignLabelWithHint: true, // Canh giữa với dòng văn bản
                            counterText: '',
                            hintStyle: TextStyle(
                              color: Color(0xFF98A2B2),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 380,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      backgroundColor: const Color(0xFF92A3FD),
                    ),
                    onPressed: () {
                    },
                    child: const Text(
                      'SEND OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.02,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  }