import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mobile/models/schedule.dart';
import 'package:mobile/services/doctor/doctorService.dart';
//import 'package:mobile/widgets/notication/success_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/doctor.dart';
import '../../ultils/ip_app.dart';
import '../../widgets/notication/error_widget.dart';


class DoctorBookingScreen extends StatefulWidget {
  const DoctorBookingScreen({super.key});

  @override
  State<DoctorBookingScreen> createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  final ipDevice = BaseClient().ip;


  int? _selectedIndex;
  int? _scheduleDoctorId;
  String? _timeSelected;
  int? _patientId;
  double? price;
  late final DateTime _appointmentDay = DateTime.now();


  late final int doctorId;
  late Future<Doctor> _doctorFuture;
  late Future<List<Schedule>> _scheduleFuture;
  late DateTime toDay;
  late List<String?> validHours = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = -1;
  }


  void _onDaySelected(DateTime date, DateTime focusedDay){
    setState(() {
      toDay = date;
      _patientId = 5;
    });
    _scheduleFuture =  getScheduleByDoctorIdAndDay(doctorId, toDay);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    doctorId = arguments['doctorId'] as int;
     _doctorFuture = getDoctorById(doctorId);
    toDay = DateTime.now();
    _scheduleFuture =  getScheduleByDoctorIdAndDay(doctorId, toDay);
    _scheduleFuture.then((schedules) {
      setState(() {
        validHours = schedules.map((schedule) => schedule.startTime).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Appointment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: _doctorFuture,
                builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                      return const Center(child: Text('Doctor not found'));
                      } else {
                          Doctor doctor = snapshot.data!;
                          price = doctor.price as double?;
                          return  Container(
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
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ]
                            ),
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
                                        //fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Dr. ${doctor.fullName}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Text('${doctor.department.name} |'),
                                        const SizedBox(width: 10,),
                                        Text('${doctor.price} VND'),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    const Row(children: [
                                      Icon(Icons.location_pin, color: Colors.cyan,),
                                      SizedBox(width: 10,),
                                      Text('Medicare Hospital'),
                                    ])
                                  ],
                                )
                              ],
                            ),
                          );
                      }
                }),

            const SizedBox(height: 20,),
            const Text('Select Date', style:
            TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 20,),
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
                  ]
              ),
              child: Container(
                child: TableCalendar(
                  rowHeight: 43,
                  headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, toDay),
                  firstDay: DateTime.utc(2010, 01, 01),
                  lastDay: DateTime.utc(2050, 12, 31),
                  focusedDay: toDay,
                  onDaySelected: _onDaySelected,
                  enabledDayPredicate: (day) {
                    // Only enable days from today onwards
                    return !day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
                  },
                ),
              )
                ,

            ),
            const SizedBox(height: 20,),
            const Text('Select Hour', style:
              TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
              child: FutureBuilder<List<Schedule>>(
                future: _scheduleFuture,
                builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                    return const Center(
                    child: CircularProgressIndicator());
                    } else if (!snapshot.hasData ||
                    snapshot.data!.isEmpty || snapshot.hasError) {
                    return const Center(
                        child: Text('Bác sĩ không có lịch khám bệnh ngày hôm nay'));
                    } else {
                          return SizedBox(// Đặt chiều cao phù hợp cho GridView
                            height: 700,
                            child: GridView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                bool isSelected = _selectedIndex == index;
                                int? status = snapshot.data![index].status;
                                int? scheduleDoctorId = snapshot.data![index].scheduledoctorId;
                                String? timeSelected = snapshot.data![index].startTime;
                                //Schedule schedule = snapshot.data! as Schedule;
                                return GestureDetector(
                                  onTap: () {
                                    if (status == 1) {
                                      setState(() {
                                        _selectedIndex = index;
                                        _scheduleDoctorId = scheduleDoctorId;
                                        _timeSelected = timeSelected;
                                       //print('Selected Index: $index, ScheduleDoctorId: $scheduleDoctorId');
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      // color: isSelected ? Colors.blue : Colors.white54,
                                      color: status == 0
                                          ? Colors.red
                                          : isSelected
                                          ? Colors.blue
                                          : Colors.white54,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          snapshot.data![index].startTime.toString(),
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                    }

                },
              ),

            ),

          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: InkWell(
              onTap: (){
                var data = {
                  'doctorId' : doctorId,
                  'medicalExaminationDay': toDay.toIso8601String().split('T')[0],
                  'clinicHour': _timeSelected,
                  'scheduledoctorId': _scheduleDoctorId,
                  'appointmentDate': _appointmentDay.toIso8601String().split('T')[0],
                  'partientId': _patientId,
                  'price': price != null ? price! * 0.3 : 0,
                  'note': '',
                  'payment': '',
                  'status': 'waiting',
                };
                if (_selectedIndex != -1) {
                  Navigator.pushNamed(context, '/doctor/booking/patient', arguments: data);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please choose a clinic hour'),
                    ),
                  );
                }
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
                child: const Text('NEXT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
              ),
            )
        )
    );
  }
}
