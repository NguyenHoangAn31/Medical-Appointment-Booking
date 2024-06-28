import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/services/patient_service.dart';

import '../../models/patient.dart';
import 'package:intl/intl.dart';

class DoctorBookingPatientScreen extends StatefulWidget {
  const DoctorBookingPatientScreen({super.key});

  @override
  State<DoctorBookingPatientScreen> createState() => _DoctorBookingPatientScreenState();
}

class _DoctorBookingPatientScreenState extends State<DoctorBookingPatientScreen> {
  late TextEditingController _fullNameTextController;
  late TextEditingController _ageTextController;
  late TextEditingController _genderTextController;
  late final TextEditingController _contentTextController = TextEditingController();
  late final int patientId;
  late String? patientName;
  late Future<Patient?> _patientFuture;
  late Map<String, dynamic> _data;


  int calculateAge(String birthday) {
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(birthday);

    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo TextEditingController với dữ liệu có sẵn
    _fullNameTextController = TextEditingController();
    _genderTextController = TextEditingController();
    _ageTextController = TextEditingController();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final Map<String, dynamic> data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    patientId = data['partientId'];
    _data = data;
    _patientFuture = PatientClient().getPatientById(patientId);
    _patientFuture.then((patient) {
      if (patient != null) {
        _fullNameTextController.text = patient.fullName;
        patientName = patient.fullName;
        _genderTextController.text = patient.gender;
        _ageTextController.text = calculateAge(patient.birthday.toString()).toString();
        debugPrint(_ageTextController.text);
      } else {
        // Handle case when patient data is null
        if (kDebugMode) {
          print('Patient data is null.');
        }
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error fetching patient data: $error');
      }
    });
  }



  @override
  void dispose() {
    // Giải phóng TextEditingController khi không còn cần thiết
    _contentTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF2F4F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Align(
                    child: TextField(
                      controller: _fullNameTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Full name',
                        counter: SizedBox.shrink(), // Ẩn counter cho nhập chữ số duy nhất
                        //alignLabelWithHint: true, // Canh giữa với dòng văn bản
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Color(0xFF98A2B2),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF2F4F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Align(
                    child: TextField(
                      controller: _ageTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Age',
                        counter: SizedBox.shrink(), // Ẩn counter cho nhập chữ số duy nhất
                        //alignLabelWithHint: true, // Canh giữa với dòng văn bản
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Color(0xFF98A2B2),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF2F4F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Align(
                    child: TextField(
                      controller: _genderTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Gender', // Ẩn counter cho nhập chữ số duy nhất
                        //alignLabelWithHint: true, // Canh giữa với dòng văn bản
                        counterText: '',
                        hintStyle: TextStyle(
                          color: Color(0xFF98A2B2),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF2F4F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Align(
                    child: TextField(
                      minLines: 1,
                      controller: _contentTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Your Problem',
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          color: Color(0xFF98A2B2),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: InkWell(
              onTap: (){
                // if(_contentTextController.text.isEmpty){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Please enter your problem'),
                //       duration: Duration(seconds: 2),
                //     ),
                //   );
                //   return;
                // }else{
                  _data['note'] = _contentTextController.text;
                  _data['patientName'] = patientName;
                  Navigator.pushNamed(context, '/doctor/booking/payment', arguments: _data);
                //}
              },
              child: Container(
                height: 50,
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
                child: const Text('NEXT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
              ),
            )
        )
    );
  }
}
