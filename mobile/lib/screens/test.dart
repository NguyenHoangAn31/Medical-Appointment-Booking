import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/services/Department/departmentApi.dart';
import 'package:mobile/ultils/color_app.dart';
import 'package:mobile/ultils/list_service.dart';

import '../../models/department.dart';
import '../../models/doctor.dart';
import '../../ultils/ip_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Department>> departments;
  Future<List<Doctor>>? doctors;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  bool _isSelectedHeart = false;
  final ipDevice = BaseClient().ip;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: <Widget>[
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      // Làm tròn các góc
                      child: const Image(
                        width: 50,
                        height: 50,
                        image: AssetImage('assets/images/login_default.jpg'),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Hello,',
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start),
                        Text(
                          'Nguyễn Khoa',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        size: 33,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.heart,
                        size: 28,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/favorites');
                      },
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // Search
            Container(
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
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        counter: SizedBox.shrink(),
                        // Ẩn counter cho nhập chữ số duy nhất
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
                      // Chuyển trang tại đây
                      Navigator.pushNamed(context, '/filter');
                    },
                    child: const Icon(
                      Icons.tune,
                      color: Color(0xFF98A2B2),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            // Upcoming Appointment
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Appointment ',
                      style: TextStyle(
                        color: AppColor.primaryText,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Create Account screen
                        Navigator.pushNamed(context, '/sign-in');
                      },
                      child: const Text(
                        'SEE ALL',
                        style: TextStyle(
                          color: Color(0xFF92A3FD),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF9AC3FF), // Đầu gradient color
                          Color(0xFF93A6FD), // Cuối gradient color
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        // Làm tròn các góc
                                        color: Colors.white, // Màu nền
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          'assets/images/doctor_01.png',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DR William Smith',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Dentist | Medicare Hospital',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  alignment: Alignment.topRight,
                                  onPressed: () {},
                                  icon: const FaIcon(
                                    FontAwesomeIcons.ellipsisVertical,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xFF8AABE7),
                                  ),
                                  child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        // Căn chỉnh các thành phần theo chiều dọc
                                        children: [
                                          Icon(Icons.date_range,
                                              color: Colors.red),
                                          // Biểu tượng
                                          SizedBox(width: 10),
                                          // Khoảng cách giữa biểu tượng và văn bản
                                          Text(
                                            'Sep 10, 2024',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          // Văn bản
                                        ],
                                      ))),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xFF8AABE7),
                                  ),
                                  child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        // Căn chỉnh các thành phần theo chiều dọc
                                        children: [
                                          Icon(Icons.alarm, color: Colors.red),
                                          // Biểu tượng
                                          SizedBox(width: 10),
                                          // Khoảng cách giữa biểu tượng và văn bản
                                          Text(
                                            '17:00 PM',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          // Văn bản
                                        ],
                                      )
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // List
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            //home title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Doctor Speciality',
                  style: TextStyle(
                    color: AppColor.primaryText,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Create Account screen
                    //Navigator.pushNamed(context, '/sign-in');
                  },
                  child: const Text(
                    'SEE ALL',
                    style: TextStyle(
                      color: Color(0xFF92A3FD),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // List view Service
            FutureBuilder<List<Department>>(
                future: departments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No departments found'));
                  } else {
                    return SizedBox(
                      height: 250, // Đặt chiều cao phù hợp cho GridView
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data!.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 25,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // Adjusts the column to take minimum space
                                children: [
                                  ClipRRect(
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment(-1.00, 0.08),
                                            end: Alignment(1, -0.08),
                                            colors: [
                                              Color(0xFF92A3FD),
                                              Color(0xFF9DCEFF)
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Image.network(
                                          'http://$ipDevice:8080/images/department/${snapshot.data![index].icon}',
                                          width: 25,
                                          height: 25,
                                          //fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    snapshot.data![index].name,
                                    style: TextStyle(
                                      color: AppColor.primaryText,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    // Thêm dấu ba chấm nếu văn bản quá dài
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                      ),
                    );
                  }
                }),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Doctors',
                  style: TextStyle(
                    color: AppColor.primaryText,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Create Account screen
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text(
                    'SEE ALL',
                    style: TextStyle(
                      color: Color(0xFF92A3FD),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder<List<Doctor>>(
                    future: doctors,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No departments found'));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Doctor doctor = snapshot.data![index];
                              return Container(
                                //height: 120,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
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
                                                borderRadius:
                                                BorderRadius.circular(50),
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
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doctor.fullName,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'Fetus | Medical Hospital',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.star,
                                                    size: 18,
                                                    color: Colors.orange),
                                                const SizedBox(width: 10),
                                                Text(doctor.rate.toString())
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      //alignment: Alignment.topRight,
                                        onPressed: () {
                                          setState(() {
                                            _isSelectedHeart =
                                            !_isSelectedHeart;
                                          });
                                        },
                                        icon: _isSelectedHeart
                                            ? const Icon(
                                          Icons.favorite,
                                          color: Color(0xFF92A3FD),
                                        )
                                            : const Icon(Icons.favorite_border,
                                            color: Color(0xFF92A3FD))),
                                  ],
                                ),
                              );
                            });
                      }
                    }
                    )
            )
          ],
        ),
      ),
    );
  }
}
