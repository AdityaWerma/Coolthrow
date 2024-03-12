import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coolthrow/models/product.dart';
import 'package:coolthrow/screens/product_details.dart';
import 'package:coolthrow/widgets/product_item.dart';

final productsDBRef = FirebaseDatabase.instance.ref().child('Eats');

class EatsScreen extends StatelessWidget {
  const EatsScreen({
    super.key,
  });

  void selectProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductDetailsScreen(
          product: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: productsDBRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            dynamic data = snapshot.data!.snapshot.value as dynamic;

            List<Product> products = [];

            try {
              if (data is List) {
                // Check if data is a list
                // Handle list data
                for (var item in data) {
                  products.add(Product(
                      id: item['id'].toString(),
                      title: item['title'].toString(),
                      imageUrl: item['imageAddress'].toString(),
                      specification: item['specification'].toString(),
                      price: item['price'].toString(),
                      categoryBelong: ''));
                }
              } else if (data != null && data is Map) {
                data.forEach((key, value) {
                  products.add(Product(
                      id: value['id'].toString(),
                      categoryBelong: '',
                      title: value['title'].toString(),
                      imageUrl: value['imageAddress'].toString(),
                      specification: value['specification'].toString(),
                      price: value['price'].toString()));
                });
              }
            } catch (e) {
              print(e);
            }

            return ListView.builder(
              itemCount: snapshot.data!.snapshot.children.length,
              itemBuilder: (ctx, index) => ProductItem(
                product: products[index],
                onSelectProduct: (product) {
                  selectProduct(context, product);
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
