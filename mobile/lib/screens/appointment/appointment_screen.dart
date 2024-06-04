import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(

          appBar: AppBar(
            toolbarHeight: 80,
            //backgroundColor: Colors.blue,
            title: const Text('My Appointment', style: TextStyle(color: Colors.black, fontSize: 22)),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Action for search button
                },
              ),
              IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () {
                  // Action for tune button
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Container(
                child: const TabBar(
                  labelColor: Colors.blue,
                  // Active tab text color
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  // Inactive tab text color
                  tabs: [
                    Tab(text: 'Receiving'),
                    Tab(text: 'Received'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              ReceivingScreen(),
              ReceivedScreen(),
              CompletedScreen(),
              CancelledScreen(),
            ],
          ),
        ));
  }
}

class ReceivingScreen extends StatelessWidget {
  const ReceivingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          Container(
            //height: 200,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // Làm tròn các góc
                        color: Colors.grey, // Màu nền
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/doctor_01.png',
                          width: 74,
                          height: 74,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DR William Smith',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Dentist |',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              )
                            ),
                            const SizedBox(width: 5,),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Padding around the text
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.2), // Lighter background color
                                borderRadius: BorderRadius.circular(5.0), // Rounded corners
                              ),
                              child: const Text(
                                  'Receiving',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  )
                                  ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Text('Aug 17, 2023 | 11:00 AM',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            )
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.black26.withOpacity(0.2), // Color of the divider
                  thickness: 1, // Thickness of the divider
                  indent: 20, // Left indent of the divider
                  endIndent: 20, // Right indent of the divider
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/register');
                      },
                      child: Container(
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel Booking',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/register');
                      },
                      child: Container(
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Reschedule',
                            style: TextStyle(
                              //color: Color(0xFF92A3FD),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                              letterSpacing: 0.02,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReceivedScreen extends StatelessWidget {
  const ReceivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          Container(
            //height: 200,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // Làm tròn các góc
                        color: Colors.grey, // Màu nền
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/doctor_01.png',
                          width: 74,
                          height: 74,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DR William Smith',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Dentist |',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                )
                            ),
                            const SizedBox(width: 5,),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Padding around the text
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.2), // Lighter background color
                                borderRadius: BorderRadius.circular(5.0), // Rounded corners
                              ),
                              child: const Text(
                                  'Received',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  )
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Text('Aug 17, 2023 | 11:00 AM',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            )
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.black26.withOpacity(0.2), // Color of the divider
                  thickness: 1, // Thickness of the divider
                  indent: 20, // Left indent of the divider
                  endIndent: 20, // Right indent of the divider
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/register');
                      },
                      child: Container(
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel Booking',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/register');
                      },
                      child: Container(
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'View Schedule',
                            style: TextStyle(
                              //color: Color(0xFF92A3FD),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                              letterSpacing: 0.02,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Screen Hủy Appointment
class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          Container(
            //height: 200,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // Làm tròn các góc
                        color: Colors.grey, // Màu nền
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/doctor_01.png',
                          width: 74,
                          height: 74,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DR William Smith',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Dentist |',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                )
                            ),
                            const SizedBox(width: 5,),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Padding around the text
                              decoration: BoxDecoration(
                                color: Colors.lightGreenAccent.withOpacity(0.2), // Lighter background color
                                borderRadius: BorderRadius.circular(5.0), // Rounded corners
                              ),
                              child: const Text(
                                  'Completed',
                                  style: TextStyle(
                                      color: Colors.lightGreenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  )
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 5,),
                        const Text('Aug 17, 2023 | 11:00 AM',
                            style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            )
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: Colors.black26.withOpacity(0.2), // Color of the divider
                  thickness: 1, // Thickness of the divider
                  indent: 20, // Left indent of the divider
                  endIndent: 20, // Right indent of the divider
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/register');
                      },
                      child: Container(
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Rating',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/register');
                      },
                      child: Container(
                        width: 160,
                        height: 55,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Book Again',
                            style: TextStyle(
                              //color: Color(0xFF92A3FD),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                              letterSpacing: 0.02,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_result_default.png'),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'No Result Default',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('There is no cancelled appointment'),
          const Text('Book your appointment now.'),
        ],
      ),
    );
  }
}
