import 'package:coolthrow/screens/upi_payment.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
    // required this.onToggleFavorite,
  });

  final Product product;

  // final void Function(Product product) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              children: [
                Image.network(
                  product.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 14),
                Text(
                  'M.R.P ₹${product.price}',
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
                  'Specification',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(product.specification),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => UPIPaymentScreen(
                        title: product.title,
                        price: product.price,
                      ),
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
