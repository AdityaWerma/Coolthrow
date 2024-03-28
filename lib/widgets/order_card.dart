import 'package:flutter/material.dart';

import '../models/order_product.dart';

class OrderCard extends StatelessWidget {
  final OrderProduct orderProduct;

  const OrderCard({super.key, required this.orderProduct});

  final TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 19);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      color: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Name: ${orderProduct.details['product']}',
                style: textStyle),
            const SizedBox(height: 8.0),
            Text('Date: ${orderProduct.timestamp.day}/${orderProduct.timestamp.month}/${orderProduct.timestamp.year}', style: textStyle),
            const SizedBox(height: 8.0),
            Text('Quantity: ${orderProduct.details['quantity']}',
                style: textStyle),
            const SizedBox(height: 8.0),
            Text('Paid: ₹${orderProduct.details['totalAmount']}',
                style: textStyle),
            const SizedBox(height: 8.0),
            Text('Delivered: ${orderProduct.isDelivered}', style: textStyle),
          ],
        ),
      ),
    );
  }
}
