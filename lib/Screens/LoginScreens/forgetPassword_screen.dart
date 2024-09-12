import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_kart/SControllers/LoginScreenControllers/forget_pass_controller.dart';

class ForgetpasswordScreen extends StatelessWidget {
   const ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPassController forgetPassController=Get.put(ForgetPassController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: forgetPassController.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: forgetPassController.emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                    return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  forgetPassController.resetPass();
                },
                child: Text('Send Reset Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}