import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Models/community_model.dart';

class CommunityHomeController extends GetxController {

  CommunityModel community=Get.arguments;
  String formatDateTime(DateTime dateTime) {
    String time = DateFormat('HH:mm').format(dateTime); // Format time as HH:mm
    String date = DateFormat('dd MMM').format(dateTime); // Format date as dd MMM
    return '$time $date';
  }

}
