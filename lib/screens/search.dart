import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coolthrow/models/product.dart';
import 'package:coolthrow/screens/product_details.dart';
import 'package:coolthrow/widgets/product_item.dart';

final productsDBRef = FirebaseDatabase.instance.ref().child('Products');

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _enteredText = '';

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
      appBar: AppBar(
        actions: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Border color
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.fromLTRB(55, 0, 20, 0),
              child: TextField(
                autofocus: true,
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: _controller,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  hintText: 'Type something here...',
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredText = value;
                  });
                },
              ), // Add your custom widget here
            ),
          ),
        ],
      ),
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

            products = _enteredText.isEmpty
                ? []
                : products
                    .where((product) => product.title
                        .toLowerCase()
                        .contains(_enteredText.toLowerCase()))
                    .toList();

            return ListView.builder(
              itemCount: products.length,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
