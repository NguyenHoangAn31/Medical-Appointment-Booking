import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/ultils/ip_app.dart';
import 'package:mobile/ultils/storeCurrentUser.dart';

class QualificationDoctorScreen extends StatefulWidget {
  const QualificationDoctorScreen({Key? key}) : super(key: key);

  @override
  State<QualificationDoctorScreen> createState() =>
      _QualificationDoctorScreenState();
}

class _QualificationDoctorScreenState extends State<QualificationDoctorScreen> {
  List<dynamic> qualifications = [];
  final currentUser = CurrentUser.to.user;
    final ipDevice = BaseClient().ip;


  TextEditingController _courseController = TextEditingController();
  TextEditingController _degreeNameController = TextEditingController();
  TextEditingController _universityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchQualifications();
  }

  Future<void> fetchQualifications() async {
    final response = await http.get(Uri.parse(
        'http://${ipDevice}:8080/api/qualification/doctor/${currentUser['id']}'));

    if (response.statusCode == 200) {
      setState(() {
        qualifications = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load qualifications');
    }
  }

  Future<void> createQualification() async {
    final Map<String, dynamic> newQualification = {
      'course': _courseController.text,
      'degreeName': _degreeNameController.text,
      'universityName': _universityNameController.text,
      'status': 1,
      'doctor_id': currentUser['id'],
    };

    final response = await http.post(
      Uri.parse('http://${ipDevice}:8080/api/qualification/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newQualification),
    );

    if (response.statusCode == 200) {
      fetchQualifications();
      _courseController.clear();
      _degreeNameController.clear();
      _universityNameController.clear();
      Navigator.pop(context);
    } else {
      throw Exception('Failed to create qualification');
    }
  }

  Future<void> updateQualification(int id) async {
    final Map<String, dynamic> updatedQualification = {
      'id': id,
      'course': _courseController.text,
      'degreeName': _degreeNameController.text,
      'universityName': _universityNameController.text,
      'status': 1,
      'doctor_id': currentUser['id'],
    };

    final response = await http.put(
      Uri.parse('http://${ipDevice}:8080/api/qualification/update/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedQualification),
    );

    if (response.statusCode == 200) {
      fetchQualifications();
      Navigator.pop(context);
    } else {
      throw Exception('Failed to update qualification');
    }
  }

  Future<void> deleteQualification(int id) async {
    final response = await http.delete(
        Uri.parse('http://${ipDevice}:8080/api/qualification/delete/$id'));

    if (response.statusCode == 200) {
      fetchQualifications();
    } else {
      throw Exception('Failed to delete qualification');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('List Qualifications',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // Đặt màu trắng cho nút back
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: qualifications.length,
              itemBuilder: (BuildContext context, int index) {
                final qualification = qualifications[index];

                TextEditingController courseController = TextEditingController()
                  ..text = qualification['course'];
                TextEditingController degreeNameController =
                    TextEditingController()..text = qualification['degreeName'];
                TextEditingController universityNameController =
                    TextEditingController()
                      ..text = qualification['universityName'];

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                          'University : ${qualification['universityName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Degree : ${qualification['degreeName']}'),
                          const SizedBox(height: 4), // Adjust spacing as needed
                          Text('Course : ${qualification['course']}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _courseController.text = qualification['course'];
                              _degreeNameController.text =
                                  qualification['degreeName'];
                              _universityNameController.text =
                                  qualification['universityName'];

                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: _courseController,
                                            decoration: InputDecoration(
                                                labelText: 'Course'),
                                          ),
                                          TextField(
                                            controller: _degreeNameController,
                                            decoration: InputDecoration(
                                                labelText: 'Degree Name'),
                                          ),
                                          TextField(
                                            controller:
                                                _universityNameController,
                                            decoration: InputDecoration(
                                                labelText: 'University Name'),
                                          ),
                                          SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              updateQualification(
                                                  qualification['id']);
                                            },
                                            child: Text('Update Qualification'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this qualification?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await deleteQualification(
                                              qualification['id']);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _courseController,
                        decoration: InputDecoration(labelText: 'Course'),
                      ),
                      TextField(
                        controller: _degreeNameController,
                        decoration: InputDecoration(labelText: 'Degree Name'),
                      ),
                      TextField(
                        controller: _universityNameController,
                        decoration:
                            InputDecoration(labelText: 'University Name'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          createQualification();
                        },
                        child: Text('Create Qualification'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.blue[300], // Đặt màu nền là màu xanh dương
        foregroundColor: Colors.white, 
        tooltip: 'Create Qualification',
        child: const Icon(Icons.add),
      ),
    );
  }
}
