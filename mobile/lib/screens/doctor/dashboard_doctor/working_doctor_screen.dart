import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/utils/ip_app.dart';
import 'package:mobile/utils/store_current_user.dart';


class WorkingDoctorScreen extends StatefulWidget {
  const WorkingDoctorScreen({Key? key}) : super(key: key);

  @override
  State<WorkingDoctorScreen> createState() => _WorkingDoctorScreenState();
}

class _WorkingDoctorScreenState extends State<WorkingDoctorScreen> {
  List<dynamic> workings = [];
  final currentUser = CurrentUser.to.user;
  final ipDevice = BaseClient().ip;

  TextEditingController _companyController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _startWorkController = TextEditingController();
  TextEditingController _endWorkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int? editingIndex;

  Future<void> fetchWorkings() async {
    try {
      final response = await http.get(Uri.parse(
          'http://${ipDevice}:8080/api/working/doctor/${currentUser['id']}'));

      if (response.statusCode == 200) {
        setState(() {
          workings = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load work experiences');
      }
    } catch (e) {
      print('Error fetching work experiences: $e');
    }
  }

  Future<void> createWorkExperience() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> newWorkExperience = {
        'company': _companyController.text,
        'address': _addressController.text,
        'startWork': _startWorkController.text,
        'endWork': _endWorkController.text,
        'doctor_id': currentUser['id'],
      };

      final response = await http.post(
        Uri.parse('http://${ipDevice}:8080/api/working/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newWorkExperience),
      );

      if (response.statusCode == 200) {
        fetchWorkings();
        _companyController.clear();
        _addressController.clear();
        _startWorkController.clear();
        _endWorkController.clear();
        Navigator.pop(context);
      } else {
        throw Exception('Failed to create work experience');
      }
    }
  }

  Future<void> updateWorkExperience(int id) async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> updatedWorkExperience = {
        'id': id,
        'company': _companyController.text,
        'address': _addressController.text,
        'startWork': _startWorkController.text,
        'endWork': _endWorkController.text,
        'status': 1,
        'doctor_id': currentUser['id'],
      };

      final response = await http.put(
        Uri.parse('http://${ipDevice}:8080/api/working/update/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedWorkExperience),
      );

      if (response.statusCode == 200) {
        fetchWorkings();
        setState(() {
          editingIndex = null;
        });
        Navigator.pop(context);
      } else {
        throw Exception('Failed to update work experience');
      }
    }
  }

  Future<void> deleteWorkExperience(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('http://${ipDevice}:8080/api/working/delete/$id'));

      if (response.statusCode == 200) {
        fetchWorkings();
      } else {
        throw Exception('Failed to delete work experience');
      }
    } catch (e) {
      print('Error deleting work experience: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWorkings();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('List Workings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // Đặt màu trắng cho nút back
        ),
      ),
      body: workings.isEmpty
          ? const Center(
              child: Text('No work experiences found'),
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: workings.length,
                    itemBuilder: (BuildContext context, int index) {
                      final work = workings[index];
                      final isEditing = editingIndex == index;

                      return Column(
                        children: [
                          ListTile(
                            title: Text('Company: ${work['company']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Address: ${work['address']}'),
                                const SizedBox(
                                    height: 4), // Adjust spacing as needed
                                Text('Start Date: ${work['startWork']}'),
                                Text('End Date: ${work['endWork']}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _companyController.text = work['company'];
                                    _addressController.text = work['address'];
                                    _startWorkController.text =
                                        work['startWork'];
                                    _endWorkController.text = work['endWork'];

                                    showModalBottomSheet(
                                      isScrollControlled:
                                          true, // Ensure the modal is scrollable
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        _companyController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Company'),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter Company';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _addressController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Address'),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter Address';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _startWorkController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Start Date'),
                                                    onTap: () async {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());
                                                      await _selectDate(context, _startWorkController);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter Start Date';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _endWorkController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'End Date'),
                                                    onTap: () async {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());
                                                      await _selectDate(context, _endWorkController);
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter End Date';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  const SizedBox(height: 20),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      updateWorkExperience(
                                                          work['id']);
                                                    },
                                                    child: const Text(
                                                        'Update Work Experience'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Delete'),
                                          content: const Text(
                                              'Are you sure you want to delete this work experience?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await deleteWorkExperience(
                                                    work['id']);
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
          _companyController.clear();
          _addressController.clear();
          _startWorkController.clear();
          _endWorkController.clear();

          showModalBottomSheet(
            isScrollControlled: true, // Ensure the modal is scrollable
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _companyController,
                          decoration: const InputDecoration(labelText: 'Company'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Company';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(labelText: 'Address'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _startWorkController,
                          decoration: const InputDecoration(labelText: 'Start Date'),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            await _selectDate(context, _startWorkController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Start Date';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _endWorkController,
                          decoration: const InputDecoration(labelText: 'End Date'),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            await _selectDate(context, _endWorkController);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter End Date';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            createWorkExperience();
                          },
                          child: const Text('Create Work Experience'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.blue[300], // Đặt màu nền là màu xanh dương
        foregroundColor: Colors.white,
        tooltip: 'Create Working',
        child: const Icon(Icons.add),
      ),
    );
  }
}
