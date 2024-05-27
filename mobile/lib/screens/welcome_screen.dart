import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        //MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
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
      child: const Stack(
        children: [
          Positioned(
            left: 139,
            top: 358,
            child: SizedBox(
              width: 96,
              height: 96,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          Positioned(
            left: 159,
            top: 702,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: Image(
                    image: AssetImage('assets/images/Loading.png'),
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
