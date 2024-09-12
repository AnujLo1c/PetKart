import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/google_sign_in.dart';
class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              ElevatedButton(
                onPressed: (){
              GoogleSignInAL().signOutGoogle();
              Get.until((route) => route.settings.name == '/login');

                }, child: const Text("logout"),
              ),
              ElevatedButton(
                onPressed: (){
                  Get.toNamed("intro");
                }, child: const Text("move to intro"),
              ),
              ElevatedButton(
                onPressed: (){
                  Get.toNamed("home");
                }, child: const Text("Home"),
              ),
            ],
          ),
        ));
  }
}
