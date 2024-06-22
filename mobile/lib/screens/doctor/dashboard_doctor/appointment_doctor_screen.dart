import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile/ultils/storeCurrentUser.dart';

class AppointmentDoctorScreen extends StatefulWidget {
  const AppointmentDoctorScreen({super.key});

  @override
  State<AppointmentDoctorScreen> createState() =>
      _AppointmentDoctorScreenState();
}

class _AppointmentDoctorScreenState extends State<AppointmentDoctorScreen> {
  List<dynamic> bookingToday = [];
  List<dynamic> examinationToday = [];
  List<dynamic> filteredBookingToday = [];
  List<dynamic> filteredExaminationToday = [];
  final currentUser = CurrentUser.to.user;
  bool noAppointments = false;
  bool noBookings = false;

  String startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Filter options and current selection
  String bookingFilter = 'all'; // Default: show all
  String examinationFilter = 'all'; // Default: show all

  Future<void> fetchBookingToday(String startDate, String endDate) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.2:8080/api/appointment/patientsbydoctoridandappointmentdates/${currentUser['id']}/${startDate}/${endDate}'));

    if (response.statusCode == 200) {
      setState(() {
        var result = jsonDecode(response.body);
        bookingToday = result;
        filteredBookingToday = result; // Initially show all
        noBookings = result.isEmpty ? true : false;
      });
    } else {
      throw Exception('Failed to load bookingToday');
    }
  }

  Future<void> fetchExaminationToday(String startDate, String endDate) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.2:8080/api/appointment/patientsbydoctoridandmedicalexaminationdates/${currentUser['id']}/${startDate}/${endDate}'));

    if (response.statusCode == 200) {
      setState(() {
        var result = jsonDecode(response.body);
        examinationToday = result;
        filteredExaminationToday = result; // Initially show all
        noAppointments = result.isEmpty ? true : false;
      });
    } else {
      throw Exception('Failed to load examinationToday');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBookingToday(startDate, endDate);
    fetchExaminationToday(startDate, endDate);
  }

  // Filter logic
  void applyBookingFilter(String filter) {
    setState(() {
      bookingFilter = filter;
      if (filter == 'all') {
        filteredBookingToday = bookingToday;
      } else {
        filteredBookingToday = bookingToday
            .where((booking) => booking['status'] == filter)
            .toList();
        noBookings = filteredBookingToday.isEmpty ? true : false;
      }
    });
  }

  void applyExaminationFilter(String filter) {
    setState(() {
      examinationFilter = filter;
      if (filter == 'all') {
        filteredExaminationToday = examinationToday;
      } else {
        filteredExaminationToday = examinationToday
            .where((examination) => examination['status'] == filter)
            .toList();
        noAppointments = filteredExaminationToday.isEmpty ? true : false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointment'),
          automaticallyImplyLeading: false, // Ẩn nút back button
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Examination Today'),
              Tab(text: 'Booking Today'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TabBarView(
            children: [
              // Tab Examination Today
              Column(
                children: [
                  // Filter buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      filterButton('all', 'All', examinationFilter,
                          applyExaminationFilter),
                      filterButton('finished', 'Finished', examinationFilter,
                          applyExaminationFilter),
                      filterButton('waiting', 'Waiting', examinationFilter,
                          applyExaminationFilter),
                      filterButton('no show', 'No Show', examinationFilter,
                          applyExaminationFilter),
                      filterButton('cancel', 'Cancel', examinationFilter,
                          applyExaminationFilter),
                    ],
                  ),

                  noAppointments
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/no_data.png'),
                              const SizedBox(height: 10),
                              const Text(
                                "You don't have any appointment today",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 7.0),
                            itemCount: filteredExaminationToday.length,
                            itemBuilder: (BuildContext context, int index) {
                              final examination =
                                  filteredExaminationToday[index];
                              final patient = examination['patientDto'];
                              return InkWell(
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    '/dashboard/doctor/patient',
                                    arguments: {
                                      'patient': patient,
                                      'status': examination['status'],
                                      'action': 'allow',
                                      'id': examination['id']
                                    },
                                  );
                                  if (result == 'updatedStatus') {
                                    fetchExaminationToday(startDate, endDate);
                                    fetchBookingToday(startDate, endDate);
                                  }
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical:
                                            8.0), // Padding cho từng phần tử
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ListTile(
                                          title: Text(patient['fullName']),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Clinic Hours: ${examination['clinicHours']}'),
                                              Text(
                                                  'Booking Date: ${examination['appointmentDate']}'),
                                            ],
                                          ),
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              'http://192.168.1.2:8080/images/patients/${patient['image']}',
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 7,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              color: () {
                                                if (examination['status'] ==
                                                    'finished') {
                                                  return Colors.green[
                                                      300]; // Màu xanh cho trạng thái đã hoàn thành
                                                } else if (examination[
                                                        'status'] ==
                                                    'waiting') {
                                                  return Colors.orange[
                                                      300]; // Màu cam cho trạng thái đang chờ
                                                } else {
                                                  return Colors.red[
                                                      300]; // Màu đỏ cho các trạng thái khác
                                                }
                                              }(),
                                            ),
                                            width: 75, // Độ rộng của Container
                                            height:
                                                30, // Chiều cao của Container

                                            child: Center(
                                              child: Text(
                                                examination['status'],
                                                style: const TextStyle(
                                                  color: Colors
                                                      .white, // Màu chữ là trắng
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                ],
              ),

              // Tab Booking Today
              Column(
                children: [
                  // Filter buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      filterButton(
                          'all', 'All', bookingFilter, applyBookingFilter),
                      filterButton('finished', 'Finished', bookingFilter,
                          applyBookingFilter),
                      filterButton('waiting', 'Waiting', bookingFilter,
                          applyBookingFilter),
                      filterButton('no show', 'No Show', bookingFilter,
                          applyBookingFilter),
                      filterButton('cancel', 'Cancel', bookingFilter,
                          applyBookingFilter),
                    ],
                  ),

                  noBookings
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/no_data.png'),
                              const SizedBox(height: 10),
                              const Text(
                                "You don't have any appointment today",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 7.0),
                            itemCount: filteredBookingToday.length,
                            itemBuilder: (BuildContext context, int index) {
                              final booking = filteredBookingToday[index];
                              final patient = booking['patientDto'];
                              return InkWell(
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    '/dashboard/doctor/patient',
                                    arguments: {
                                      'patient': patient,
                                      'status': booking['status'],
                                      'action': 'not allow',
                                      'id': booking['id']
                                    },
                                  );
                                  print(
                                      'Result from PatientScreenInDoctorPage: $result');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          8.0), // Padding cho từng phần tử
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ListTile(
                                        title: Text(patient['fullName']),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Clinic Hours: ${booking['clinicHours']}'),
                                            Text(
                                                'Medical Examination Day: ${booking['medicalExaminationDay']}'),
                                          ],
                                        ),
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            'http://192.168.1.2:8080/images/patients/${patient['image']}',
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 7,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            color: () {
                                              if (booking['status'] ==
                                                  'finished') {
                                                return Colors.green[
                                                    300]; // Màu xanh cho trạng thái đã hoàn thành
                                              } else if (booking['status'] ==
                                                  'waiting') {
                                                return Colors.orange[
                                                    300]; // Màu cam cho trạng thái đang chờ
                                              } else {
                                                return Colors.red[
                                                    300]; // Màu đỏ cho các trạng thái khác
                                              }
                                            }(),
                                          ),
                                          width: 75, // Độ rộng của Container
                                          height: 30, // Chiều cao của Container
                                          child: Center(
                                            child: Text(
                                              booking['status'],
                                              style: const TextStyle(
                                                color: Colors
                                                    .white, // Màu chữ là trắng
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create filter buttons
  Widget filterButton(String filter, String text, String currentFilter,
      Function(String) onPressed) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return TextButton(
      onPressed: () {
        onPressed(filter);
      },
      style: TextButton.styleFrom(
        backgroundColor: filter == currentFilter ? Colors.blue[300] : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
          // side: BorderSide(color: Colors.grey),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: filter == currentFilter ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
