import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/doctor.dart';
import '../../services/doctor/doctorService.dart';
import '../../services/feedbackService.dart';
import '../../ultils/color_app.dart';
import '../../ultils/ip_app.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({super.key});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  final ipDevice = BaseClient().ip;
  late final int doctorId;
  late final Future<List<Feedback>> _feedback;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    doctorId = arguments['doctorId'] as int;
   // _feedback = getFeedbackByDoctorId(doctorId) as Future<List<Feedback>>;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<Doctor>(
          future: getDoctorById(doctorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Doctor not found'));
            } else {
              Doctor doctor = snapshot.data!;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      //height: 100,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFEAEEFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        children: [
                          ClipRRect(
                            child: Opacity(
                              opacity: 0.6,
                              child: Container(
                                width: 80,
                                height: 80,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.network(
                                  'http://$ipDevice:8080/images/doctors/${doctor.image}',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${doctor.title} ${doctor.fullName}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text('${doctor.department.name} |'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('${doctor.price} VND'),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Row(children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.cyan,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Medicare Hopital'),
                              ])
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              // Color nền
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: const Column(
                            children: [
                              Text(
                                '180+',
                                style: TextStyle(
                                  color: Color(0xFF97B3FE),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Patient',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 130,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              // Color nền
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Column(
                            children: [
                              Text(
                                '${doctor.experience}Y+',
                                style: const TextStyle(
                                  color: Color(0xFF97B3FE),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Experience',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              // Color nền
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                    size: 26,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${doctor.rate}',
                                    style: const TextStyle(
                                      color: Color(0xFF97B3FE),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Rating',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About me',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          doctor.biography,
                          textAlign: TextAlign.justify,
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
                          'Working Information',
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
                                Icon(Icons.location_pin),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('Medicare Hospital, 590, CMT8, Q3',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews',
                              style: TextStyle(
                                color: AppColor.primaryText,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to Create Account screen
                                Navigator.pushNamed(context, '/sign-in');
                              },
                              child: const Text(
                                'SEE ALL',
                                style: TextStyle(
                                  color: Color(0xFF92A3FD),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // FutureBuilder<List<Feedback>>(
                        //   future: _feedback,
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState == ConnectionState.waiting) {
                        //       return const Center(child: CircularProgressIndicator());
                        //     } else if (snapshot.hasError) {
                        //       return Center(child: Text('Error: ${snapshot.error}'));
                        //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        //       return const Center(child: Text('No feedback found'));
                        //     } else {
                        //       List<Feedback> feedbackList = snapshot.data!;
                        //       return ListView.builder(
                        //         itemCount: feedbackList.length,
                        //         itemBuilder: (context, index) {
                        //           final feedback = feedbackList[index];
                        //           return Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Column(
                        //               children: [
                        //                 Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         ClipRRect(
                        //                           child: Opacity(
                        //                             opacity: 0.6,
                        //                             child: Container(
                        //                               width: 60,
                        //                               height: 60,
                        //                               padding: const EdgeInsets.all(5),
                        //                               decoration: BoxDecoration(
                        //                                 color: Colors.grey,
                        //                                 borderRadius: BorderRadius.circular(50),
                        //                               ),
                        //                               child: Image.asset(
                        //                                 'assets/images/doctor_01.png',
                        //                                 width: 25,
                        //                                 height: 25,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         const SizedBox(width: 10),
                        //                         const Text(
                        //                           'Samatha',
                        //                           style: TextStyle(
                        //                             color: Colors.black,
                        //                             fontSize: 20,
                        //                             fontFamily: 'Poppins',
                        //                             fontWeight: FontWeight.w600,
                        //                             letterSpacing: 0.11,
                        //                           ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     const Row(
                        //                       children: [
                        //                         Icon(
                        //                           Icons.star,
                        //                           color: Colors.orange,
                        //                         ),
                        //                         SizedBox(width: 5),
                        //                         Text('4.8')
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 const SizedBox(height: 5),
                        //                 const Text(
                        //                   'test',
                        //                   style: TextStyle(
                        //                     color: Colors.black54,
                        //                     fontSize: 14,
                        //                     fontFamily: 'Poppins',
                        //                     fontWeight: FontWeight.w600,
                        //                     letterSpacing: 0.11,
                        //                   ),
                        //                   textAlign: TextAlign.justify,
                        //                 ),
                        //               ],
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     }
                        //   },
                        // )

                      ],
                    )
                  ],
                ),
              );
            }
          }),

      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: InkWell(
            onTap: () {
              if (kDebugMode) {
                print(doctorId);
              }
              Navigator.pushNamed(context, '/doctor/booking', arguments: {'doctorId' : doctorId} );
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
                'BOOKING APPOINTMENT',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )),
    );
  }
}
