
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/MyWidgets/snackbarAL.dart';
import 'package:pet_kart/SControllers/LoginScreenControllers/login_controller.dart';

import '../../Firebase/FirebaseAuth/google_sign_in.dart';


class LoginScreen extends StatelessWidget {
   const LoginScreen({super.key});
   @override
   Widget build(BuildContext context) {
     LoginController loginController=Get.put(LoginController());
     return Scaffold(
       appBar: AppBar(
         title: const Text('Login'),
       ),
       body: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Form(
           key: loginController.formKeylogin,
           child: Column(
             children: <Widget>[
               TextFormField(
                 focusNode: loginController.emailFocus,
                 controller: loginController.emailController,
                 decoration: const InputDecoration(labelText: 'Email'),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter your email';
                   }
                   return null;
                 },
               ),
               TextFormField(
                 focusNode: loginController.passFocus,
                 controller: loginController.passwordController,
                 decoration: const InputDecoration(labelText: 'Password'),
                 obscureText: true,
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter your password';
                   }
                   return null;
                 },
               ),
               const SizedBox(height: 20),
               ElevatedButton(
                 onPressed: () async {
loginController.loginUser();
                 },
                 child: const Text('Login'),
               ),

               ElevatedButton(onPressed: (){
                loginController.clearText();
                 Get.toNamed("/signup");
               }, child: const Text("Signup")),
               ElevatedButton(onPressed: (){
              loginController.clearText();
                 Get.toNamed("/forgetpass");
               }, child: const Text("Forget-pass")),
               ElevatedButton(onPressed: () async {
                 loginController.clearText();
                 UserCredential? uc=await GoogleSignInAL().signInGoogle();
                 if(uc==null){
                   print('//////////////////////////////');
                   print('//////////////////////////////');
                   showErrorSnackbar("Some Error");
                 }
                 else if(uc.additionalUserInfo!.isNewUser){
                   Get.toNamed("/googlesignup");
                 }else{
                   Get.toNamed("/entrySet");
                 }
               }, child: const Text("Google"))
             ],
           ),
         ),
       ),
     );
   }
}