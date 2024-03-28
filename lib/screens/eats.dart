import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coolthrow/widgets/category_grid_item.dart';
import 'package:coolthrow/models/category.dart';
import 'products.dart';

final databaseRef = FirebaseDatabase.instance.ref().child('EatsRestaurant');

class EatsScreen extends StatefulWidget {
  const EatsScreen({super.key});

  @override
  State<EatsScreen> createState() {
    return _EatsScreenState();
  }
}

class _EatsScreenState extends State<EatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.fastfood),
          centerTitle: true,
          title: const Text(
            'Coolthrow Eats',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder(
          stream: databaseRef.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              dynamic data = snapshot.data!.snapshot.value as dynamic;

              List<dynamic> title = [];
              List<dynamic> imageAddress = [];
              List<dynamic> id = [];

              try {
                if (data is List) {
                  // Check if data is a list
                  // Handle list data
                  for (var item in data) {
                    title.add(item['title']);
                    imageAddress.add(item['imageAddress']);
                    id.add(item['id']);
                  }
                } else if (data != null && data is Map) {
                  data.forEach((key, value) {
                    title.add(value['title']);
                    imageAddress.add(value['imageAddress']);
                    id.add(value['id']);
                  });
                }
              } catch (e) {
                print(e);
              }

              return GridView.builder(
                itemCount: snapshot.data!.snapshot.children.length,
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GridTile(
                    child: CategoryGridItem(
                      category: Category(
                        color: Colors.black,
                        title: title[index],
                        id: id[index],
                        imageAddress: imageAddress[index],
                      ),
                      onSelectCategory: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ProductsScreen(
                              title: title[index],
                              category: id[index],
                              isEats: true,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
