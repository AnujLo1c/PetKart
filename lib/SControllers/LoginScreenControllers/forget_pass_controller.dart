import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:pet_kart/MyWidgets/snackbarAL.dart';


class ForgetPassController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPass() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      if(await EmailPassLoginAl().resetPasswordAL(email)){
        showSuccessSnackbar("Reset email send.");
      }
      else{
        showErrorSnackbar("Some Error");
      }
    }
  }

}