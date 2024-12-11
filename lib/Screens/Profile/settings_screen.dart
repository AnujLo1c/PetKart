import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/ProfileController/settings_screen_controller.dart';
import 'package:rive/rive.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsScreenController settingsScreenController = Get.put(SettingsScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            settingsScreenController.check=true;
          settingsScreenController.handleBackNavigation();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: PopScope(
        canPop: false,

        onPopInvokedWithResult: (didPop, result) {
          settingsScreenController.check=false;
          settingsScreenController.handleBackNavigation();
        },
        child: Column(
          children: [
            const Gap(20),
            buildButton("Update User Details",()=>Get.toNamed("/profile_update")),
            const Gap(6),
            const Divider(indent: 20,endIndent: 20,),
            const Gap(20),
            Row(
              children: [
                const Gap(20),
                const Text(
                  "Notification",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Obx(()=>
                    Transform.scale(
                      scale: 1.2, // Increase the scale (default is 1.0)
                      child: Switch(
                        value: settingsScreenController.notification.value,
                        onChanged: (value) {
                          bool temp = settingsScreenController.notification.value;
                          settingsScreenController.notification.value = !temp;
                        },
                      ),
                    )



                ),
                const Gap(6),
              ],
            ),
            Row(
              children: [
                const Gap(20),
                const Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Obx(() {
                  final artboard = settingsScreenController.riveArtboard2.value;
                  if (artboard == null) {
                    return const CircularProgressIndicator(); // Show loading state
                  } else {
                    return GestureDetector(
                      onTap: () {
                        settingsScreenController.toggle2();
                      },
                      child: SizedBox(
                        width: 62,
                        height: 65,
                        child: Rive(
                          artboard: artboard,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  }
                }),
                const Gap(5),
              ],
            ),
            // const Gap(6),

            // const Gap(10),
            // buildButton("Update Profile",()=>showImageUploadDialog(settingsScreenController)),
          ],
        ),
      ),
    );
  }
// showTextDialog(SettingsScreenController settingsScreenController){
//     Color primary=Get.theme.colorScheme.primary;
//     return Get.dialog(
//       AlertDialog(
//         title: const Text("Enter New Name :-",style: TextStyle(fontSize: 16),),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               onChanged: (value) {
//                 settingsScreenController.nameFieldValue.value = value;
//               },
//               decoration:  InputDecoration(
//
// filled: false,
// enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//         color: primary
//     ),),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: primary
//                   ),
//
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 settingsScreenController.submit();
//               },
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(Get.width-20, 50)
//               ),
//               child: const Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
// }

  // Future<void> showImageUploadDialog(SettingsScreenController settingsScreenController) async {
  //   Color primary = Get.theme.colorScheme.primary;
  //
  //   return Get.dialog(
  //     AlertDialog(
  //       title: const Text(
  //         "Upload Profile Picture",
  //         style: TextStyle(fontSize: 16),
  //       ),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ElevatedButton(
  //             onPressed: () async {
  //               final String? result = await settingsScreenController.selectCropAndUploadImage();
  //               if (result != null) {
  //                 Get.back(); // Close the dialog
  //                 Get.snackbar(
  //                   "Success",
  //                   "Image uploaded successfully!",
  //                   snackPosition: SnackPosition.BOTTOM,
  //                   backgroundColor: Colors.green,
  //                   colorText: Colors.white,
  //                 );
  //               } else {
  //                 Get.snackbar(
  //                   "Error",
  //                   "Image upload failed or cancelled",
  //                   snackPosition: SnackPosition.BOTTOM,
  //                   backgroundColor: Colors.red,
  //                   colorText: Colors.white,
  //                 );
  //               }
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: primary,
  //               minimumSize: Size(Get.width - 40, 50),
  //             ),
  //             child: const Text("Select & Upload Image"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  buildButton(String s, VoidCallback v) {
    return ElevatedButton(onPressed: ()=>v(),
    style: ElevatedButton.styleFrom(
      alignment: AlignmentDirectional.topStart,
      minimumSize: Size(Get.width-20, 50)
    ), child: Text(s),);
  }
}
