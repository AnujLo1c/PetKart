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
        title: Text(infoOptionsController.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),

        itemBuilder: (context, index) => InfoTile(infoOptionsController.list[index],infoOptionsController.title),itemCount: infoOptionsController.list.length,),
    );
  }

  InfoTile(String text,String title) {
    return GestureDetector(
      onTap: (){
        //TODO: nav to info
        if(title=='Dog') {
          Get.toNamed("/dog_detail_screen",arguments: text.toLowerCase().replaceAll(' ', '_'));
        }
        else if(title=='Cat'){
          // print("object");
          Get.toNamed("/animal_detail_screen",arguments: [text.toLowerCase().replaceAll(' ', '_'),'cat_info']);
        }
        else if(title=='Fish'){
          // print("object");
          Get.toNamed("/animal_detail_screen",arguments: [text.toLowerCase().replaceAll(' ', '_'),'fish_info']);
        }
        else if(title=='Small Mammals'){
          // print("object");
          Get.toNamed("/animal_detail_screen",arguments: [text.toLowerCase().replaceAll(' ', '_'),'rabbits_info']);
        }
        else if(title=='Birds'){
          // print("object");
          Get.toNamed("/animal_detail_screen",arguments: [text.toLowerCase().replaceAll(' ', '_'),'birds_info']);
        }
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
