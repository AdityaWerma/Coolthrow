import 'package:cloud_firestore/cloud_firestore.dart';

class OrderProduct {
  final String userName;
  final String phoneNumber;
  final String shopId;
  final String userId;
  final Map<String, dynamic> details;
  final DateTime timestamp;
  final String isDelivered;

  OrderProduct({
    required this.shopId,
    required this.userId,
    required this.details,
    required this.timestamp,
    required this.userName,
    required this.phoneNumber,
    required this.isDelivered,
  });

  // Convert order data to a map
  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'userId': userId,
      'details': details,
      'timestamp': timestamp,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'isDelivered':isDelivered,
    };
  }
}

class OrderService {
  final CollectionReference ordersCollection =
  FirebaseFirestore.instance.collection('orders');

  // Save an order to Firestore
  Future<void> saveOrder(OrderProduct orderProduct) async {
    try {
      await ordersCollection.add(orderProduct.toMap());
      print('Order saved successfully');
    } catch (e) {
      print('Error saving order: $e');
    }
  }
}

