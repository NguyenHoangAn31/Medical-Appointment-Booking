import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({super.key});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

            title: const Text('Dr. Join Smith', style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            )),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],


        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  
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
            child: const Text('BOOKING APPOINTMENT',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),),
          ),
        )
      )

      ,
    );
  }
}
