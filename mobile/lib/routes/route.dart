import 'package:flutter/cupertino.dart';
import 'package:mobile/screens/doctor/payment_screen.dart';

//import '../screens/home/home_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/signin_screen.dart';
import '../screens/doctor/booking_patient_screen.dart';
import '../screens/doctor/doctor_booking.dart';
import '../screens/doctor/doctor_detail_screen.dart';
import '../widgets/navigation_menu.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/home': (context) => const NavigationMenu(),
      //'/home': (context) => const HomeScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
      '/sign-in': (context) => const SignInScreen(),
      '/doctor': (context) => const DoctorDetailScreen(),
      '/doctor/booking': (context) => const DoctorBookingScreen(),
      '/doctor/booking/patient': (context) => const DoctorBookingPatientScreen(),
      '/doctor/booking/payment': (context) => const PaymentScreen(),
    };
  }
}
