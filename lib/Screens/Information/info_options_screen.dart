import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/InfoController/info_options_controller.dart';


class InfoOptionsScreen extends StatelessWidget {
  const InfoOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    InfoOptionsController infoOptionsController=Get.put(InfoOptionsController());
    return Scaffold(
      appBar:  AppBar(
        title: Text(Get.arguments),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),

        itemBuilder: (context, index) => InfoTile(infoOptionsController.list[index]),itemCount: infoOptionsController.list.length,),
    );
  }

  InfoTile(String text) {
    return GestureDetector(
      onTap: (){
        //TODO: nav to info
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        height: 50,
        width: Get.width-10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:Get.theme.colorScheme.primary)
        ),
        child: Row(
          children: [
            Text(text,style: const TextStyle(fontSize: 16),),
            const Spacer(),
          Icon(Icons.chevron_right,color: Get.theme.colorScheme.primary,size: 30,)
          ],
        ),
      ),
    );
  }
}
