import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                             color: Colors.grey.withOpacity(0.5),
                             borderRadius: BorderRadius.circular(50),
                           ),
                           child: Image.asset(
                             'assets/images/doctor_01.png',
                             width: 60,
                             height: 60,
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                       const SizedBox(width: 15),
                       const Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Nguyễn Khoa',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                           ),
                           SizedBox(height: 10,),
                           Row(
                             children: [
                               Text('Joined since',
                                 style: TextStyle(
                                   color: Colors.grey,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 14,
                                 ),),
                               SizedBox(width: 5),
                               Text('27 Dec 2020',
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 14,
                                 ),),
                             ],
                           )
                         ]
                       )
                     ],
                   ),
                   InkWell(
                     onTap: (){
                       // Logic
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
                            onPressed: () {},
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
