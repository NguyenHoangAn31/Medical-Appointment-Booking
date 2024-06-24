import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/ultils/ip_app.dart';
import 'package:mobile/ultils/storeCurrentUser.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  final TextEditingController _searchController = TextEditingController();
  final currentUser = CurrentUser.to.user;
  int currentIndex = 0;
  bool noAppointments = false;
  List<dynamic> departments = [];
  List<dynamic> patientsUpcoming = [];

  final ipDevice = BaseClient().ip;

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final CarouselController carouselController = CarouselController();
  List<Map<String, String>> imageList = [
    {'image_path': 'assets/images/banner1.png'},
    {'image_path': 'assets/images/banner1.png'},
    {'image_path': 'assets/images/banner1.png'},
  ];

  @override
  void initState() {
    super.initState();
    fetchDepartment();
    fetchPatientUpcoming();
  }

  Future<void> fetchDepartment() async {
    final response =
        await http.get(Uri.parse('http://${ipDevice}:8080/api/department/all'));

    if (response.statusCode == 200) {
      setState(() {
        departments = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<void> fetchPatientUpcoming() async {
    final response = await http.get(Uri.parse(
        'http://${ipDevice}:8080/api/appointment/patientsbydoctoridandmedicalexaminationtoday/${currentUser['id']}/${today}/${today}'));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<dynamic> patientList = result;

      if (mounted) {
        setState(() {
          patientsUpcoming = patientList
              .where((patient) => patient["status"] == "waiting")
              .toList();
          noAppointments = patientsUpcoming.isEmpty ? true : false;
        });
      }
    } else {
      throw Exception('Failed to load patientList');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: _buildAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 30),
              _buildCarousel(),
              const SizedBox(height: 25),
              // _buildSectionTitle('Statistical'),
              // const SizedBox(height: 25),
              // _buildDepartmentGrid(),
              const SizedBox(height: 25),
              _buildSectionTitle('Patients Upcoming'),
              const SizedBox(height: 15),
              _buildPatientGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Stack(
      children: [
        AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 20,
          title: Container(),
        ),
        Positioned(
          top: 50.0,
          left: 20.0,
          right: 20.0,
          child: Row(
            children: [
              Obx(
                () => CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 136, 165, 255),
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.network(
                      'http://${ipDevice}:8080/images/doctors/${currentUser['image']}',
                      width: 40,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: Color.fromARGB(255, 125, 125, 125),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.wb_sunny,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ],
                  ),
                  Obx(() => Text(
                        '${currentUser['fullName']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              const Spacer(),
              IconButton(
                icon:
                    const Icon(Icons.notifications_active, color: Colors.black),
                onPressed: () {
                  // Handle notification button press
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  // Handle favorite button press
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: ShapeDecoration(
        color: const Color(0xFFF2F4F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Color(0xFF98A2B2),
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                counter: SizedBox.shrink(),
                counterText: '',
                hintStyle: TextStyle(
                  color: Color(0xFF98A2B2),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/filter');
            },
            child: const Icon(
              Icons.tune,
              color: Color.fromARGB(255, 0, 98, 255),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CarouselSlider(
            items: imageList
                .map(
                  (item) => Image.asset(
                    item['image_path']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 187,
                  ),
                )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 335 / 187,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                if (mounted) {
                  setState(() {
                    currentIndex = index;
                  });
                }
              },
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: currentIndex == entry.key ? 17 : 7,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentIndex == entry.key
                        ? const Color.fromARGB(255, 106, 170, 255)
                        : const Color.fromARGB(255, 209, 209, 209),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPatientGrid() {
    return noAppointments
        ? Column(
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
          )
        : ListView.builder(
            // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 7.0),
            itemCount: patientsUpcoming.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final examination = patientsUpcoming[index];
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
                    fetchPatientUpcoming();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ListTile(
                        title: Text(patient['fullName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Clinic Hours: ${examination['clinicHours']}'),
                            Text(
                                'Booking Date: ${examination['appointmentDate']}'),
                          ],
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'http://${ipDevice}:8080/images/patients/${patient['image']}',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: () {
                              if (examination['status'] == 'finished') {
                                return Colors.green[300];
                              } else if (examination['status'] == 'waiting') {
                                return Colors.orange[300];
                              } else {
                                return Colors.red[300];
                              }
                            }(),
                          ),
                          width: 75,
                          height: 30,
                          child: Center(
                            child: Text(
                              examination['status'],
                              style: const TextStyle(
                                color: Colors.white,
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
          );
  }

  Widget _buildDepartmentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: departments.length >= 8 ? 8 : departments.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 7) {
          return TextButton(
            onPressed: () {
              // Handle "More" button press
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 30,
                  color: Color.fromARGB(255, 0, 98, 255),
                ),
                SizedBox(height: 5),
                Text(
                  'More',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 98, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          final item = departments[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 213, 227, 255),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    'http://${ipDevice}:8080/images/department/${item['icon']}',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 60,
                child: Text(
                  item['name'],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
