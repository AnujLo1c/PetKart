import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:pet_kart/SControllers/splash_screen_controller.dart';
import 'package:pet_kart/Screens/LoginScreen/login_mobile.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetKart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      getPages: [
GetPage(name: "/splash", page: () => const SplashScreen()),
GetPage(name: "/login", page: () => const LoginMobile())
      ],
      initialRoute: "/splash",
      unknownRoute: GetPage(name: "/login", page: () => const LoginMobile()),
    );
  }
}
