import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart'as material;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Screens/Adoption/adoption_thankyou_screen.dart';
import 'package:pet_kart/secret.dart';
import '../../SControllers/HomeController/pay_confirm_controller.dart';

class PayConfirmScreen extends StatelessWidget {
 const PayConfirmScreen({super.key});



 Future<Map<String, dynamic>?> makeIntentForPayment(String amountToBeCharged, String currency) async {
   try {
     Map<String, dynamic> paymentInfo = {
       "amount": (int.parse(amountToBeCharged)*100).toString(),
       "currency": currency,
       "payment_method_types[]": "card",
     };

     var responseFromStripeAPI = await http.post(
       Uri.parse("https://api.stripe.com/v1/payment_intents"),
       body: paymentInfo,
       headers: {
         "Authorization": "Bearer $secretKey",
         "Content-Type": "application/x-www-form-urlencoded",
       },
     );

     if (responseFromStripeAPI.statusCode == 200) {
       print('///////////////////////////////////////////////////////////////////////////////////////////');
       print(json.decode(responseFromStripeAPI.body));
       return json.decode(responseFromStripeAPI.body);
     } else {
       print("Error creating payment intent: ${responseFromStripeAPI.body}");
       return null;
     }
   } catch (errorMsg, s) {
     if (kDebugMode) {
       print(s);
     }
     print(errorMsg.toString());
     return null;
   }
 }

 Future<void> paymentSheetInitialization(String amountToBeCharged, String currency,controller) async {
   try {
      controller.intentPaymentData.value = await makeIntentForPayment(amountToBeCharged, currency);

     if (controller.intentPaymentData!.isEmpty) {
       if (kDebugMode) {
         print("Error: Payment Intent creation failed.");
       }
       return;
     }
// print(intentPaymentData);
     await Stripe.instance.initPaymentSheet(
       paymentSheetParameters: SetupPaymentSheetParameters(
         allowsDelayedPaymentMethods: true,
         paymentIntentClientSecret: controller.intentPaymentData["client_secret"],
         style: ThemeMode.light, // Or ThemeMode.light based on your app's theme
         merchantDisplayName: "Company Name Example", // Replace with your company name
       ),
     ).then((val) {
       print("Payment sheet initialized: $val");
     });

     // Display the payment sheet
     await showPaymentSheet(controller);
   } catch (errorMsg, s) {
     if (kDebugMode) {
       print(s); // Print stack trace in debug mode
     }
     print("Error in payment sheet initialization: ${errorMsg.toString()}");
   }
 }
  @override
  Widget build(BuildContext context) {
    final PayConfirmController controller = Get.put(PayConfirmController());
Color primary=Get.theme.colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Pay Confirm',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // UPI Section
            const Text(
              'Online',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              context,primary: primary,
              icon: Icons.account_balance_wallet_outlined,
              label: 'Stripe',
              method: 'stripe',
              controller: controller, // Pass controller
            ),

            const SizedBox(height: 20),

            // Other Section
            const Text(
              'Other',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              context,primary: primary,
              icon: Icons.money,
              label: 'Cash on Delivery',
              method: 'cod',
              controller: controller, // Pass controller
            ),

            const Spacer(),

            // Place Order Button
            Obx(
                  () => ElevatedButton(
                onPressed: controller.selectedPaymentMethod.isEmpty
                    ? null // Disable button if no payment method is selected
                    : () async {

                  paymentSheetInitialization(controller.amount.round().toString(),"INR",controller);
                  print(
                      'Selected Payment Method: ${controller.selectedPaymentMethod.value}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Place your Order',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


  Widget _buildPaymentOption(
      BuildContext context, {
        required  Color primary,
        required IconData icon,
        required String label,
        required String method,
        Widget? extraWidget,
        required PayConfirmController controller, // Pass controller as parameter
      }) {
    return material.Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: primary, size: 30),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: extraWidget ??
            Obx(() => controller.selectedPaymentMethod.value == method
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.radio_button_unchecked, color: Colors.grey)),
        onTap: () {
          controller.selectPaymentMethod(method);
        },
      ),
    );
  }

 showPaymentSheet(controller) async {
   try {
       controller.intentPaymentData.value = <String,dynamic>{};
     await Stripe.instance.presentPaymentSheet().then((val) {
       // print(val);
controller.uploadOrder(false);
     }).onError((errorMsg, sTrace) {
       if (kDebugMode) {
         print(errorMsg.toString() + sTrace.toString());
       }
     print("Payment aborted");
     });
   } on StripeException catch (error) {
     // Handle Stripe-specific exceptions
     if (kDebugMode) {
       print("StripeException: $error");
     }
   } catch (error, stackTrace) {
     // Handle any other exceptions
     if (kDebugMode) {
       print("Generic Exception: ${error.toString()}");
       print("StackTrace: ${stackTrace.toString()}");
     }
     print("object");
   }
Get.snackbar("Payment Successful", "User payment completed.",backgroundColor: Colors.black);

 }


}

