import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:intl/intl.dart';
import 'package:mobile/utils/constants.dart';

import '../../models/doctor.dart';
import '../../services/doctor/doctor_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../utils/ip_app.dart';
import 'package:http/http.dart' as http;


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ipDevice = BaseClient().ip;
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
    final Map<String, dynamic> data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _data = data;
    _doctorFuture =  getDoctorById(data['doctorId']);
    _doctorFuture.then((doctor) {
      if (doctor != null) {
        setState(() {
          fullNameDoctor = doctor.fullName;
          department = doctor.department.name;
          title = doctor.title;
          price = doctor.price;
        });
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
    setState(() {
    });
  }

 void handlePaypal(String paymentMethod,Map<String, dynamic> data){
    double priceFormat = data['price']/Constants.USD;
   if(paymentMethod == 'paypal'){
     AwesomeDialog(
       context: context,
       animType: AnimType.bottomSlide,
       dialogType: DialogType.success,
       body: Center(child: Text(
         'Dear ${_data['patientName']}!'
             'You have successfully booked your appointment! '
             'Please come to the medical examination facility on ${_data['medicalExaminationDay']} '
             'at ${_data['clinicHour']} to have a doctor examine you! '
             'Wish you quickly recovered. Best regards!',
         style: TextStyle(fontStyle: FontStyle.italic),
         textAlign: TextAlign.center,
       ),),
       btnOkOnPress: () {
         addAppointment(_data);
         Navigator.pushNamed(context, '/appointment/upcoming/detail');
       },
     )..show();
     Navigator.of(context).push(
         MaterialPageRoute(
           builder: (BuildContext context) => UsePaypal(
               sandboxMode: true,
               clientId:
               "${Constants.clientId}",
               secretKey:
               "${Constants.secretKey}",
               returnURL: "${Constants.returnURL}",
               cancelURL: "${Constants.cancelURL}",
               transactions:  [
                 {
                   "amount": {
                     "total": '10.2',
                     "currency": "USD",
                   },
                   "description":
                   "The payment transaction description.",
                 }
               ],
               note: "Contact us for any questions on your order.",
               onSuccess: (Map params) async {
                 AwesomeDialog(
                   context: context,
                   animType: AnimType.bottomSlide,
                   dialogType: DialogType.success,
                   body: Center(child: Text(
                     'Dear ${_data['patientName']}!'
                         'You have successfully booked your appointment! '
                         'Please come to the medical examination facility on ${_data['medicalExaminationDay']} '
                         'at ${_data['clinicHour']} to have a doctor examine you! '
                         'Wish you quickly recovered. Best regards!',
                     style: TextStyle(fontStyle: FontStyle.italic),
                     textAlign: TextAlign.center,
                   ),),
                   btnOkOnPress: () {
                      addAppointment(data);
                      Navigator.pushNamed(context, '/appointment/upcoming/detail');
                   },
                 )..show();
               },
               onError: (error) {
                 AwesomeDialog(
                   context: context,
                   animType: AnimType.bottomSlide,
                   dialogType: DialogType.error,
                   body: Center(child: Text(
                     'Dear ${_data['patientName']}! You have not successfully paid. Please re-book your medical examination.',
                     style: TextStyle(fontStyle: FontStyle.italic),
                     textAlign: TextAlign.center,
                   ),),
                   btnOkOnPress: () {
                   },
                 )..show();
               },
               onCancel: (params) {
                 print('cancelled: $params');
                 AwesomeDialog(
                   context: context,
                   animType: AnimType.bottomSlide,
                   dialogType: DialogType.error,
                   body: Center(child: Text(
                     'Dear ${_data['patientName']}! Your payment is cancelled. Please re-book your medical examination.',
                     style: TextStyle(fontStyle: FontStyle.italic),
                     textAlign: TextAlign.center,
                   ),),
                   btnOkOnPress: () {
                   },
                 )..show();
               }),
         ),
     );
   }else{

   }

 }

  void addAppointment(Map<String, dynamic> data) async {
    final _data = {
    "partientId" : data["partientId"],
    "doctorId" : data["doctorId"],
    "scheduledoctorId" : data["scheduledoctorId"],
    "price" : data["price"],
    "image" : data["image"],
    "title" : data["title"],
    "payment" : data["payment"],
    "status" : data["status"],
    "note" : data["note"],
    "appointmentDate" :data["appointmentDate"],
    "medicalExaminationDay" : data["medicalExaminationDay"],
    "clinicHours" : data["clinicHours"],
    "reason" : data["reason"],
    };
    final response = await http.post(
      Uri.parse(
          'http://$ipDevice:8080/api/appointment/create'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: jsonEncode(_data)
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
    } else {
      AwesomeDialog(
            context: context,
            animType: AnimType.bottomSlide,
            dialogType: DialogType.error,
            body: Center(child: Text(
              'There was an error inserting data, please try again',
              style: TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),),
            btnOkOnPress: () {
              //addAppointment(_data);
              //Navigator.pushNamed(context, '/appointment/upcoming/detail');
            },
          )..show();
    }
  }


  @override
  Widget build(BuildContext context) {

    String clinicHours = "08:30";
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
              const Text('Booking schedule information', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 20,),
              DataTable(
                columns: [
                  DataColumn(label: Text('Name', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ))),
                  DataColumn(label: Text('Result',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ))),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Doctor', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(Text('${fullNameDoctor!}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Specialist', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(Text('${department!}')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Examination day', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(Text('${_data['medicalExaminationDay']}')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Appointment time', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(Text('${formattedClinicHours}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Address', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(Text('590, CMT8, Q3. HCM')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Examination price', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(Text(NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(price))),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('Deposits', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(_data['price'])),
                            Text(' - '),
                            Text('${NumberFormat('#,##0.0', 'en_US').format(_data['price']! / 23000)} USD'),
                          ],
                        )
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Your Problem', style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
                    DataCell(Text('${_data['note']}')),
                  ]),

                ],
              ),
              const SizedBox(height: 15,),
              const Row(
                children: [
                  Text('Choose a deposit payment method:',style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'vnpay';
                              });
                            },
                            child: Image.asset('assets/images/vnpay.png', width: 60, height: 60),
                          ),
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
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'vnpay';
                        });
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = 'paypal';
                              });
                            },
                            child: Image.asset('assets/images/paypal.png', width: 60, height: 60),
                          ),
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
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'paypal';
                        });
                      },
                    ),
                  ],
                ),
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
                _data['payment'] = _selectedPaymentMethod;
                _data['doctorName'] = fullNameDoctor;
                handlePaypal(_selectedPaymentMethod, _data);

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
                child: const Text('PAYMENT TO COMPLETED BOOKING',
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
