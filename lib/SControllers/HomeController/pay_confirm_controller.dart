

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:pet_kart/Models/order_model.dart';
import 'package:pet_kart/Screens/Adoption/adoption_thankyou_screen.dart';


class PayConfirmController extends GetxController {
  // Reactive variable to store the selected payment method index
  var selectedPaymentMethod = ''.obs;

  String transactionRef='';

  //stripe
  final double amount = 2000;
  RxMap<String, dynamic> intentPaymentData=<String,dynamic>{}.obs;

var prelist=Get.arguments[0];
  //stripe
  // Method to update the selected payment method
  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
    print(Get.arguments);
  }
  Future<void> uploadOrder(bool cod) async {
    String email = EmailPassLoginAl().getEmail();

    OrderModel order = OrderModel(
      orderId: intentPaymentData['id'],
      ownerId: prelist[5],
      imgUrl: prelist[6],
      customerId: email,
      petId: prelist[0],
      paymentMethod: selectedPaymentMethod.value,
      totalPrice: amount.toString(),
      deliveryPrice: prelist[3],
      discount: prelist[4],
      deliveryAddress: Get.arguments[1],
      orderStatus: cod ? "unpaid" : "paid",
      orderDate: DateTime.now(),  // Use server timestamp here
      deliveryStatus: 'Init',
    );

    try {
      // print('asaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add the order to the "petorders" collection
      DocumentReference orderRef = await firestore.collection("petorders").add(order.toMap());

      // print('asaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab');
      // Get the document ID of the added order
      String orderId = orderRef.id;
print(order.ownerId);
      // Update the owner document's "petorders" field
      await firestore.collection("vendorusers").doc(order.ownerId).update({
        "petorders": FieldValue.arrayUnion([orderId])
      });
      // print('asaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaac');

      // Update the customer document's "petorders" field
      await firestore.collection("users").doc(order.customerId).update({
        "petorders": FieldValue.arrayUnion([orderId])
      });
      // print('asaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaad');

      // Update the pet document's "ordered" field
      await firestore.collection("pets").doc(prelist[1]).collection(prelist[1])
          .doc(prelist[0]).update({"ordered": true});

      // print('asaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaae');
      // Log successful upload
      print("Order uploaded successfully with ID: $orderId");

      // Update vendor income data
      await updateVendorIncomeData(vendorId: prelist[5], orderTotal: double.parse(amount.toString()), deliveryFee: double.parse(prelist[3].toString()));
      // print('asaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaf');

    } catch (e) {
      print("Error uploading order: $e");
    }
  }


  Future<void> updateVendorIncomeData({
    required String vendorId,
    required double orderTotal,
    required double deliveryFee,
  }) async {
    // Calculate fees and earnings
    double platformFee = orderTotal * 0.10; // 10% of order total
    double commission = orderTotal * 0.05; // 5% of order total
    double grossSales = orderTotal; // Total price paid by the customer
    double earnings = grossSales - (platformFee + commission + deliveryFee);

    // Get the current date
    DateTime now = DateTime.now();

    // Generate formatted date strings for comparisons
    String currentDay = DateFormat('yyyy-MM-dd').format(now);
    String currentMonth = DateFormat('yyyy-MM').format(now);
    String currentYear = DateFormat('yyyy').format(now);

    DocumentReference vendorDoc =
    FirebaseFirestore.instance.collection('vendorusers').doc(vendorId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot vendorSnapshot = await transaction.get(vendorDoc);

      if (vendorSnapshot.exists) {
        Map<String, dynamic> vendorData =
        vendorSnapshot.data() as Map<String, dynamic>;
        List<dynamic> incomeData = vendorData['incomeData'] ?? [];
        Timestamp timestamp=vendorData['currentday'];
        DateTime orderDate= timestamp.toDate() ;
        String orderDay = DateFormat('yyyy-MM-dd').format(orderDate);
        String orderMonth = DateFormat('yyyy-MM').format(orderDate);
        String orderYear = DateFormat('yyyy').format(orderDate);

        // Flags to track updates
        bool isLifetimeUpdated = false;
        bool isDayUpdated = false;
        bool isMonthUpdated = false;
        bool isYearUpdated = false;

        for (var periodData in incomeData) {
          if (periodData['name'] == 'All') {
            // Update lifetime stats
            periodData['currentEarnings'] += earnings;
            periodData['currentGrossSales'] += grossSales;
            periodData['currentTotalSales'] += grossSales;
            periodData['currentProductSales'] += 1;
            isLifetimeUpdated = true;
          }
          if (periodData['name'] == 'Day') {
            if (orderDay == currentDay) {
              // Update daily stats
              periodData['currentEarnings'] += earnings;
              periodData['currentGrossSales'] += grossSales;
              periodData['currentTotalSales'] += grossSales;
              periodData['currentProductSales'] += 1;
            } else {
              // Reset day stats
              await resetVendorIncomeData(vendorId: vendorId, period: 'Day' , incomeData: incomeData ,earnings: earnings,gross: grossSales);
            }
              isDayUpdated = true;
          }
          if (periodData['name'] == 'Month') {
            if (orderMonth == currentMonth) {
              // Update monthly stats
              periodData['currentEarnings'] += earnings;
              periodData['currentGrossSales'] += grossSales;
              periodData['currentTotalSales'] += grossSales;
              periodData['currentProductSales'] += 1;
            } else {
              // Reset month stats
              await resetVendorIncomeData(vendorId: vendorId,period: 'Month', incomeData: incomeData ,earnings: earnings,gross: grossSales);
            }
              isMonthUpdated = true;
          }
          if (periodData['name'] == 'Year') {
            if (orderYear == currentYear) {
              // Update yearly stats
              periodData['currentEarnings'] += earnings;
              periodData['currentGrossSales'] += grossSales;
              periodData['currentTotalSales'] += grossSales;
              periodData['currentProductSales'] += 1;
            } else {
              await resetVendorIncomeData(vendorId: vendorId,period: 'Year', incomeData: incomeData ,earnings: earnings,gross: grossSales);
            }
              isYearUpdated = true;
          }
        }
print("till missing");
        // Add missing periods
        if (!isLifetimeUpdated) {
          incomeData.add({
            'name': 'All',
            'currentEarnings': earnings,
            'currentGrossSales': grossSales,
            'currentTotalSales': grossSales,
            'currentProductSales': 1,
            'previousEarnings': 0,
            'previousGrossSales': 0,
            'previousProductSales': 0,
            'previousTotalSales': 0,
          });
        }
        if (!isDayUpdated) {
          incomeData.add({
            'name': 'Day',
            'currentEarnings': earnings,
            'currentGrossSales': grossSales,
            'currentTotalSales': grossSales,
            'currentProductSales': 1,
            'previousEarnings': 0,
            'previousGrossSales': 0,
            'previousProductSales': 0,
            'previousTotalSales': 0,
          });
        }
        if (!isMonthUpdated) {
          incomeData.add({
            'name': 'Month',
            'currentEarnings': earnings,
            'currentGrossSales': grossSales,
            'currentTotalSales': grossSales,
            'currentProductSales': 1,
            'previousEarnings': 0,
            'previousGrossSales': 0,
            'previousProductSales': 0,
            'previousTotalSales': 0,
          });
        }
        if (!isYearUpdated) {
          incomeData.add({
            'name': 'Year',
            'currentEarnings': earnings,
            'currentGrossSales': grossSales,
            'currentTotalSales': grossSales,
            'currentProductSales': 1,
            'previousEarnings': 0,
            'previousGrossSales': 0,
            'previousProductSales': 0,
            'previousTotalSales': 0,
          });
        }

        // Update the incomeData in Firestore
        transaction.update(vendorDoc, {'incomeData': incomeData});
        print("data uploaded incomedata");
      }
    });
  }


  Future<List<dynamic>> resetVendorIncomeData({
    required String vendorId,
    required String period, // e.g., 'Day', 'Month', 'Year'
    required List<dynamic> incomeData, // Pass incomeData directly
    required double earnings,
    required double gross
  }) async {

    for (var periodData in incomeData) {
      if (periodData['name'] == period) {
        // Move current data to previous fields
        periodData['previousEarnings'] = periodData['currentEarnings'];
        periodData['previousGrossSales'] = periodData['currentGrossSales'];
        periodData['previousTotalSales'] = periodData['currentTotalSales'];
        periodData['previousProductSales'] = periodData['currentProductSales'];

        // Reset current fields
        periodData['currentEarnings'] = earnings;
        periodData['currentGrossSales'] = gross;
        periodData['currentTotalSales'] =periodData['previousTotalSales']+1 ;
        periodData['currentProductSales'] = 1;
      }
    }

    return incomeData;
  }


}