import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/models/patient.dart';
import 'package:mobile/services/appointmentService.dart';

import '../../models/appointment.dart';
import '../../services/patientService.dart';
import '../../ultils/ip_app.dart';

class AppointmentUpcomingScreen extends StatefulWidget {
  const AppointmentUpcomingScreen({super.key});

  @override
  State<AppointmentUpcomingScreen> createState() =>
      _AppointmentUpcomingScreen();
}

class _AppointmentUpcomingScreen extends State<AppointmentUpcomingScreen> {
  final ipDevice = BaseClient().ip;
  late int? appointmentId;
  late int? patientId;
  late  String patientName;
  late  String gender;
  late  int age;

  late Future<Appointment> _appointmentFutureWaiting;
  late Future<Patient> _patientFuture;

  int calculateAge(String birthday) {
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(birthday);

    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    appointmentId = arguments['appointmentId'];
    patientId = arguments['patientId'];
    _appointmentFutureWaiting =
        AppointmentClient().fetchAppointmentById(appointmentId!);
    _patientFuture = PatientClient().getPatientById(patientId!);
    _patientFuture.then((patient) {
      patientName = patient.fullName;
      gender = patient.gender;
      age = calculateAge(patient.birthday).toString() as int;
        }).catchError((error) {
             print('Error fetching patient data: $error');
    });
  }

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
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder<Appointment>(
            future: _appointmentFutureWaiting,
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
                              const Row(
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
                      Table(columnWidths: const {
                        0: FixedColumnWidth(100), // Độ rộng cột đầu tiên
                      }, children: [
                        TableRow(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 5.0),
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
                        const TableRow(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Age',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 5.0),
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
                        const TableRow(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 5.0),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                'Problem',
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
                      ]),
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
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: 150,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFF4081), // Đầu gradient color
                      Color(0xFFF50057), // Cuối gradient color
                    ],
                  ),
                ),
                child: const Text(
                  'CANCEL',
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
