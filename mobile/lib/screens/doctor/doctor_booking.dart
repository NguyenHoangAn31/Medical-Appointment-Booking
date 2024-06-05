import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:table_calendar/table_calendar.dart';

//import '../../ultils/color_app.dart';

class DoctorBookingScreen extends StatefulWidget {
  const DoctorBookingScreen({super.key});

  @override
  State<DoctorBookingScreen> createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  final List<Map<String, String>> hoursList = [
    {"id": "1", "name": "08:00"},
    {"id": "2", "name": "08:30"},
    {"id": "3", "name": "09:00"},
    {"id": "4", "name": "09:30"},
    {"id": "5", "name": "10:00"},
    {"id": "6", "name": "10:30"},
    {"id": "7", "name": "11:00"},
    {"id": "8", "name": "11:30"},
    {"id": "9", "name": "13:00"},
    {"id": "10", "name": "13:30"},
    {"id": "11", "name": "14:00"},
    {"id": "12", "name": "14:30"},
    {"id": "13", "name": "15:00"},
    {"id": "14", "name": "15:30"},
    {"id": "15", "name": "16:00"},
    {"id": "16", "name": "16:30"},
    {"id": "17", "name": "18:00"},
    {"id": "18", "name": "18:30"},
    {"id": "19", "name": "19:00"},
    {"id": "20", "name": "19:30"},
    {"id": "21", "name": "20:00"},
    {"id": "22", "name": "20:30"},
  ];
  int? _selectedIndex;

  DateTime toDay = DateTime.now();
  void _onDaySelected(DateTime date, DateTime focusedDay){
    setState(() {
      toDay = date;
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
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          'assets/images/doctor_01.png',
                          width: 25,
                          height: 25,
                          //fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. Join Smith',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text('Dentist |'),
                          SizedBox(width: 10,),
                          Text('500.000 VND'),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(children: [
                        Icon(Icons.location_pin, color: Colors.cyan,),
                        SizedBox(width: 10,),
                        Text('Medicare Hopital'),
                      ])
                    ],
                  )
                ],
              ),
            ),
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
            SizedBox(// Đặt chiều cao phù hợp cho GridView
              height: 500,
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                itemCount: hoursList.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white54,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 30,
                        child: Center(
                          child: Text(
                            hoursList[index]["name"]!,
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
                Navigator.pushNamed(context, '/doctor/booking/patient');
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
