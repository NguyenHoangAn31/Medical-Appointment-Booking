import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ultils/list_service.dart';


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  int _selectedIndex = 0;
  bool _isSelectedHeart= false;
  void _handleSelected(int index) {
    setState(() {
      _selectedIndex = index;
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
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical:10),
            child :  SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ListService(
                    index: 0,
                    text: 'All',
                    selectedIndex: _selectedIndex,
                    onSelected: _handleSelected,
                  ),
                  const SizedBox(width: 8),
                  ListService(
                    index: 1,
                    text: 'Dermatology',
                    selectedIndex: _selectedIndex,
                    onSelected: _handleSelected,),
                  const SizedBox(width: 8),
                  ListService(
                    index: 2,
                    text: 'Fetus',
                    selectedIndex: _selectedIndex,
                    onSelected: _handleSelected,
                  ),
                  const SizedBox(width: 8),
                  ListService(
                    index: 3,
                    text: 'Ophthalmology',
                    selectedIndex: _selectedIndex,
                    onSelected: _handleSelected,
                  ),
                  const SizedBox(width: 8),
                  ListService(
                    index: 4,
                    text: 'Pediatrics',
                    selectedIndex: _selectedIndex,
                    onSelected: _handleSelected,
                  ),
                  const SizedBox(width: 8),
                  ListService(
                    index: 5,
                    text: 'Rehabilitation',
                    selectedIndex: _selectedIndex,
                    onSelected: _handleSelected,
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
      body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 600,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
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
                                  print('Dr. William Sminth');
                                  Navigator.pushNamed(context, '/doctor');
                                },
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
                                        Text('Dr. William Smith',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        SizedBox(height: 5),
                                        Text(
                                          'Fetus | Medical Hospital',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),),
                                        SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star, size: 18, color: Colors.orange),
                                            SizedBox(width: 10),
                                            Text('5.0')
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                //alignment: Alignment.topRight,
                                  onPressed: () {
                                    setState(() {
                                      _isSelectedHeart = !_isSelectedHeart;
                                    });
                                  },
                                  icon: _isSelectedHeart ? const Icon(Icons.favorite, color: Color(0xFF92A3FD),) : const Icon(Icons.favorite_border, color: Color(0xFF92A3FD))
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),

                      ],
                    ),
                  ),
                )
              ],
            )
      ),
      // bottomNavigationBar: BottomNavigationBarItem(
      //     icon: Icon(Icons.home)),
    );
  }
}
