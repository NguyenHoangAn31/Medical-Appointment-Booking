import 'package:flutter/material.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // Ẩn nút back button
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // URL hình ảnh thay thế tại đây
              radius: 25, // Kích thước hình ảnh
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                Text(
                  'John Doe', // Tên người dùng
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.notifications_active, color: Colors.black),
              onPressed: () {
                // Xử lý sự kiện bấm nút chuông ở đây
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // Xử lý sự kiện bấm nút trái tim ở đây
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                      color: Color.fromARGB(255, 0, 98, 255),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Khoảng cách giữa các phần tử
            // Các nội dung khác của màn hình điều có thể thêm ở đây
          ],
        ),
      ),
    );
  }
}
