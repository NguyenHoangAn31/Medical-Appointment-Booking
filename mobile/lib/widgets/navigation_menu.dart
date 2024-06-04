
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile/screens/account/account_screen.dart';
import '../screens/appointment/appointment_screen.dart';
import '../screens/blog/blog_screen.dart';
import '../screens/doctor/doctor_screen.dart';
import '../screens/home/home_screen.dart';
import '../ultils/awesome_dialog.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.onDestinationSelected(index, context),
            destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: FaIcon(FontAwesomeIcons.userDoctor), label: 'Doctor'),
                  NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Appointment'),
                  NavigationDestination(icon: Icon(Icons.feed), label: 'Blog'),
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
    const HomeScreen(),
    const DoctorScreen(),
    const AppointmentScreen(),
    const BlogScreen(),
    const AccountScreen(),
  ];

  void onDestinationSelected(int index, BuildContext context) {
    // if (index == 2 && !loggedIn.value) {
    //  // logic thông báo
    //   AwesomeDialog.show(
    //     context: context,
    //     title: 'Notification!',
    //     content: 'Please Sign in to use this function',
    //     confirmText: 'Login',
    //     route: '/sign-in',
    //     cancelText: 'Close',
    //     onCancel: () => Get.back(),
    //   );
    //
    // }
    //else
    // if(index == 4 && !loggedIn.value) {
    //   AwesomeDialog.show(
    //     context: context,
    //     title: 'Notification!',
    //     content: 'Please Sign in to use this function',
    //     confirmText: 'Login',
    //     route: '/sign-in',
    //     cancelText: 'Close',
    //     onCancel: () => Get.back(),
    //   );
    // }else{
    //   selectedIndex.value = index;
    // }
    selectedIndex.value = index;
  }

  void login() {
    // Perform login logic
    // On successful login, update the loggedIn status
    final controller = Get.find<NavigationController>();
    controller.loggedIn.value = true;
  }


}
