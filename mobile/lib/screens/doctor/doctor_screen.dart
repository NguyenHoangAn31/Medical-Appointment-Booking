import 'package:flutter/material.dart';
import '../../models/department.dart';
import '../../models/doctor.dart';
import '../../services/Department/department_api.dart';
import '../../utils/ip_app.dart';
import '../../utils/list_service.dart';


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final ipDevice = BaseClient().ip;
  late Future<List<Department>> departments;
  Future<List<Doctor>>? doctors;
  int _selectedIndex = 0;
  bool _isSelectedHeart= false;
  @override
  void initState() {
    super.initState();
    departments = getDepartments();
    doctors = getDoctorByDepartmentId(0);
  }
  void _handleSelected(int index) {
    setState(() {
      _selectedIndex = index;
      doctors = getDoctorByDepartmentId(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Doctors', style: TextStyle(color: Colors.black, fontSize: 22)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action for search button
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              // Action for tune button
              Navigator.pushNamed(context, '/filter');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:  SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<Department>>(
                future: departments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No departments found'));
                  } else {
                    // Create a list of widgets from the data
                    List<Widget> departmentWidgets = [
                      ListService(
                        index: 0,
                        text: 'All',
                        selectedIndex: _selectedIndex,
                        onSelected: _handleSelected,
                      ),
                      const SizedBox(width: 8),
                    ];
                    for (var department in snapshot.data!) {
                      departmentWidgets.add(
                        ListService(
                          index: department.id,
                          text: department.name,
                          selectedIndex: _selectedIndex,
                          onSelected: _handleSelected,
                        ),
                      );
                      departmentWidgets.add(const SizedBox(width: 8));
                    }
                    // Return a Row containing the list of widgets
                    return Row(
                      children: departmentWidgets,
                    );
                  }
                },
              ),
            ),
          ),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<List<Doctor>>(
          future: doctors,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No doctors found'));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: snapshot.data!.map((doctor) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/doctor', arguments:
                                {
                                  'doctorId': doctor.id,
                                });
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        //padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Image.network(
                                          'http://$ipDevice:8080/images/doctors/${doctor.image}',
                                          // width: 25,
                                          // height: 25,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${doctor.title} ' '${doctor.fullName}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${doctor.department.name} | Medical Hospital',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.star, size: 18, color: Colors.orange),
                                          const SizedBox(width: 10),
                                          Text(doctor.rate.toString())
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isSelectedHeart = !_isSelectedHeart;
                                });
                              },
                              icon: _isSelectedHeart
                                  ? const Icon(Icons.favorite, color: Color(0xFF92A3FD))
                                  : const Icon(Icons.favorite_border, color: Color(0xFF92A3FD)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarItem(
      //     icon: Icon(Icons.home)),
    );
  }
}
