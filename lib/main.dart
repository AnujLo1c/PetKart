import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:pet_kart/SControllers/theme_controller.dart';
import 'package:pet_kart/Screens/Adoption/adoption_confirmation_screen.dart';
import 'package:pet_kart/Screens/Adoption/adoption_form_screen.dart';
import 'package:pet_kart/Screens/Adoption/adoption_page.dart';
import 'package:pet_kart/Screens/Adoption/adoption_thankyou_screen.dart';
import 'package:pet_kart/Screens/Adoption/pet_adoption_chat_home.dart';
import 'package:pet_kart/Screens/Adoption/pet_adoption_chat_room_screen.dart';
import 'package:pet_kart/Screens/Adoption/pet_adoption_details_screen.dart';
import 'package:pet_kart/Screens/Adoption/pet_rehome_screen.dart';
import 'package:pet_kart/Screens/AppIntro/intro_screen.dart';
import 'package:pet_kart/Screens/AppIntro/welcome_screen.dart';
import 'package:pet_kart/Screens/BottomNav/bottom_nav_screen.dart';
import 'package:pet_kart/Screens/Community/community_search_screen.dart';
import 'package:pet_kart/Screens/Community/community_page.dart';
import 'package:pet_kart/Screens/Home/cart_screen.dart';
import 'package:pet_kart/Screens/Home/home_page.dart';
import 'package:pet_kart/Screens/Home/pay_confirm_screen.dart';
import 'package:pet_kart/Screens/Information/dog_detail_screen.dart';
import 'package:pet_kart/Screens/Information/info_options_screen.dart';
import 'package:pet_kart/Screens/Information/info_page.dart';
import 'package:pet_kart/Screens/LoginScreens/email_verification_screen.dart';
import 'package:pet_kart/Screens/LoginScreens/forgetPassword_screen.dart';
import 'package:pet_kart/Screens/Profile/history_screen.dart';
import 'package:pet_kart/Screens/Profile/profile_details_update_screen.dart';
import 'package:pet_kart/Screens/Profile/profile_page.dart';
import 'package:pet_kart/Screens/Profile/settings_screen.dart';
import 'package:pet_kart/Screens/auth_check.dart';
import 'package:pet_kart/secret.dart';
import 'SControllers/AdoptionPageController/Adoption_request_details_screen.dart';
import 'SControllers/persistent_data_controller.dart';
import 'Screens/Adoption/adoption_requests_screen.dart';
import 'Screens/Adoption/pet_rehome_home_screen.dart';
import 'Screens/Community/community_create_screen.dart';
import 'Screens/Community/community_home_screen.dart';
import 'Screens/Community/community_search_home_screen.dart';
import 'Screens/Home/address_screen.dart';
import 'Screens/Home/final_order_screen.dart';
import 'Screens/Home/food_acc_screen.dart';
import 'Screens/Home/pet_buy_screen.dart';
import 'Screens/Home/pet_display_screen.dart';
import 'Screens/Information/animal_detail_screen.dart';
import 'Screens/LoginScreens/login_signup_screen.dart';
import 'Screens/LoginScreens/singUp_screenGoogle.dart';
import 'Screens/Profile/booking_status_screen.dart';
import 'Screens/Profile/help_screen.dart';
import 'Screens/splash_screen.dart';
import 'Firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey=primaryKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentDataController persistentDataController=Get.put(PersistentDataController(),permanent: true);
    final ThemeController themeController=Get.put(ThemeController());
    return Obx(
      ()=> GetMaterialApp(
        debugShowCheckedModeBanner: false,
        
        
        title: 'PetKart',
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode: themeController.themeMode.value,
        getPages: [
          //login-new
          GetPage(name: "/login_signup_screen", page: () => const LoginSignupScreen()),
          GetPage(name: "/splash", page: () => const SplashScreen()),
          GetPage(name: "/forgetpass", page: () => const ForgetpasswordScreen()),
          GetPage(name: "/emailverify", page: () => const EmailVerificationScreen()),
          GetPage(name: "/googlesignup", page: () => const SingupScreengoogle()),

          //IntroScreen
          GetPage(name: "/intro", page: () => const IntroScreen()),
          GetPage(name: "/welcome", page: () => const WelcomeScreen()),

          //home_bottom_nav
          GetPage(name: "/home", page: () => const BottomNavScreen()),
          GetPage(name: "/auth", page: () => const AuthCheck()),

          //profile
          GetPage(name: "/profile", page: ()=>const ProfilePage()),
          GetPage(name: "/profile_update", page: ()=>const ProfileDetailsUpdateScreen()),
          GetPage(name: "/help", page: ()=>const HelpScreen()),
          GetPage(name: "/booking_status", page: ()=>const BookingStatusScreen()),
          GetPage(name: "/history", page: ()=>const HistoryScreen()),
          GetPage(name: "/settings", page: ()=>const SettingsScreen()),

          //home
          GetPage(name: "/home", page: ()=>const HomePage()),
          GetPage(name: "/food_acc_screen", page: ()=> const FoodAccScreen()),
          GetPage(name: "/pet_buy_screen", page: ()=> const PetBuyScreen()),
          GetPage(name: "/pet_display_screen", page: ()=> const PetDisplayScreen()),
          GetPage(name: "/cart_animal_screen", page: ()=> const CartScreen()),
          GetPage(name: "/address_screen", page: ()=> const AddressScreen()),
          GetPage(name: "/final_order_screen", page: ()=> const FinalOrderScreen()),
          GetPage(name: "/pay_confirm_screen", page: ()=>  const PayConfirmScreen()),

          //info
          GetPage(name: "/info", page: ()=>const InfoPage()),
          GetPage(name: "/info_options_screen", page: ()=>const InfoOptionsScreen()),
          GetPage(name: "/dog_detail_screen", page: ()=>const DogDetailsScreen()),
          GetPage(name: "/animal_detail_screen", page: ()=>const AnimalDetailsScreen()),

          //community
          GetPage(name: "/community", page: ()=>const CommunityPage()),
          GetPage(name: "/community_search_screen", page: ()=>const CommunitySearchScreen()),
          GetPage(name: "/community_home_screen", page: ()=>const CommunityHomeScreen()),
          GetPage(name: "/community_search_home_screen", page: ()=>const CommunitySearchHomeScreen()),
          GetPage(name: "/community_create_screen", page: ()=>const CommunityCreateScreen()),

          //adoption
          GetPage(name: "/adopt", page: ()=>const AdoptionPage()),
          GetPage(name: "/adopt_pet_details", page: ()=>const PetAdoptionDetailsScreen()),
          GetPage(name: "/adopt_rehome", page: ()=>const PetRehomeScreen()),
          GetPage(name: "/adopt_rehome_home", page: ()=>const PetRehomeHomeScreen()),
          GetPage(name: "/adopt_chat_home", page: ()=>const PetAdoptionChatHome()),
          GetPage(name: "/adopt_chat_room", page: ()=>const PetAdoptionChatRoomScreen()),
          GetPage(name: "/adopt_form_screen", page: ()=>const AdoptionFormScreen()),
          GetPage(name: "/adopt_thankyou_screen", page: ()=>const AdoptionThankyouScreen()),
          //not routed from any screen
          GetPage(name: "/adopt_confirm_screen", page: ()=>const AdoptionConfirmationScreen()),
          GetPage(name: "/adoption_requests_screen", page: ()=>const AdoptionRequestsScreen()),
          GetPage(name: "/adoption_requests_details_screen", page: ()=>const AdoptionRequestDetailsScreen()),

        ],
        initialRoute: "/splash",
        // initialRoute: "/pay_confirm_screen",
        unknownRoute: GetPage(name: "/login", page: () => const LoginSignupScreen()),
      ),
    );
  }
}
