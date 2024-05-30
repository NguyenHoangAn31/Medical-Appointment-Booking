import 'package:flutter/cupertino.dart';

//import '../screens/home/home_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/signin_screen.dart';
import '../widgets/navigation_menu.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/home': (context) => const NavigationMenu(),
      //'/home': (context) => const HomeScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
      '/sign-in': (context) => const SignInScreen(),
    };
  }
}
