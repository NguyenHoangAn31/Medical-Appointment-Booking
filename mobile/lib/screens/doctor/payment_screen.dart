import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/doctor.dart';
import '../../services/doctor/doctorService.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'vnpay';
  late Future<Doctor> _doctorFuture;
  @override
  void initState() {
    super.initState();
    // Khởi tạo TextEditingController với dữ liệu có sẵn
  }

  late String? fullNameDoctor;
  late String? department;
  late String? title;
  late double? price;
  late Map<String, dynamic> _data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final Map<String, dynamic> data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _doctorFuture =  getDoctorById(data['doctorId']);
    _data = data;
    _doctorFuture.then((doctor) {
      if (doctor != null) {
        fullNameDoctor = doctor.fullName;
        department = doctor.department.name;
        title = doctor.title;
        price = doctor.price;
      } else {
        // Handle case when patient data is null
        print('Patient data is null.');
      }
    }).catchError((error) {
      print('Error fetching patient data: $error');
    });


  }





  @override
  Widget build(BuildContext context) {
    String clinicHours = _data['clinicHour'];
    int durationMinutes = 30;

    TimeOfDay startTime = TimeOfDay(
      hour: int.parse(clinicHours.split(":")[0]),
      minute: int.parse(clinicHours.split(":")[1]),
    );

    // Tính toán thời gian kết thúc
    TimeOfDay endTime = startTime.replacing(
      hour: (startTime.hour + (startTime.minute + durationMinutes) ~/ 60) % 24,
      minute: (startTime.minute + durationMinutes) % 60,
    );

    // Tạo chuỗi hiển thị
    String formattedClinicHours = "${startTime.format(context)} - ${endTime.format(context)}";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thông tin lịch book'),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('Bác sĩ: '),
                  const SizedBox(width: 10),
                  Text(fullNameDoctor!),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('Khoa: '),
                  const SizedBox(width: 10),
                  Text('$department'),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('Giá khám: '),
                  const SizedBox(width: 10),
                  Text('$price VNĐ'),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Địa chỉ khám: '),
                  SizedBox(width: 10),
                  Text('10, Nguyễn Thị Thập, Quận 7'),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Ngày khám: '),
                  SizedBox(width: 10),
                  Text('04/06/2024'),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('Giờ hẹn khám: '),
                  const SizedBox(width: 10),
                  Text(formattedClinicHours),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('Nội dung khám: '),
                  const SizedBox(width: 10),
                  Text('${_data['note']}'),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text('Đặt cọc: '),
                  const SizedBox(width: 10),
                  Text('${_data['price']} VNĐ'),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Choose a deposit payment method: '),
                ],
              ),
              const SizedBox(height: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: [
                        Image.asset('assets/images/vnpay.png', width: 50, height: 50),
                      ],
                    ),
                    leading: Radio<String>(
                      value: 'vnpay',
                      groupValue: _selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Image.asset('assets/images/paypal.png', width: 50, height: 50),
                      ],
                    ),
                    leading: Radio<String>(
                      value: 'paypal',
                      groupValue: _selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
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
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return const SuccessWidget(
                //       title: 'Your Appointment Failed!',
                //       message: 'Appointment with Dr. Jennie Thorn failed. Please check then try again.',
                //     );
                //   },
                // );
                _data['payment'] = _selectedPaymentMethod;
                print(_data);
                //Navigator.pushNamed(context, '/doctor/booking');
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
