import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coolthrow/models/product.dart';
import 'package:coolthrow/screens/product_details.dart';
import 'package:coolthrow/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    this.title,
    required this.category,
    required this.isEats,
  });

  final String? title;
  final String category;
  final bool isEats;

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
    var productsDBRef =
        FirebaseDatabase.instance.ref().child(isEats ? 'Eats' : 'Products');

    return Scaffold(
      appBar: AppBar(
        title: Text(title!.toString()),
      ),
      body: StreamBuilder(
        stream: productsDBRef
            .orderByChild('categoryBelong')
            .equalTo(category.toString())
            .onValue,
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
                    shopId: item['shopId'].toString(),
                      id: item['id'].toString(),
                      categoryBelong: item['categoryBelong'].toString(),
                      title: item['title'].toString(),
                      imageUrl: item['imageAddress'].toString(),
                      specification: item['specification'].toString(),
                      price: item['price'].toString()));
                }
              } else if (data != null && data is Map) {
                data.forEach((key, value) {
                  products.add(Product(
                      shopId: value['shopId'].toString(),
                      id: value['id'].toString(),
                      categoryBelong: value['categoryBelong'].toString(),
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
