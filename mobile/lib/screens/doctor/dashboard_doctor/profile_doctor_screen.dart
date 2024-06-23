import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/ultils/ip_app.dart';
import 'package:mobile/ultils/storeCurrentUser.dart';
import 'package:mobile/widgets/navigation_menu_doctor.dart';
import 'package:get/get.dart';

class ProfileDoctorScreen extends StatefulWidget {
  const ProfileDoctorScreen({super.key});

  @override
  State<ProfileDoctorScreen> createState() => _ProfileDoctorScreenState();
}

class _ProfileDoctorScreenState extends State<ProfileDoctorScreen> {
  final currentUser = CurrentUser.to.user;
  final ipDevice = BaseClient().ip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          automaticallyImplyLeading: false,
          title: const Text('Profile', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard/doctor/edit');
              },
              child: const Text(
                "Edit",
                style: TextStyle(
                    color: Colors.white, // Màu chữ trắng để phù hợp với AppBar
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 170,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: 100,
                      color: Colors.blue[300],
                    ),
                  ),
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'http://${ipDevice}:8080/images/doctors/${currentUser['image']}', // Đặt URL của ảnh ở đây
                              width: 70,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        // decoration: BoxDecoration(
                        //   shape: BoxShape.circle,
                        //   border: Border.all(color: Colors.white, width: 4),
                        //   image: DecorationImage(
                        //     fit: BoxFit.cover,
                        //     image: NetworkImage(
                        //       'http://${ipDevice}:8080/images/doctors/${currentUser['image']}', // Đặt URL của ảnh ở đây
                        //     ),
                        //   ),
                        // ),
                      ),
                      Text(
                        "${currentUser['fullName']}",
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Department : ${currentUser['department']['name']}",
                          style: const TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard/doctor/qualification');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.school),
                    SizedBox(width: 20),
                    Text("Qualifications"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard/doctor/working');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.work),
                    SizedBox(width: 20),
                    Text("Workings"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.settings),
                    SizedBox(width: 20),
                    Text("Settings"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                CurrentUser.to.clearUser();
                final controller = Get.find<NavigationController>();
                controller.selectedIndex.value = 0; // Reset to home
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (Route<dynamic> route) => false,
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.logout),
                    SizedBox(width: 20),
                    Text("Log Out"),
                    Spacer(),
                    // Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
