import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<Map<String, String>> services = [
    {"icon": "assets/images/dermatology.png", "name": "All"},
    {"icon": "assets/images/dermatology.png", "name": "Dermatology"},
    {"icon": "assets/images/fetus.png", "name": "Fetus"},
    {"icon": "assets/images/ophthalmology.png", "name": "Ophthalmology"},
    {"icon": "assets/images/pediatrics.png", "name": "Pediatrics"},
    {"icon": "assets/images/rehabilitation.png", "name": "Rehabilitation"},
  ];
  final List<Map<String, String>> stars = [
    { "id": '1', "name": "All"},
    { "id": '2', "name": "5"},
    { "id": '3', "name": "4"},
    { "id": '4', "name": "3"},
    { "id": '5', "name": "2"},
    { "id": '6', "name": "1"},
  ];
  late List<bool> _activeBoxes;
  late List<bool> _activeBoxsRating;
  @override
  void initState() {
    super.initState();
    _activeBoxes = List.generate(services.length, (index) => false);
    _activeBoxsRating = List.generate(stars.length, (index) => false);
  }

  void _printActiveSpecial() {
    List<int> activeBoxIndices = [];
    for (int i = 0; i < _activeBoxes.length; i++) {
      if (_activeBoxes[i]) {
        activeBoxIndices.add(i);
      }
    }
    print(activeBoxIndices);
  }
  void _printActiveRating() {
    List<int> activeRateIndices = [];
    for (int i = 0; i < _activeBoxsRating.length; i++) {
      if (_activeBoxsRating[i]) {
        activeRateIndices.add(i);
      }
    }
    print(activeRateIndices);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filter', style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          )),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Special', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                )),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                    spacing: 10.0, // Khoảng cách giữa các hộp theo chiều ngang
                    runSpacing: 10.0,
                    children: List.generate(services.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeBoxes[index] = !_activeBoxes[index];
                          });
                          _printActiveSpecial();
                        },
                        child: Container(
                          //width: (MediaQuery.of(context).size.width - 60) / 3,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: _activeBoxes[index]
                                ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF93A6FD), // Đầu gradient color khi active
                                Color(0xFF9AC3FF), // Cuối gradient color khi active
                              ],
                            )
                                : const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFffffff), // Đầu gradient color khi không active
                                Color(0xFFffffff), // Cuối gradient color khi không active
                              ],
                            ),
                            border: _activeBoxes[index] ? null : Border.all(color: const Color(0xFF92A3FD), width: 1)
                          ),
                          child: Text(services[index]['name']!,
                            style: TextStyle(
                              color: _activeBoxes[index] ? Colors.white : const Color(0xFF92A3FD),
                              fontWeight: _activeBoxes[index] ? FontWeight.bold : FontWeight.normal,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,),
                        ),
                      );
                    })),
                const SizedBox(
                  height: 20,
                ),
                const Text('Rating', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                )),
                const SizedBox(
                  height: 20,
                ),

                Wrap(
                    spacing: 10.0, // Khoảng cách giữa các hộp theo chiều ngang
                    runSpacing: 10.0,
                    children: List.generate(stars.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeBoxsRating[index] = !_activeBoxsRating[index];
                          });
                          _printActiveRating();
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 60) / 3,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: _activeBoxsRating[index]
                                  ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF93A6FD), // Đầu gradient color khi active
                                  Color(0xFF9AC3FF), // Cuối gradient color khi active
                                ],
                              )
                                  : const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFffffff), // Đầu gradient color khi không active
                                  Color(0xFFffffff), // Cuối gradient color khi không active
                                ],
                              ),
                              border: _activeBoxsRating[index] ? null : Border.all(color: const Color(0xFF92A3FD), width: 1)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Icon(
                                  Icons.star,
                                  color: _activeBoxsRating[index] ? Colors.white : const Color(0xFF92A3FD),
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(stars[index]['name']!,
                                  style: TextStyle(
                                    color: _activeBoxsRating[index] ? Colors.white : const Color(0xFF92A3FD),
                                    fontWeight: _activeBoxsRating[index] ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,),
                                const SizedBox(
                                  width: 10,
                                )
                            ],
                          )
                        ),
                      );
                    }))
              ],
            )),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/doctor/booking');
                  },
                  child: Container(
                    //height: 50,
                    width: 180,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
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
                    child: const Text(
                      'Reset',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/doctor/booking');
                  },
                  child: Container(
                    //height: 50,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
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
                    child: const Text(
                      'Apply',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            )));
  }
}
