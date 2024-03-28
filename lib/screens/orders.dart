import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/order_product.dart';
import '../widgets/order_card.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() {
    return _OrdersScreenState();
  }
}

class _OrdersScreenState extends State<OrdersScreen> {
  User? _user;
  dynamic fsc;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser!;
    setState(() {
      _user = user;
    });

    fsc = firestore
        .collection('orders')
        .where('userId', isEqualTo: _user!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder<QuerySnapshot>(
        stream: fsc,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<OrderProduct> orderProducts = [];
            for (var doc in snapshot.data!.docs) {
              var data = doc.data() as Map<String, dynamic>;

              var details = data['details'];

              orderProducts.add(OrderProduct(
                  phoneNumber: data['phoneNumber'],
                  shopId: data['shopId'],
                  details: details,
                  timestamp: data['timestamp'].toDate(),
                  userName: data['userName'],
                  isDelivered: data['isDelivered'],
                  userId: data['userId']));
            }

            return ListView.builder(
              itemCount: orderProducts.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  orderProduct: orderProducts[index],
                );
              },
            );
          } else {
            return const Center(
              child: Text('No Orders Delivered Yet!'),
            );
          }
        },
      ),
    );
  }
}
