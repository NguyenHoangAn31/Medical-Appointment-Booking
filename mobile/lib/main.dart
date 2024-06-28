import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile/routes/route.dart';
import 'package:mobile/screens/welcome_screen.dart';
import 'package:mobile/utils/navigator_key.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/store_current_user.dart';



void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(CurrentUser());

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Medicare app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: const WelcomeScreen(),
      routes: Routes.getRoutes(),
    );
  }
}

