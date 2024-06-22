import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/ultils/storeCurrentUser.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  final TextEditingController _searchController = TextEditingController();
  final currentUser = CurrentUser.to.user;
  int currentIndex = 0;
  List<dynamic> departments = [];
  List<dynamic> doctors = [];

  final CarouselController carouselController = CarouselController();
  List<Map<String, String>> imageList = [
    {'image_path': 'assets/images/banner1.png'},
    {'image_path': 'assets/images/banner1.png'},
    {'image_path': 'assets/images/banner1.png'},
  ];

  Future<void> fetchDepartment() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.2:8080/api/department/all'));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          var result = jsonDecode(response.body);
          departments = result;
        });
      }
    } else {
      throw Exception('Failed to load departments');
    }
  }

  Future<void> fetchAllDoctors() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.2:8080/api/doctor/all'));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List<dynamic> doctorList = result;

      doctorList.sort((a, b) => b['rate'].compareTo(a['rate']));

      if (mounted) {
        setState(() {
          doctors = doctorList;
        });
      }
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDepartment();
    fetchAllDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Stack(
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
                        borderRadius: BorderRadius.circular(
                            0), // You can adjust the radius as needed
                        child: Image.network(
                          'http://192.168.1.2:8080/images/doctors/${currentUser['image']}',
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
                    icon: const Icon(Icons.notifications_active,
                        color: Colors.black),
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        Navigator.pushNamed(context, '/filter');
                      },
                      child: const Icon(
                        Icons.tune,
                        color: Color.fromARGB(255, 0, 98, 255),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Stack(
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
                              height:
                                  187, // Ensure the height is specified for BoxFit.cover
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 335 / 187, // Maintain aspect ratio 335:201
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
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
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
              ),
              const SizedBox(height: 25),
              _buildSectionTitle('Doctor Speciality'),
              const SizedBox(height: 25),
              _buildDepartmentGrid(),
              const SizedBox(height: 25),
              _buildSectionTitle('Top Doctors'),
              const SizedBox(height: 15),
              _buildDoctorGrid(),
            ],
          ),
        ),
      ),
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
        TextButton(
          onPressed: () {
            // Handle "See All" button press
          },
          child: const Text(
            'See All',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 98, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorGrid() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: doctors.length > 5 ? 5 : doctors.length,
      itemBuilder: (BuildContext context, int index) {
        var doctor = doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'http://192.168.1.2:8080/images/doctors/${doctor['image']}',
                          width: 70,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${doctor['title']} ${doctor['fullName']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            // Icon trái tim
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
                          ],
                        ),
                        const Divider(),
                        Text(
                          'Department : ${doctor['department']['name']}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            // Star icon for rating
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 32, 166, 255),
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${doctor['rate']} (${doctor['feedbackDtoList'].length} reviews)',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
          // Last item for "More" button
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
          // Display department item
          final item = departments[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color.fromARGB(255, 213, 227, 255),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(0), // Adjust the radius as needed
                  child: Image.network(
                    'http://192.168.1.2:8080/images/department/${item['icon']}',
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
              // Container to limit text overflow
              Container(
                width: 60, // Limit width to 60 for consistent layout
                child: Text(
                  item['name'],
                  textAlign: TextAlign.center,
                  maxLines: 1, // Maximum 1 line
                  overflow: TextOverflow.ellipsis, // Ellipsis (...) if overflow
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
