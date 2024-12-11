import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading screen
        } else if (snapshot.hasData) {
          // User is logged in
          Future.microtask(() => Get.offAllNamed("/home"));
          return const SizedBox(); // Placeholder to avoid build errors
        } else {
          // User is not logged in
          Future.microtask(() => Get.offAllNamed("/login_signup_screen"));
          return const SizedBox(); // Placeholder to avoid build errors
        }
      },
    );
  }
}
