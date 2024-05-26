import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpNumber01Controller = TextEditingController();
  final TextEditingController _otpNumber02Controller = TextEditingController();
  final TextEditingController _otpNumber03Controller = TextEditingController();
  final TextEditingController _otpNumber04Controller = TextEditingController();
  final TextEditingController _otpNumber05Controller = TextEditingController();
  final TextEditingController _otpNumber06Controller = TextEditingController();
  final bool _isShowOtp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
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
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Create Account screen
                      },
                      child: const Text(
                        'Create Account',
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
                const SizedBox(height: 50),
                const Column(
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 34,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'To Your Account',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 34,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]
                ),
                const SizedBox(height: 200),
                Container(
                  // width: 350,
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        hintText: 'Phone number',
                        hintStyle: TextStyle(
                          color: Color(0xFF98A2B2),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,

                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _otpNumber01Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counter: SizedBox.shrink(), // Ẩn counter cho nhập chữ số duy nhất
                            alignLabelWithHint: true, // Canh giữa với dòng văn bản
                            //showCounter: false,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.number,
                          // maxLength: 1,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _otpNumber02Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 1, // Chỉ cho phép nhập 1 ký tự

                        ),
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _otpNumber03Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 1, // Chỉ cho phép nhập 1 ký tự

                        ),
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _otpNumber04Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 1, // Chỉ cho phép nhập 1 ký tự
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _otpNumber05Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 1, // Chỉ cho phép nhập 1 ký tự
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F4F7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _otpNumber06Controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.phone,
                          maxLength: 1, // Chỉ cho phép nhập 1 ký tự
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 343,
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
                      // Sign in logic
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
                const SizedBox(height: 32),
                // const Text(
                //   'Forgot the password?',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Color(0xFFC58BF2),
                //     fontSize: 14,
                //     fontFamily: 'Poppins',
                //     fontWeight: FontWeight.w600,
                //     letterSpacing: 0.11,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}