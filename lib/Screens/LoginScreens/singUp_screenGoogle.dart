import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_kart/Firebase/FirebaseFirestore/firestore_firebase.dart';
import 'package:pet_kart/Models/customer.dart';
import 'package:pet_kart/SControllers/LoginScreenControllers/sign_up_controller_google.dart';
import '../../Firebase/FirebaseStorage/cloud_storage.dart';
class SingupScreengoogle extends StatelessWidget {
  const SingupScreengoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpControllerGoogle controller = Get.put(SignUpControllerGoogle());

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
// FirestoreFirebaseAL().deleteGoogleUser();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey1,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () => _showImageSourceActionSheet(context, controller),
                  child: Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                    controller.image.value != null ? FileImage(controller.image.value!) : null,
                    child: controller.image.value == null ? Icon(Icons.add_a_photo, size: 50) : null,
                  )),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: controller.nicknameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your nickname';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    String? email=controller.email;
                    if(email==null){
                      print("email null");
                      Get.close(2);
                    }
                    else{
                    String profileUrl=await CloudStorage().uploadImageAL(controller.image.value,email);
                      if(profileUrl=='' || profileUrl.isNotEmpty){
                        print("profile url empyt");
                        Get.close(1);
                      }
                      else{
                    // ChatUser cu=ChatUser(nickName: controller.nicknameController.text, email: FirebaseAuth.instance.currentUser!.email??'', chatrooms: [], downloadProfileUrl: profileUrl);
                    Customer cu=Customer(customerName: controller.nicknameController.text, email: controller.email, profileUrl: profileUrl);
                        if(FirestoreFirebaseAL().uploadUserDataAL(cu)){
                      print("success data upload");
                      Get.offNamed("/login");
                    }
                    else{
                      print("failed data upload");
                      Get.close(2);
                    }

                      }
                    }


                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context, SignUpControllerGoogle controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}