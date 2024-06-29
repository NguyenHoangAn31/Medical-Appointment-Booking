import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import '../../models/doctor.dart';
import '../../models/feedback_model.dart';
import '../../utils/color_app.dart';
import '../../utils/ip_app.dart';
import 'package:http/http.dart' as http;

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({super.key});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  int? doctorId = 1;
  final ipDevice = BaseClient().ip;
  bool isShowReviews = false;

  late Future<Doctor> _doctor;
  List<dynamic> feedbacks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    doctorId = arguments['doctorId'] as int;
    _doctor = getDoctorById(doctorId!);
    fetchFeedbacks(doctorId!);
  }

  Future<Doctor> getDoctorById(int doctorId) async {
    final response = await http.get(
      Uri.parse('http://$ipDevice:8080/api/doctor/$doctorId'),
    );
    if (response.statusCode == 200) {
      return Doctor.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load doctor');
    }
  }

  Future<void> fetchFeedbacks(int id) async {
    final response = await http.get(
      Uri.parse('http://$ipDevice:8080/api/feedback/${id}'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      feedbacks = result['feedbackDtoList'];

      // Sort feedbacks based on 'createdAt' in descending order
      feedbacks.sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));
    } else {
      throw Exception('Failed to load feedbacks');
    }
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
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //thông tin bác sỹ
              FutureBuilder<Doctor>(
                  future: _doctor,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('Doctor not found'));
                    } else {
                      Doctor doctor = snapshot.data!;
                      return Column(children: [
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
                                    Text('Medicare Hospital'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              'Biography',
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
                                    Text('Monday - Friday 08:00 - 22:00',
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
                                    Text('Medicare - No 590, CMT8, Q3. HCM',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ]);
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              // Thông tin review
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
                          setState(() {
                            isShowReviews = true;
                          });
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
                    height: 10,
                  ),
                  SizedBox(
                      height: 500,
                  child: ListView.builder(
                    itemCount: isShowReviews ? feedbacks.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic>  feedback = feedbacks[index];
                      print(feedback['comment']);
                      final Map<String, dynamic> patient = feedback['patient'];
                      print(patient['fullName']);
                      //print("image: ${feedback['patient'].image}");
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Opacity(
                                        opacity: 0.6,
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Image.network(
                                            'http://$ipDevice:8080/images/patients/${patient['image']}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${patient['fullName']}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.11,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 5),
                                    Text('4.5')
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${feedback['comment']}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.11,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                  )
                ],
              )
              // kết thúc review
            ],
          )),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: InkWell(
            onTap: () {
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
                    Color(0xFF9AC3FF),
                    Color(0xFF93A6FD),
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
