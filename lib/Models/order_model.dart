import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? orderId;
  final String ownerId; // Owner of the pet being sold
  final String customerId; // Customer placing the order
  final String petId;
  final String paymentMethod;
  final String totalPrice;
  final String deliveryPrice;
  final String discount;
  final Map<String,String> deliveryAddress;
  final String orderStatus;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String deliveryStatus;
  final String imgUrl;

  OrderModel({
    this.orderId,
    required this.ownerId,
    required this.customerId,
    required this.petId,
    required this.paymentMethod,
    required this.totalPrice,
    required this.deliveryPrice,
    required this.discount,
    required this.deliveryAddress,
    required this.orderStatus,
    required this.orderDate,
    required this.deliveryStatus,
    required this.imgUrl,
    this.deliveryDate,
  });

  // Factory constructor to create an OrderModel from a Map
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      customerId: map['customerId'] ?? '',
      petId: map['petId'] ?? '',
      imgUrl: map['imgUrl'],
      paymentMethod: map['paymentMethod'] ?? '',
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      deliveryPrice: (map['deliveryPrice'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      deliveryAddress: map['deliveryAddress'] ?? '',
      deliveryStatus: map['deliveryStatus'] ?? '',
      orderStatus: map['orderStatus'] ?? 'Pending',
      orderDate: (DateTime.parse(map['orderDate'])),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
    );
  }

  // Convert an OrderModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'ownerId': ownerId,
      'customerId': customerId,
      'petId': petId,
      'imgUrl':imgUrl,
      'paymentMethod': paymentMethod,
      'totalPrice': totalPrice,
      'deliveryPrice': deliveryPrice,
      'discount': discount,
      'deliveryAddress': deliveryAddress,
      'deliveryStatus': deliveryStatus,
      'orderStatus': orderStatus,
      'orderDate': Timestamp.fromDate(orderDate),
      'deliveryDate': Timestamp.fromDate(orderDate),
    };
  }

}
