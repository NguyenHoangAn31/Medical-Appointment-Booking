import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/ip_app.dart';
import 'package:mobile/utils/store_current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final ipDevice = BaseClient().ip;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpNumber01Controller = TextEditingController();
  final TextEditingController _otpNumber02Controller = TextEditingController();
  final TextEditingController _otpNumber03Controller = TextEditingController();
  final TextEditingController _otpNumber04Controller = TextEditingController();
  final TextEditingController _otpNumber05Controller = TextEditingController();
  final TextEditingController _otpNumber06Controller = TextEditingController();

  bool _isShowOtp = false;
  //bool _isShowButtonHandleOpt = false;

  bool isShowBtn = false;
  bool otpVisibility = false;
  String verificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  late final String phone;

  late List<FocusNode> _otpFocusNodes;

  @override
  void initState() {
    super.initState();
    _otpFocusNodes = List<FocusNode>.generate(6, (index) => FocusNode());
    auth.setLanguageCode('vi');
  }

  @override
  void dispose() {
    for (final node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String formatPhoneNumber(String phoneNumber) {
    // Remove leading 0 if it exists
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }
    // Add country code +84
    return '+84$phoneNumber';
  }

  Future<void> verifyPhoneNumber() async {
    bool isAccount =
        await AuthClient().checkAccount(_phoneNumberController.text);
    if (isAccount) {
      // bool isPhone = await AuthClient().sendOtp(_phoneNumberController.text);
      // if (isPhone) {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: formatPhoneNumber(_phoneNumberController.text),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval or instant validation
          await auth.signInWithCredential(credential);
          if (kDebugMode) {
            print(
                'Phone number automatically verified and user signed in: ${auth.currentUser}');

//       bool isPhone = await AuthClient().sendOtp(_phoneNumberController.text);
//       if (isPhone) {
//               await auth.verifyPhoneNumber(
//                 timeout: const Duration(seconds: 60),
//                 phoneNumber: formatPhoneNumber(_phoneNumberController.text),
//                 verificationCompleted: (PhoneAuthCredential credential) async {
//                   // Auto-retrieval or instant validation
//                   await auth.signInWithCredential(credential);
//                   if (kDebugMode) {
//                     print(
//                         'Phone number automatically verified and user signed in: ${auth.currentUser}');
//                   }
//                 },
//                 verificationFailed: (FirebaseAuthException e) {
//                   if (kDebugMode) {
//                     print(
//                         'Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
//                   }
//                 },
//                 codeSent: (String verificationId, int? resendToken) {
//                   setState(() {
//                     _isShowOtp = true;
//                     otpVisibility = true;
//                     this.verificationId = verificationId;
//                   });
//                   if (kDebugMode) {
//                     print('Please check your phone for the verification code.');
//                   }
//                 },
//                 codeAutoRetrievalTimeout: (String verificationId) {
//                   // Auto-resolution timed out...
//                   setState(() {
//                     this.verificationId = verificationId;
//                   });
//                 },
//               );
//         }
//       else {
//           String result = await checkRefreshToken();
//           if (result == 'USER') {
//             Navigator.of(context).pushNamedAndRemoveUntil(
//               '/home',
//                   (Route<dynamic> route) => false,
//             );
// >>>>>>> main
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print(
                'Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isShowOtp = true;
            otpVisibility = true;
            this.verificationId = verificationId;
          });
          if (kDebugMode) {
            print('Please check your phone for the verification code.');
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
          setState(() {
            this.verificationId = verificationId;
          });
        },
      );
      // }
      // else {
      //     String result = await checkRefreshToken();
      //     if (result == 'USER') {
      //       Navigator.pushNamed(context, '/home');
      //     }
      //     if (result == 'DOCTOR') {
      //       Navigator.pushNamed(context, '/dashboard/doctor/home');
      //     }
      //   }
    } else {
      Fluttertoast.showToast(
          msg: 'Phone not exits!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future signInWithOTP() async {
    String smsCode = _getOtpCode();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      await auth.signInWithCredential(credential);
      await AuthClient().setKeyCode(_phoneNumberController.text, smsCode);
      // check Login
      var data = {
        'username': _phoneNumberController.text,
        'keycode': smsCode,
        'provider': 'phone',
      };

      var url = Uri.parse('http://$ipDevice:8080/api/auth/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));
      var result = jsonDecode(response.body);

      if (result['user'] == null) {
        return "Error";
      } else {
        var path = result['user']['roles'][0] == 'USER'
            ? 'patient'
            : 'doctor/findbyuserid';
        var urlForCurrentUser =
            'http://$ipDevice:8080/api/$path/${result['user']['id']}';
        var response = await http.get(
          Uri.parse(urlForCurrentUser),
          headers: {'Content-Type': 'application/json'},
        );
        var dataForCurrentUser = jsonDecode(response.body);

        // lưu user
        CurrentUser.to.setUser(dataForCurrentUser);
      
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // String userDataString = jsonEncode();
        String role = result['user']['roles'][0];
        await prefs.setString('id_and_role', '{"id":"${dataForCurrentUser['id']}","role":"${role}"}');

        if (result['user']['roles'][0] == 'USER') {
          Navigator.pushNamed(context, '/home');
        }
        if (result['user']['roles'][0] == 'DOCTOR') {
          Navigator.pushNamed(context, '/dashboard/doctor/home');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to sign in: $e');
      }
    }
  }

  String _getOtpCode() {
    return _otpNumber01Controller.text +
        _otpNumber02Controller.text +
        _otpNumber03Controller.text +
        _otpNumber04Controller.text +
        _otpNumber05Controller.text +
        _otpNumber06Controller.text;
  }

  Future<String> checkRefreshToken() async {
    //xử lý send otp
    var url = 'http://$ipDevice:8080/api/auth/check-refresh-token';
    var data = {'username': _phoneNumberController.text, 'provider': 'phone'};

    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['user'] == null) {
    } else {
      var path = jsonResponse['user']['roles'][0] == 'USER'
          ? 'patient'
          : 'doctor/findbyuserid';
      var urlForCurrentUser =
          'http://$ipDevice:8080/api/$path/${jsonResponse['user']['id']}';
      var response = await http.get(
        Uri.parse(urlForCurrentUser),
        headers: {'Content-Type': 'application/json'},
      );
      var dataForCurrentUser = jsonDecode(response.body);
      CurrentUser.to.setUser(dataForCurrentUser);
      return jsonResponse['user']['roles'][0];
    }
    return "error";
  }

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
              Navigator.pushNamed(context, '/register');
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 34,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.25,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Sign in to your Account',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.25,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 200),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        labelText: 'Phone number',
                        counter: SizedBox
                            .shrink(), // Ẩn counter cho nhập chữ số duy nhất
                        //alignLabelWithHint: true, // Canh giữa với dòng văn bản
                        contentPadding: EdgeInsets.only(top: 0),
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Color(0xFF98A2B2),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        //errorText: _showError ? 'Invalid phone number' : null,
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
                const SizedBox(height: 25),
                if (otpVisibility)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOtpField(0, _otpNumber01Controller),
                      _buildOtpField(1, _otpNumber02Controller),
                      _buildOtpField(2, _otpNumber03Controller),
                      _buildOtpField(3, _otpNumber04Controller),
                      _buildOtpField(4, _otpNumber05Controller),
                      _buildOtpField(5, _otpNumber06Controller),
                    ],
                  ),
                const SizedBox(height: 10),
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
                      if (otpVisibility) {
                        log("alo");
                        signInWithOTP();
                      } else {
                        verifyPhoneNumber();
                      }
                    },
                    child: Text(
                      otpVisibility ? 'SEND OTP' : 'VERIFY PHONE',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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

  Widget _buildOtpField(int index, TextEditingController controller) {
    return Container(
      width: 60,
      height: 60,
      decoration: ShapeDecoration(
        color: const Color(0xFFF2F4F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          focusNode: _otpFocusNodes[index],
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counter: SizedBox.shrink(),
            alignLabelWithHint: true,
            counterText: '',
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            if (value.length == 1 && index < _otpFocusNodes.length - 1) {
              FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }
// <<<<<<< An
// }
// =======
}
