import 'package:flutter/material.dart';

class AppointmentCancelledScreen extends StatefulWidget {
  const AppointmentCancelledScreen({super.key});

  @override
  State<AppointmentCancelledScreen> createState() => _AppointmentCancelledScreenState();
}

class _AppointmentCancelledScreenState extends State<AppointmentCancelledScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          //backgroundColor: Colors.blue,
          title: const Text('Appointment Upcoming',
              style: TextStyle(color: Colors.black, fontSize: 22)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz_sharp),
              onPressed: () {
              },
            ),
          ],
        ),
        body: (
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
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
                              blurRadius: 10,
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'DR William Smith',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text('Dentist |',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10), // Padding around the text
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(
                                                0.2), // Lighter background color
                                            borderRadius: BorderRadius.circular(
                                                5.0), // Rounded corners
                                          ),
                                          child: const Text('Cancelled',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.location_on_outlined),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          child: const Text('123 Main St, New York, NY, USA',
                                              style: TextStyle(
                                                  color: Colors.black26,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule Appointment',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Monday - Friday 10:00 - 18:00',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(
                                width: 15,
                              ),
                              Text('11:00 AM',
                                  style: TextStyle(
                                    // color: Colors.blueAccent,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Infomation',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Table(
                      columnWidths: const {
                        0: FixedColumnWidth(120), // Độ rộng cột đầu tiên
                      },
                      children: const [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Full Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Samata Shin',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Age',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                '27',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Female',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Problem',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Hello, simply dummy text or the printing and typesetting industry. Lorem Ipsum 1500s. View More',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cancelled Reason',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text('Dr. Jennie Tharn i request  to cancel this appointment due to i have urgent task to do.',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,)),
                    ],
                  ),
                ],
              ),
            )
        ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: InkWell(
              onTap: () {
              },
              child: Container(
                height: 50,
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9AC3FF), // Đầu gradient color
                      Color(0xFF93A6FD), // Cuối gradient color
                    ],
                  ),
                ),
                child: const Text(
                  'Book Again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )),
      ),
    );
  }
}