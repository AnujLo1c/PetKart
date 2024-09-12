import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pet_kart/SControllers/splash_screen_controller.dart';
import 'package:pet_kart/Screens/AppIntro/intro_screen.dart';
import 'package:pet_kart/Screens/BottomNav/home_bottom_nav_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/email_verification_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/forgetPassword_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/login_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/signUp_screen.dart';
import 'package:pet_kart/Screens/entry_screen.dart';

import 'Screens/LoginScreens/singUp_screenGoogle.dart';
import 'Screens/splash_screen.dart';
import 'Firebase/firebase_options.dart';

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
        //login
        GetPage(name: "/splash", page: () => const SplashScreen()),
        GetPage(name: "/login", page: () => const LoginScreen()),
        GetPage(name: "/forgetpass", page: () => const ForgetpasswordScreen()),
        GetPage(name: "/emailverify", page: () => const EmailVerificationScreen()),
        GetPage(name: "/signup", page: () => const SignupScreen()),
        GetPage(name: "/googlesignup", page: () => const SingupScreengoogle()),

        //EntryPage
        GetPage(name: "/entrySet", page: () => const EntryScreen()),

        //IntroScreen
        GetPage(name: "/intro", page: () => const IntroScreen()),

        //home_bottomnav
        GetPage(name: "/home", page: () => const HomeBottomNavScreen()),
      ],
      initialRoute: "/splash",
      unknownRoute: GetPage(name: "/login", page: () => const SignupScreen()),
    );
  }
}
