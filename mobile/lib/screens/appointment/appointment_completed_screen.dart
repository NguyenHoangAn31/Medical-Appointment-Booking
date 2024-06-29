import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/appointment.dart';
import '../../models/patient.dart';
import '../../models/scheduledoctor.dart';
import '../../services/appointment_service.dart';
import '../../services/patient_service.dart';
import '../../utils/ip_app.dart';

class AppointmentCompletedScreen extends StatefulWidget {
  const AppointmentCompletedScreen({super.key});

  @override
  State<AppointmentCompletedScreen> createState() =>
      _AppointmentCompletedScreenState();
}

class _AppointmentCompletedScreenState
    extends State<AppointmentCompletedScreen> {
  late TextEditingController _commentController = TextEditingController();
  final ipDevice = BaseClient().ip;
  late int? appointmentId;
  late int? patientId = 0;
  late int? scheduleId;
  late int? doctorId;
  late String? patientName = '';
  String? gender;
  int? age;
  double _currentRating = 0.0;
  late Future<Appointment> _appointmentFutureCompleted;
  late Future<Patient> _patientFuture;
  late ScheduleDoctor? scheduleDoctor;

  int calculateAge(String birthday) {
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(birthday);

    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  void initState()  {
    super.initState();
    fetchData(scheduleId!);
  }

  Future<void> fetchData(int scheduleId) async {
    try {
      int fetchedDoctorId = await AppointmentClient().getDoctorIdByScheduleId(scheduleId);
      setState(() {
        doctorId = fetchedDoctorId;
      });
      print(doctorId);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    appointmentId = arguments['appointmentId'] as int;
    patientId = arguments['patientId'] as int;
    scheduleId = arguments['scheduleId'] as int;
    _patientFuture = PatientClient().getPatientById(patientId!);
    _patientFuture.then((patient) {
      setState(() {
        patientId = patient.id;
        patientName = patient.fullName;
        gender = patient.gender;
        age = calculateAge(patient.birthday.toString());
      });
    });
    scheduleDoctor = AppointmentClient().getDoctorIdByScheduleId(scheduleId!) as ScheduleDoctor?;


  }


  String getDayOfWeek(String date) {
    // List các tên thứ trong tuần
    List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    DateTime day01 = DateTime.parse(date);
    // Lấy chỉ số thứ của ngày
    int dayIndex = day01.weekday - 1; // Chú ý: DateTime.weekday trả về 1 cho Thứ Hai và 7 cho Chủ Nhật

    // Trả về tên thứ tương ứng
    return daysOfWeek[dayIndex];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.blue,
          title: const Text('Appointment Completed',
              style: TextStyle(color: Colors.white, fontSize: 22)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz_sharp),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder<Appointment>(
            future: _appointmentFutureCompleted,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Doctor not found'));
              } else {
                Appointment item = snapshot.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
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
                                    'http://$ipDevice:8080/images/doctors/${item.image}',
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
                                  '${item.title} ${item.fullName}',
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
                                    Text('${item.departmentName} |'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('${item.price} VND'),
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
                                  Text('590, CMT8, Q3, HCM'),
                                ])
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Schedule Appointment',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            children: [
                             Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('${getDayOfWeek(item.medicalExaminationDay)}: ${item.medicalExaminationDay}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.access_time),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(item.clinicHours,
                                      style: const TextStyle(
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
                      const Column(
                        children: [
                          Text(
                            'Patient Information',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Table(columnWidths: const {
                        0: FixedColumnWidth(100), // Độ rộng cột đầu tiên
                      }, children: [
                        TableRow(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Full Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                patientName!,
                                style: const TextStyle(
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
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Age',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                '${age!}',
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
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                '${gender!}',
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
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Problem',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                item.note,
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
                      Text('Review & Rating', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            initialRating: _currentRating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 36,
                            onRatingUpdate: (rating) {
                              setState(() {
                                _currentRating = rating;
                              });
                            },
                          ),
                          SizedBox(width: 20),
                          Text(
                            '  $_currentRating',
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          hintText: 'Enter your review',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.25,
                            letterSpacing: 0.02,
                          ),
                        ),
                      )
                    ],
                  ),
                  //)
                );
              }
            }),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {

                    // chuyển về 1 hàm
                   // ratingSubmit();
                  print(_commentController.text);
                  print(patientId);
                  print(_currentRating);
                  //print(doctorId.toString());
                },
                child: Container(
                  width: 355,
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
            ],
          ),
        ),
      ),
    );
  }
}
