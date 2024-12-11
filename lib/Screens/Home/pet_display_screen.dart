import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../SControllers/HomeController/pet_display_controller.dart';

class PetDisplayScreen extends StatelessWidget {
  const PetDisplayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    PetDisplayController petDisplayController =
    Get.put(PetDisplayController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Obx(() => Center(
              child: petDisplayController.imageUrls.isEmpty
                  ? const SizedBox(
                height: 270,
              )
                  : ImageSlideshow(
                width: double.infinity,
                height: 270,
                initialPage: 0,
                autoPlayInterval: 10000,
                children: petDisplayController.imageUrls
                    .map((img) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: img,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            )),
            const Gap(16.0),
            Obx(() => Row(
              children: [
                // Text("data"),
                RichText(
                  text: TextSpan(
                    text:
                    "${petDisplayController.data['petName'] ?? ''}\n",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text:
                        petDisplayController.data['city'] ??
                            '',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text((petDisplayController.data['price']??'')+"₹",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)

              ],
            )),
            const Gap(8.0),
            Obx(()=>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    tile("Gender",
                        petDisplayController.data['gender'] ?? 'N/A'),
                    tile("Age",
                        petDisplayController.data['age'] ?? 'N/A'),
                    tile("Breed",
                        petDisplayController.data['breed'] ?? 'N/A'),
                  ],
                ),
            ),
            Divider(
              color: Get.theme.colorScheme.primary,
            ),
            
            const Gap(5.0),
            Obx(()=>
               petDisplayController.deliveryBool.value?ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width - 20, 50)),
                onPressed: () {
                  print( petDisplayController.data['owner']?.toString());
                  Get.toNamed(
                    "/address_screen",
                    arguments: <String>[
                      petDisplayController.docid,
                      petDisplayController.args[1],
                      petDisplayController.data['price']?.toString() ?? '0',
                      petDisplayController.data['deliveryPrice']?.toString() ?? '0',
                      petDisplayController.data['discount']?.toString() ?? '0',
                      petDisplayController.data['owner']?.toString() ?? 'NA',
                      petDisplayController.imageUrls[0]
                    ],
                  );

                  // cartController.totalPrice,cartController.totalDeliveryPrice,cartController.dicount
                },
                child: Text("Buy Now"),
              ):Gap(0),
            ),
            const Gap(5.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width - 20, 50)),
              onPressed: () {
print(petDisplayController.deliveryBool.value);
                if(petDisplayController.deliveryBool.value){
petDisplayController.addTocart();
                }
                else{
                  Get.dialog(CopyTextDialog(content: petDisplayController.address[0]+", "+petDisplayController.address[1]+", "+petDisplayController.address[2]));
                }
              },
              child:  Obx(()=> Text(petDisplayController.deliveryBool.value?"Add to Cart":"Pick Up")),
            ),
            
            const Gap(10),
            const Text(
              "Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                const Gap(10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nature"),
                    Text("Neutered"),
                    Text("Health Condition"),
                    Text("Vaccinated"),
                    Text("Pet-compatible"),
                    Text("Kids-compatible"),
                    Text("Delivery"),
                  ],
                ),
                const Gap(20),
                Obx(()=>
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(petDisplayController.data['nature']??"NA"),
                        Text((petDisplayController.data['neutered'] ?? false) ? 'Yes' : 'No'),
                        Text(petDisplayController.data['healthCondition']??"good"),
                        Text(petDisplayController.data['vaccinated']??false?'Yes':'No'),
                        Text(petDisplayController.data['petsCompatible']??true?'Yes':'No'),
                        Text(petDisplayController.data['kidsCompatible']??true?'Yes':'No'),
                        Text((petDisplayController.data['delivery']??false)?(petDisplayController.data['deliveryPrice'].toString()+'₹'):'No'),
                      ],
                    ),
                )
              ],
            ),

            // Divider(color: Get.theme.colorScheme.primary,),
            const Gap(15.0),
            Obx(
                  ()=> Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    child: petDisplayController.ownerUrl.value != 'null'
                        ? ClipOval(
                      child: Image.network(
                        petDisplayController.ownerUrl.value,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                        : Icon(Icons.person),
                  ),

                  const Gap(5),
                  Text(
                    petDisplayController.owner.value,
                    style: TextStyle(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Container(
              width: Get.width-20,

              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Obx(()=>
                  Text(
                      petDisplayController.data['description']??"No Description"
                  ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget tile(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFE0D1D1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title + '\n',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

}
class CopyTextDialog extends StatelessWidget {
  final String content;

  const CopyTextDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Address'),
      content: SingleChildScrollView(
        child: Text(content),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: content));
             Get.snackbar('','Content copied to clipboard');
          },
          icon: const Icon(Icons.copy,size: 16,),
          label: const Text('Copy',style: TextStyle(fontSize: 14),),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}