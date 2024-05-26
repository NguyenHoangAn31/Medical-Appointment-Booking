import 'package:flutter/cupertino.dart';

import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/signin_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //'/': (context) => const HomeScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
      '/sign-in': (context) => const SignInScreen(),
    };
  }
}
