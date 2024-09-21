import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: (){}, child: const Text("My feed",style: TextStyle(fontSize: 20))),
            TextButton(onPressed: (){}, child: const Text("My communities",style: TextStyle(fontSize: 20))),

          ],
        ),
        const Gap(20),
        Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 15,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
            color: Get.theme.colorScheme.primary,
              width: 1
            )
          ),
          child: const Column(
            children: [
              Row(
                children: [

                ],
              ),
              Row(
                children: [
                  Icon(Icons.ac_unit),
                  Text("Add your post in")
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
