import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BookingStatusScreen extends StatelessWidget {
  const BookingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booding Status"),
        centerTitle: true,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios_sharp),
      ),
    ),
      body: Container(),

    );
  }
}
