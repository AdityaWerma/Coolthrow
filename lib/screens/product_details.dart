import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolthrow/screens/order_placed.dart';
import 'package:coolthrow/screens/razorpay_payment.dart';
import 'package:coolthrow/screens/upi_payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/order_product.dart';
import '../models/product.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
    // required this.onToggleFavorite,
  });

  final Product product;

  // final void Function(Product product) onToggleFavorite;

  @override
  State<ProductDetailsScreen> createState() {
    return _ProductDetailsScreenState();
  }
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int? selectedQuantity = 1;

  User? user = FirebaseAuth.instance.currentUser;

  String? userName;

  Future<void> _fetchUserData() async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(user!.uid).get();
    if (snapshot.exists) {
      setState(() {
        userName = snapshot['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserData();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              children: [
                Image.network(
                  widget.product.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Text(
                  widget.product.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 14),
                Text(
                  'M.R.P ₹${widget.product.price}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                    'Only UPI payment is accepted.\nNo return of item is available.'),
                const SizedBox(height: 14),
                const Text(
                  'Product details',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product.specification,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Additional information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Select Quantity :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    DropdownButton<int>(
                      value: selectedQuantity, // Initial value
                      onChanged: (int? newValue) {
                        // Handle quantity selection
                        setState(() {
                          selectedQuantity =
                              newValue; // Update the selected item
                        });
                      },
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text((index + 1).toString()),
                        );
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(130, 0)),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0),
                  ),
                ),
                onPressed: () {
                  // onToggleFavorite(product);
                },
                child: const Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(130, 0)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                ),
                onPressed: () async {
                  OrderService orderService = OrderService();
                  OrderProduct orderProduct = OrderProduct(
                    isDelivered: 'No',
                    shopId: widget.product.shopId.toString(),
                    userId: user!.uid.toString(),
                    userName: userName.toString(),
                    phoneNumber: user!.phoneNumber.toString(),
                    details: {
                      'product': widget.product.title.toString(),
                      'quantity': selectedQuantity.toString(),
                      'totalAmount':
                          selectedQuantity! * int.parse(widget.product.price),
                    },
                    timestamp: DateTime.now(),
                  );

                  await orderService.saveOrder(orderProduct);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (ctx) => UPIPaymentScreen(
                  //       price: widget.product.price,
                  //       title: widget.product.title,
                  //     ),
                  //   ),
                  // );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => OrderPlacedScreen()
                    ),
                  );

                },
                child: const Text(
                  'Buy now',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
