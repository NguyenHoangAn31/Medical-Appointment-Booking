import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/utils/ip_app.dart';
import 'package:mobile/utils/store_current_user.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class FeedbackDoctorScreen extends StatefulWidget {
  const FeedbackDoctorScreen({super.key});

  @override
  State<FeedbackDoctorScreen> createState() => _FeedbackDoctorScreenState();
}

class _FeedbackDoctorScreenState extends State<FeedbackDoctorScreen> {
  List<dynamic> feedbacks = [];
  List<dynamic> filteredFeedbacks = [];
  bool notContent = false;
  final TextEditingController _dateController = TextEditingController();
  final currentUser = CurrentUser.to.user;
  final ipDevice = BaseClient().ip;

  @override
  void initState() {
    super.initState();
    fetchFeedbacks();
  }

  Future<void> fetchFeedbacks() async {
    final response = await http.get(
      Uri.parse('http://$ipDevice:8080/api/feedback/${currentUser['id']}'),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      feedbacks = result['feedbackDtoList'];

      // Sort feedbacks based on 'createdAt' in descending order
      feedbacks.sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));

      filteredFeedbacks =
          feedbacks; // Assuming filteredFeedbacks is another variable you want to assign sorted feedbacks to

      setState(() {
        notContent = result.isEmpty;
      });
    } else {
      throw Exception('Failed to load feedbacks');
    }
  }

  List<Widget> _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    double halfStar = rating - fullStars;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 20.0,
      ));
    }

    if (halfStar >= 0.5) {
      stars.add(const Icon(
        Icons.star_half,
        color: Colors.yellow,
        size: 20.0,
      ));
    }

    // Add remaining empty stars if needed
    if (stars.length < 5) {
      int remaining = 5 - stars.length;
      for (int i = 0; i < remaining; i++) {
        stars.add(const Icon(
          Icons.star_border,
          color: Colors.yellow,
          size: 20.0,
        ));
      }
    }

    return stars;
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
      searchByDay(formattedDate);
    } else {
      setState(() {
        filteredFeedbacks = feedbacks;
        notContent = filteredFeedbacks.isEmpty;
      });
    }
  }

  void filterFeedbacksByDate(DateTime date) {
    setState(() {
      filteredFeedbacks = feedbacks.where((feedback) {
        DateTime createdAt = DateTime.parse(feedback['createdAt']);
        return createdAt.year == date.year &&
            createdAt.month == date.month &&
            createdAt.day == date.day;
      }).toList();
      notContent = filteredFeedbacks.isEmpty;
    });
  }

  void searchByDay(String input) {
    try {
      DateTime selectedDate = DateTime.parse(input);
      filterFeedbacksByDate(selectedDate);
    } catch (e) {
      if (kDebugMode) {
        print('Invalid date format: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],

        title:
            const Text('List Feedbacks', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Ẩn nút back button
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Color(0xFF98A2B2),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        ),
                        labelText: 'Select Date',
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_today),
                        border: InputBorder.none,
                        fillColor: Color.fromARGB(255, 246, 246, 246),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate();
                      },
                    ),
                  ),
                ],
              ),
            ),
            notContent
                ? Container(
                    margin: const EdgeInsets.only(top: 75.0),
                    child: Center(
                      child: Column(
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
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredFeedbacks.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (BuildContext context, int index) {
                      final feedback = filteredFeedbacks[index];
                      double rating = feedback['rate'] is int
                          ? feedback['rate'].toDouble()
                          : feedback['rate'];
                      String timeAgo =
                          timeago.format(DateTime.parse(feedback['createdAt']));
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 75.0,
                                height: 75.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    'http://$ipDevice:8080/images/patients/${feedback['patient']['image']}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: feedback['patient']
                                                ['fullName'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: ' ($timeAgo)',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: _buildRatingStars(rating),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(feedback['comment']),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
