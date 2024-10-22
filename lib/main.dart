import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pet_kart/SControllers/splash_screen_controller.dart';
import 'package:pet_kart/SControllers/theme_controller.dart';
import 'package:pet_kart/Screens/Adoption/adoption_page.dart';
import 'package:pet_kart/Screens/Adoption/pet_adoption_chat_home.dart';
import 'package:pet_kart/Screens/Adoption/pet_adoption_chat_room_screen.dart';
import 'package:pet_kart/Screens/Adoption/pet_adoption_details_screen.dart';
import 'package:pet_kart/Screens/Adoption/pet_rehome_screen.dart';
import 'package:pet_kart/Screens/AppIntro/intro_screen.dart';
import 'package:pet_kart/Screens/AppIntro/welcome_screen.dart';
import 'package:pet_kart/Screens/BottomNav/bottom_nav_screen.dart';
import 'package:pet_kart/Screens/Community/community_page.dart';
import 'package:pet_kart/Screens/Home/home_page.dart';
import 'package:pet_kart/Screens/Information/info_page.dart';
import 'package:pet_kart/Screens/LoginScreens/email_verification_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/forgetPassword_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/login_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/signUp_screen.dart';
import 'package:pet_kart/Screens/Profile/history_screen.dart';
import 'package:pet_kart/Screens/Profile/profile_page.dart';
import 'package:pet_kart/Screens/Profile/settings_screen.dart';
import 'Screens/LoginScreens/singUp_screenGoogle.dart';
import 'Screens/Profile/booking_status_screen.dart';
import 'Screens/Profile/help_screen.dart';
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
    final ThemeController themeController=Get.put(ThemeController());
    return Obx(
      ()=> GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PetKart',
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode: themeController.themeMode.value,
        getPages: [
          //login
          GetPage(name: "/splash", page: () => const SplashScreen()),
          GetPage(name: "/login", page: () => const LoginScreen()),
          GetPage(name: "/forgetpass", page: () => const ForgetpasswordScreen()),
          GetPage(name: "/emailverify", page: () => const EmailVerificationScreen()),
          GetPage(name: "/signup", page: () => const SignupScreen()),
          GetPage(name: "/googlesignup", page: () => const SingupScreengoogle()),

          //IntroScreen
          GetPage(name: "/intro", page: () => const IntroScreen()),
          GetPage(name: "/welcome", page: () => const WelcomeScreen()),

          //home_bottom_nav
          GetPage(name: "/home", page: () => const BottomNavScreen()),

          //profile
          GetPage(name: "/profile", page: ()=>const ProfilePage()),
          GetPage(name: "/help", page: ()=>const HelpScreen()),
          GetPage(name: "/booking_status", page: ()=>const BookingStatusScreen()),
          GetPage(name: "/history", page: ()=>const HistoryScreen()),
          GetPage(name: "/settings", page: ()=>const SettingsScreen()),

          //home
          GetPage(name: "/home", page: ()=>const HomePage()),//bottom Navigation Page

          //info
          GetPage(name: "/info", page: ()=>const InfoPage()),//bottom Navigation Page

          //community
          GetPage(name: "/community", page: ()=>const CommunityPage()),//bottom Navigation Page

          //adoption
          GetPage(name: "/adopt", page: ()=>const AdoptionPage()),//bottom Navigation Page
          GetPage(name: "/adopt_pet_details", page: ()=>const PetAdoptionDetailsScreen()),
          GetPage(name: "/adopt_rehome", page: ()=>const PetRehomeScreen()),
          GetPage(name: "/adopt_chat_home", page: ()=>const PetAdoptionChatHome()),
          GetPage(name: "/adopt_chat_room", page: ()=>const PetAdoptionChatRoomScreen()),

        ],
        initialRoute: "/splash",
        // initialRoute: "/home",
        unknownRoute: GetPage(name: "/login", page: () => const SignupScreen()),//bottom Navigation Page
      ),
    );
  }
}
