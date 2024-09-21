import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text("Help"),
      centerTitle: true,),

    body: Center(
      child: Column(
        children: [
          const Gap(30),
          Container(
            height: 150,width: 150,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Get.theme.colorScheme.shadow,
                    blurRadius: 2,
                    spreadRadius: 1
                  )
                ],
                borderRadius: BorderRadius.circular(75),
                color: Get.theme.colorScheme.primary,
                border: Border.all(color: Colors.white,width: 2),
              ),
              child: const Icon(Icons.question_mark_outlined,size: 80,color: Colors.white,),
          ),
          // Text("Help")
          const Gap(20),
          TextField(
maxLength: 150,
maxLines: 4,
            decoration: InputDecoration(
              filled: false,
              constraints: BoxConstraints(
                maxWidth: Get.width-40,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Get.theme.colorScheme.outline,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(10)
              ),
enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: Get.theme.colorScheme.outline,
        width: 2
    ),
    borderRadius: BorderRadius.circular(10)
),

            ),

          ),
          const Gap(10),
          ElevatedButton(onPressed: (){},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(Get.width-150, 50)
            ),
              child: const Text("Send Note"),
          )
        ],
      ),
    ),
    );
  }
}
