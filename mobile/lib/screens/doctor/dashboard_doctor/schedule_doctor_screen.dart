import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/ultils/ip_app.dart';
import 'package:mobile/ultils/storeCurrentUser.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ScheduleDoctorScreen extends StatefulWidget {
  const ScheduleDoctorScreen({super.key});

  @override
  State<ScheduleDoctorScreen> createState() => _ScheduleDoctorScreenState();
}

class _ScheduleDoctorScreenState extends State<ScheduleDoctorScreen> {
  List<dynamic> hoursList = [];
  List<dynamic> doctorHoursList = [];
  bool isRegistered = false;
  bool isShowButton = false;
  bool noHoursList = false;
  final ipDevice = BaseClient().ip;

  int? _slotIdSelect;
  String _daySelect = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final currentUser = CurrentUser.to.user;
  DateTime toDay = DateTime.now();
  DateTime daySelected = DateTime.now();
  void _onDaySelected(DateTime date, DateTime focusedDay) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(focusedDay);

    setState(() {
      daySelected = date;
      _daySelect = formattedDate;
      _slotIdSelect = 0;
      isShowButton = false;
    });
    fetchHoursList(formattedDate);
  }

  void _onSlotSelected() {
    log("date : $toDay");
    log("focusedDay : $daySelected");
    setState(() {
      isShowButton =
          toDay.isBefore(daySelected) || isSameDay(toDay, daySelected);
    });
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> _registerSchedule() async {
    if (_slotIdSelect != 0) {
      if (isRegistered) {
        final responseDelete = await http.delete(Uri.parse(
            'http://${ipDevice}:8080/api/schedules/checkdelete/${_daySelect}/${currentUser['department']['id']}/${currentUser['id']}/${_slotIdSelect}'));
        if (responseDelete.statusCode == 200) {
          fetchHoursList(_daySelect);
          isRegistered = !isRegistered;
        }
      } else {
        final responseCreate = await http.post(Uri.parse(
            'http://${ipDevice}:8080/api/schedules/checkcreate/${_daySelect}/${currentUser['department']['id']}/${currentUser['id']}/${_slotIdSelect}'));
        if (responseCreate.statusCode == 200) {
          fetchHoursList(_daySelect);
          isRegistered = !isRegistered;
        }
      }
    }
  }

  Future<void> fetchHoursList(String date) async {
    final responseHoursList = await http.get(Uri.parse(
        'http://${ipDevice}:8080/api/slot/slotsbydepartmentidandday/${currentUser['id']}/${date}'));
    final responseDoctorHoursList = await http.get(Uri.parse(
        'http://${ipDevice}:8080/api/slot/slotsbydepartmentiddoctoridandday/${currentUser['id']}/${currentUser['department']['id']}/${date}'));
    if (responseHoursList.statusCode == 200 &&
        responseDoctorHoursList.statusCode == 200) {
      setState(() {
        var resultHoursList = jsonDecode(responseHoursList.body);
        hoursList = resultHoursList;
        noHoursList = resultHoursList.isEmpty ? true : false;

        var resultDoctorHoursList = jsonDecode(responseDoctorHoursList.body);
        doctorHoursList = resultDoctorHoursList;
      });
    } else {
      throw Exception('Failed to load bookingToday');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHoursList(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[300],
          automaticallyImplyLeading: false, // Ẩn nút back button

          title: Obx(() => Text(
              'Department - ${currentUser['department']['name']}',
              style: const TextStyle(color: Colors.white))),
          centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Hour',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 400,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFEAEEFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TableCalendar(
                rowHeight: 43,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, daySelected),
                firstDay: DateTime.utc(2010, 01, 01),
                lastDay: DateTime.utc(2050, 12, 31),
                focusedDay: daySelected,
                onDaySelected: _onDaySelected,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Hour',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            hoursList.isEmpty && noHoursList
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/no_schedule.png'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'No schedules have been created yet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 200,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      mainAxisSpacing: 10,
                      children: List.generate(
                        hoursList.length,
                        (index) {
                          bool isDoctorHour = doctorHoursList.any(
                              (doctorHour) =>
                                  doctorHour['startTime'] ==
                                      hoursList[index]['startTime'] &&
                                  doctorHour['endTime'] ==
                                      hoursList[index]['endTime']);
                          return InkWell(
                            onTap: () {
                              _onSlotSelected();
                              setState(() {
                                if (isDoctorHour) {
                                  isRegistered = true;
                                } else {
                                  isRegistered = false;
                                }
                                _slotIdSelect = hoursList[index]['id'];
                              });
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors:
                                      _slotIdSelect == hoursList[index]['id']
                                          ? [
                                              const Color(0xFF9AC3FF),
                                              const Color(0xFF93A6FD),
                                            ]
                                          : [
                                              const Color.fromARGB(
                                                  255, 241, 241, 241),
                                              const Color.fromARGB(
                                                  255, 241, 241, 241),
                                            ],
                                ),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    title: Center(
                                      child: Text(
                                        '${hoursList[index]['startTime']} - ${hoursList[index]['endTime']}',
                                        style: TextStyle(
                                          color: _slotIdSelect ==
                                                  hoursList[index]['id']
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          textBaseline:
                                              TextBaseline.ideographic,
                                          height: -0.6,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -7,
                                    right: -7,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: isDoctorHour
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: isShowButton
          ? BottomAppBar(
              elevation: 0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  _registerSchedule();
                },
                child: Container(
                  height: 50,
                  width: 150,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isRegistered
                          ? [
                              const Color(0xFFFF9999),
                              const Color(0xFFFF6666),
                            ]
                          : [
                              const Color(0xFF9AC3FF),
                              const Color(0xFF93A6FD),
                            ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isRegistered ? 'Cancel' : 'Register',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
