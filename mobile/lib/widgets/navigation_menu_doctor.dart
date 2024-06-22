import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile/screens/doctor/dashboard_doctor/appointment_doctor_screen.dart';
import 'package:mobile/screens/doctor/dashboard_doctor/feedback_doctor_screen.dart';
import 'package:mobile/screens/doctor/dashboard_doctor/home_doctor_screen.dart';
import 'package:mobile/screens/doctor/dashboard_doctor/profile_doctor_screen.dart';
import 'package:mobile/screens/doctor/dashboard_doctor/schedule_doctor_screen.dart';

class NavigationMenuDoctor extends StatelessWidget {
  const NavigationMenuDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    // controller.selectedIndex.value = 0; // Ensure initial index is home
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.onDestinationSelected(index, context),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.userDoctor), label: 'Schedule'),
            NavigationDestination(
                icon: Icon(Icons.calendar_month), label: 'Appointments'),
            NavigationDestination(icon: Icon(Icons.feed), label: 'Feedbacks'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final RxBool loggedIn = false.obs;
  final screens = [
    const HomeDoctorScreen(),
    const ScheduleDoctorScreen(),
    const AppointmentDoctorScreen(),
    const FeedbackDoctorScreen(),
    const ProfileDoctorScreen(),
  ];
  
  void onDestinationSelected(int index, BuildContext context) {
    selectedIndex.value = index;
  }
}
