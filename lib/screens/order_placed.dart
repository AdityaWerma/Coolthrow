import 'package:coolthrow/screens/account.dart';
import 'package:coolthrow/screens/home.dart';
import 'package:coolthrow/screens/orders.dart';
import 'package:coolthrow/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() {
    return _OrderPlacedScreenState();
  }
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate a long-running task, such as loading data or initializing the app
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the next screen after the splash screen
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/order_placed_animation.json',
                width: 200, height: 200),
            const SizedBox(height: 20),
            const Text('Your order has been placed successfully!',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
