import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'VNPay';
  @override
  Widget build(BuildContext context) {
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
              const Row(
                children: [
                  Text('Bác sĩ: '),
                  SizedBox(width: 10),
                  Text('Jonh Smith'),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Chuyên Khoa: '),
                  SizedBox(width: 10),
                  Text('Dentist'),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Giá khám: '),
                  SizedBox(width: 10),
                  Text('500.000 VNĐ'),
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
              const Row(
                children: [
                  Text('Giờ hẹn khám: '),
                  SizedBox(width: 10),
                  Text('08:00 - 08:30'),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Nội dung khám: '),
                  SizedBox(width: 10),
                  Text('Mắt trái bị sưng'),
                ],
              ),
              SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Đặt cọc: '),
                  SizedBox(width: 10),
                  Text('150.000 VNĐ'),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text('Chọn hình thức thanh toán đặt cọc: '),
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
                      value: 'VNPay',
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
                        Image.asset('assets/images/momo.png', width: 50, height: 50),
                      ],
                    ),
                    leading: Radio<String>(
                      value: 'Momo',
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
                      value: 'Paypal',
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
                Navigator.pushNamed(context, '/doctor/booking');
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
