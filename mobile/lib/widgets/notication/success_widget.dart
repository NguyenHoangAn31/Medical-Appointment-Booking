import 'package:flutter/material.dart';

class SuccessWidget extends StatelessWidget {
  final String title;
  final String message;
  final String routeName;
  final String titleButton;

  const SuccessWidget({super.key, required this.title, required this.message, required this.routeName, required this.titleButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      width: 340,
      height: 452,
      padding: const EdgeInsets.all(32),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(10, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: Column(
           children: [
             Container(
               width: 142,
               height: 142,
               child: Stack(
                 children: [
                   Positioned(
                     left: 0,
                     top: 0,
                     child: Container(
                       width: 142,
                       height: 142,
                       decoration: const ShapeDecoration(
                         gradient: LinearGradient(
                           begin: Alignment(-1.00, 0.08),
                           end: Alignment(1, -0.08),
                           colors: [Color(0xFFC58BF2), Color(0xFFEEA4CE)],
                         ),
                         shape: CircleBorder(),
                       ),
                     ),
                   ),
                   Positioned(
                     left: 40,
                     top: 40,
                     child: Container(
                       width: 62,
                       height: 62,
                       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                       clipBehavior: Clip.antiAlias,
                       decoration: const BoxDecoration(),
                       child: const Icon(
                         Icons.verified_user,
                         color: Colors.white,
                         size: 60,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 20,),
             Column(
               children: [
                 Text(
                   title,
                   textAlign: TextAlign.center,
                   style: const TextStyle(
                     color: Color(0xFFC58BF2),
                     fontSize: 20,
                     fontFamily: 'Poppins',
                     fontWeight: FontWeight.w600,
                     //height: 0.07,
                     letterSpacing: 0.03,
                   ),
                 ),
                 const SizedBox(height: 20),
                 Text(
                   message,
                   textAlign: TextAlign.center,
                   style: const TextStyle(
                     color: Color(0xFF101828),
                     fontSize: 14,
                     fontFamily: 'Poppins',
                     fontWeight: FontWeight.w400,
                     // height: 0.12,
                     letterSpacing: 0.11,
                   ),
                   softWrap: true, // Cho phép văn bản tự động xuống dòng khi cần thiết
                   overflow: TextOverflow.visible,
                 ),

               ],
             ),
             const SizedBox(height: 20,),
             Container(
               width: double.infinity,
               height: 52,
               padding: const EdgeInsets.all(16),
               decoration: ShapeDecoration(
                 gradient: const LinearGradient(
                   begin: Alignment(-1.00, 0.08),
                   end: Alignment(1, -0.08),
                   colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                 ),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(40),
                 ),
               ),
               child: InkWell(
                 onTap: () {
                   Navigator.pushNamed(context, routeName);
                 },
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text(
                       titleButton,
                       style: const TextStyle(
                         color: Colors.white,
                         fontSize: 16,
                         fontFamily: 'Poppins',
                         fontWeight: FontWeight.w600,
                         height: 0.08,
                         letterSpacing: 0.02,
                       ),
                     ),
                   ],
                 ),
               )

             ),

           ],
        ),
      )
    );
  }
}
