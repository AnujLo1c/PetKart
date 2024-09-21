import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
    leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios_sharp),
      ),),
      body: Container(),
    );
  }
}
