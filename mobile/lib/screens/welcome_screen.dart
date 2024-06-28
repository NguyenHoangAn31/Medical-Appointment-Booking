import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile/screens/auth/sign_screen.dart';
//import 'package:mobile/screens/home_screen.dart';

//import 'package:mobile/screens/login_screen.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/utils/store_current_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth/sign_screen.dart';
import '../widgets/navigation_menu.dart';
import '../widgets/navigation_menu_doctor.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Wait for 3 seconds then check if user data is available
    Timer(const Duration(seconds: 3), _loadUser);
  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    String? role = prefs.getString('role');
    if (userDataString != null) {
      Map<String, dynamic> user = jsonDecode(userDataString);
      CurrentUser.to.setUser(user);

      log(userDataString);

      if (role == 'USER') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavigationMenu()),
        );
      } else if (role == 'DOCTOR') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavigationMenuDoctor()),
        );
      }
    } else {
      // No user data found, navigate to SignInScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 812,
      clipBehavior: Clip.antiAlias,
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
      child: Stack(
        children: [
          const Positioned(
            left: 135,
            top: 220,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          Positioned(
            left: 180,
            top: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: RotationTransition(
                    turns: _controller,
                    child: const Image(
                      image: AssetImage('assets/images/Loading.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
