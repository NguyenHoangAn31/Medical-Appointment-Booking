import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/services/patient_service.dart';

import '../../models/patient.dart';
import '../../utils/ip_app.dart';
import '../../utils/store_current_user.dart';
import '../../widgets/navigation_menu.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final currentUser = CurrentUser.to.user;
  final ipDevice = BaseClient().ip;
  late Future<Patient> _patientFuture;
  late DateTime joinedSince;

  @override
  void initState() {
    super.initState();
    _patientFuture = PatientClient().getPatientById(currentUser['id']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          title: const Text(
              'My Profile', style: TextStyle(color: Colors.black, fontSize: 22)),
          centerTitle: true,
          actions: [
            IconButton(
            icon: const Icon(Icons.more_horiz, size: 30,),
            onPressed: () {
              // Action for search button
            },
            ),
       ]
    ),
    body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                     children: [
                       ClipRRect(
                         child: Container(
                           width: 60,
                           height: 60,
                           padding: const EdgeInsets.all(5),
                           decoration: BoxDecoration(
                             //color: Colors.grey.withOpacity(0.5),
                             borderRadius: BorderRadius.circular(50),
                           ),
                           child: Image.network(
                             'http://$ipDevice:8080/images/patients/${currentUser['image']}',
                             width: 45,
                             height: 45,
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                       const SizedBox(width: 15),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('${currentUser['fullName']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                           ),
                           const SizedBox(height: 10,),
                           const Row(
                             children: [
                               Text('Joined since',
                                 style: TextStyle(
                                   color: Colors.grey,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 14,
                                 ),),
                               SizedBox(width: 5),
                               // Text('$joinedSince',
                               //   style: const TextStyle(
                               //     color: Colors.black,
                               //     fontWeight: FontWeight.bold,
                               //     fontSize: 14,
                               //   ),),
                             ],
                           )
                         ]
                       )
                     ],
                   ),
                   InkWell(
                     onTap: (){
                       // Logic /patient/account/edit
                       // var data = {
                       //   'patientId': currentUser['id'],
                       // };
                       Navigator.pushNamed(context, '/patient/account/edit');
                     },
                     child: Container(
                       width: 100,
                       //height: 30,
                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                       decoration: BoxDecoration(
                         gradient: const LinearGradient(
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                           colors: [
                             Color(0xFF9AC3FF), // Đầu gradient color
                             Color(0xFF93A6FD), // Cuối gradient color
                           ],
                         ),
                         //color: Colors.grey.withOpacity(0.5),
                         borderRadius: BorderRadius.circular(50),
                       ),
                       child: const Text(
                           'Edit',
                         style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                         ),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   )
                ],
              ),
              const SizedBox(height: 40,),
              Container(
                width: 383,
                //height: 200,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Settings', textAlign: TextAlign.start, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                             Icon(Icons.language, color: Color(0xFF92A3FD),),
                             SizedBox(width: 10),
                             Text('Languages', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_right)
                        )
                        ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_pin, color: Color(0xFF92A3FD)),
                            SizedBox(width: 10),
                            Text('Location', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_right)
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: 383,
                //height: 200,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Notification', textAlign: TextAlign.start, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.notifications_none, color: Color(0xFF92A3FD),size: 32),
                            SizedBox(width: 10),
                            Text('Pop-up Notification', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.toggle_on, size: 32, color: Color(0xFF92A3FD))
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: 383,
                //height: 200,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Settings', textAlign: TextAlign.start, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.error_outline, color: Color(0xFF92A3FD),),
                            SizedBox(width: 10),
                            Text('About Us', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_right)
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.support_agent, color: Color(0xFF92A3FD)),
                            SizedBox(width: 10),
                            Text('Customer Service', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_right)
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.mark_as_unread, color: Color(0xFF92A3FD)),
                            SizedBox(width: 10),
                            Text('Invite Other', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_right)
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 10),
                            Text('Logout', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              CurrentUser.to.clearUser();
                              final controller = Get.find<NavigationControllerForDoctor>();
                              controller.selectedIndex.value = 0; // Reset to home
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                    (Route<dynamic> route) => false,
                              );
                            },
                            icon: const Icon(Icons.chevron_right)
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
          ,
        ),
    ),
    );
  }
}
