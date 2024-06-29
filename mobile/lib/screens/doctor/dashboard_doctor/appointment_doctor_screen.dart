import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile/utils/ip_app.dart';
import 'package:mobile/utils/store_current_user.dart';

class AppointmentDoctorScreen extends StatefulWidget {
  const AppointmentDoctorScreen({super.key});

  @override
  State<AppointmentDoctorScreen> createState() =>
      _AppointmentDoctorScreenState();
}

class _AppointmentDoctorScreenState extends State<AppointmentDoctorScreen> {
  List<dynamic> filteredExaminationToday = [];
  List<dynamic> examinationToday = [];
  List<dynamic> examinationUpcoming = [];
  final currentUser = CurrentUser.to.user;
  bool noAppointments = false;
  bool noBookings = false;
  final ipDevice = BaseClient().ip;

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Filter options and current selection
  String bookingFilter = 'all'; // Default: show all
  String examinationFilter = 'all'; // Default: show all

  Future<void> fetchExaminationUpcoming() async {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));
    String formattedDate = DateFormat('yyyy-MM-dd').format(tomorrow);
    log("log : $formattedDate");

    final response = await http.get(Uri.parse(
        'http://$ipDevice:8080/api/appointment/patientsbydoctoridandmedicalexaminationupcoming/${currentUser['id']}/$formattedDate'));

    if (response.statusCode == 200) {
      setState(() {
        var result = jsonDecode(response.body);
        examinationUpcoming = result;
        // filteredBookingToday = result; // Initially show all
        noBookings = result.isEmpty ? true : false;
      });
    } else {
      throw Exception('Failed to load bookingToday');
    }
  }

  Future<void> fetchExaminationToday() async {
    final response = await http.get(Uri.parse(
        'http://$ipDevice:8080/api/appointment/patientsbydoctoridandmedicalexaminationtoday/${currentUser['id']}/$today/$today'));

    if (response.statusCode == 200) {
      setState(() {
        var result = jsonDecode(response.body);
        examinationToday = result;
        filteredExaminationToday = result; // Initially show all
        noAppointments = result.isEmpty ? true : false;
        log(filteredExaminationToday.toString());
      });
    } else {
      throw Exception('Failed to load examinationToday');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExaminationUpcoming();
    fetchExaminationToday();
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
          backgroundColor: Colors.blue[300],
          title:
              const Text('Appointment', style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false, // Ẩn nút back button
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white, // Màu của tab được chọn
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                text: 'Examination Today',
              ),
              Tab(text: 'Examination Upcoming'),
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
                      filterButton('completed', 'Completed', examinationFilter,
                          applyExaminationFilter),
                      filterButton('waiting', 'Waiting', examinationFilter,
                          applyExaminationFilter),
                      filterButton('no show', 'No Show', examinationFilter,
                          applyExaminationFilter),
                      filterButton('cancelled', 'Cancelled', examinationFilter,
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
                                      'note' : examination['note'],
                                      'action': 'allow',
                                      'id': examination['id']
                                    },
                                  );
                                  if (result == 'updatedStatus') {
                                    fetchExaminationToday();
                                    fetchExaminationUpcoming();
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
                                              'http://$ipDevice:8080/images/patients/${patient['image']}',
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
                                                    'completed') {
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
                            itemCount: examinationUpcoming.length,
                            itemBuilder: (BuildContext context, int index) {
                              final booking = examinationUpcoming[index];
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
                                  if (kDebugMode) {
                                    print(
                                      'Result from PatientScreenInDoctorPage: $result');
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
                                                'Clinic Hours: ${booking['clinicHours']}'),
                                            Text(
                                                'Medical Examination Day: ${booking['medicalExaminationDay']}'),
                                          ],
                                        ),
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            'http://$ipDevice:8080/images/patients/${patient['image']}',
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
                                                  'completed') {
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
