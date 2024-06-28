import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _txtPhone = TextEditingController();
  final TextEditingController _txtFullName = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();

  void registerAccount() async{
      String phone = _txtPhone.text;
      String fullName = _txtFullName.text;
      String email = _txtEmail.text;

      if(fullName.isEmpty){
        Fluttertoast.showToast(
            msg: 'Fullname is not be blank!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

      if(phone.isEmpty){
        Fluttertoast.showToast(
            msg: 'Phone is not be blank!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        bool isCheckUser = await AuthClient().checkPhone(phone);
        if(!isCheckUser){
          Fluttertoast.showToast(
              msg: 'Phone has been registered. Please enter another phone number!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }
      if(email.isEmpty){
        Fluttertoast.showToast(
            msg: 'Email is not be blank!',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
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
                          controller: _txtFullName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Full Name',
                            hintText: 'Enter your full name',
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
                          controller: _txtPhone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Phone',
                            hintText: 'Enter your phone number',
                            counter: SizedBox.shrink(), // Ẩn counter cho nhập chữ số duy nhất
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
                          controller: _txtEmail,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            hintText: 'Enter your email',
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
                          keyboardType: TextInputType.emailAddress,
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
                      registerAccount();
                    },
                    child: const Text(
                      'CREATE ACCOUNT',
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

