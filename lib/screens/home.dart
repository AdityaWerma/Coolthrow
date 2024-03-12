import 'package:carousel_slider/carousel_slider.dart';
import 'package:coolthrow/models/product.dart';
import 'package:coolthrow/screens/product_details.dart';
import 'package:coolthrow/screens/products.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../widgets/category_grid_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dbRefSlideShow = FirebaseDatabase.instance.ref('Home/SlideShow');
    final dbRefTrendingProducts =
        FirebaseDatabase.instance.ref('Home/TrendingProducts');
    final dbRecommendedProducts =
        FirebaseDatabase.instance.ref('Home/RecommendedProducts');
    final dbTopRatedProducts =
    FirebaseDatabase.instance.ref('Home/TopRatedProducts');
    final dbSuggestedProducts =
    FirebaseDatabase.instance.ref('Home/SuggestedProducts');

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            StreamBuilder(
                stream: dbRefSlideShow.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    dynamic data = snapshot.data!.snapshot.value as dynamic;

                    List<dynamic> imageAddress = [];
                    List<dynamic> id = [];

                    try {
                      if (data is List) {
                        for (var item in data) {
                          imageAddress.add(item['imageAddress']);
                          id.add(item['id']);
                        }
                      } else if (data != null && data is Map) {
                        data.forEach((key, value) {
                          imageAddress.add(value['imageAddress']);
                          id.add(value['id']);
                        });
                      }
                    } catch (e) {
                      const Text('Something went wrong!');
                    }

                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 230.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                      items: imageAddress
                          .map(
                            (url) => Image.network(url, fit: BoxFit.fill),
                          )
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: Colors.white,), // Show loading indicator
                    );
                  }
                }),
            const SizedBox(height: 12),
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    ' Trending Products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  StreamBuilder(
                      stream: dbRefTrendingProducts.onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          dynamic data =
                              snapshot.data!.snapshot.value as dynamic;

                          List<dynamic> imageAddress = [];
                          List<dynamic> id = [];
                          List<dynamic> title = [];
                          List<dynamic> specification = [];
                          List<dynamic> price = [];
                          List<dynamic> categoryBelong = [];

                          try {
                            if (data is List) {
                              for (var item in data) {
                                imageAddress.add(item['imageAddress']);
                                id.add(item['id']);
                                title.add(item['title']);
                                price.add(item['price']);
                                specification.add(item['specification']);
                                categoryBelong.add(item['categoryBelong']);
                              }
                            } else if (data != null && data is Map) {
                              data.forEach((key, value) {
                                imageAddress.add(value['imageAddress']);
                                id.add(value['id']);
                                title.add(value['title']);
                                price.add(value['price']);
                                specification.add(value['specification']);
                                categoryBelong.add(value['categoryBelong']);

                              });
                            }
                          } catch (e) {
                            const Text('Something went wrong!');
                          }

                          return Container(
                            height: 180,
                            color: const Color.fromARGB(255, 241, 241, 241),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: id.length,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                ProductDetailsScreen(
                                              product: Product(
                                                categoryBelong: categoryBelong[index],
                                                id: id[index].toString(),
                                                title: title[index],
                                                imageUrl: imageAddress[index],
                                                price: price[index].toString(),
                                                specification: specification[index],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 5),
                                        child:
                                            Image.network(imageAddress[index]),
                                      ),
                                    )),
                          );
                        } else {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white,), // Show loading indicator
                          );
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    ' Recommended for you by Dhigence AI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  StreamBuilder(
                      stream: dbRecommendedProducts.onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          dynamic data =
                              snapshot.data!.snapshot.value as dynamic;

                          List<dynamic> imageAddress = [];
                          List<dynamic> id = [];
                          List<dynamic> title = [];
                          List<dynamic> specification = [];
                          List<dynamic> price = [];
                          List<dynamic> categoryBelong = [];


                          try {
                            if (data is List) {
                              for (var item in data) {
                                imageAddress.add(item['imageAddress']);
                                id.add(item['id']);
                                title.add(item['title']);
                                price.add(item['price']);
                                specification.add(item['specification']);
                                categoryBelong.add(item['categoryBelong']);

                              }
                            } else if (data != null && data is Map) {
                              data.forEach((key, value) {
                                imageAddress.add(value['imageAddress']);
                                id.add(value['id']);
                                title.add(value['title']);
                                price.add(value['price']);
                                specification.add(value['specification']);
                                categoryBelong.add(value['categoryBelong']);
                              });
                            }
                          } catch (e) {
                            const Text('Something went wrong!');
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: id.length,
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              ProductDetailsScreen(
                                            product: Product(
                                              categoryBelong: categoryBelong[index],
                                              id: id[index].toString(),
                                              title: title[index],
                                              imageUrl: imageAddress[index],
                                              price: price[index].toString(),
                                              specification: specification[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                      child: Image.network(imageAddress[index]),
                                    ),
                                  ));
                        } else {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white,), // Show loading indicator
                          );
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    ' Top Rated',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  StreamBuilder(
                      stream: dbTopRatedProducts.onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          dynamic data =
                          snapshot.data!.snapshot.value as dynamic;

                          List<dynamic> imageAddress = [];
                          List<dynamic> id = [];
                          List<dynamic> title = [];
                          List<dynamic> price = [];
                          List<dynamic> specification = [];
                          List<dynamic> categoryBelong = [];


                          try {
                            if (data is List) {
                              for (var item in data) {
                                imageAddress.add(item['imageAddress']);
                                id.add(item['id']);
                                title.add(item['title']);
                                price.add(item['price']);
                                specification.add(item['specification']);
                                categoryBelong.add(item['categoryBelong']);

                              }
                            } else if (data != null && data is Map) {
                              data.forEach((key, value) {
                                imageAddress.add(value['imageAddress']);
                                id.add(value['id']);
                                title.add(value['title']);
                                price.add(value['price']);
                                specification.add(value['specification']);
                                categoryBelong.add(value['categoryBelong']);

                              });
                            }
                          } catch (e) {
                            const Text('Something went wrong!');
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: id.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          ProductDetailsScreen(
                                            product: Product(
                                              categoryBelong: categoryBelong[index],
                                              id: id[index].toString(),
                                              title: title[index],
                                              imageUrl: imageAddress[index],
                                              price: price[index].toString(),
                                              specification: specification[index]
                                            ),
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: Image.network(imageAddress[index]),
                                ),
                              ));
                        } else {
                          return const Center(
                            child:
                            CircularProgressIndicator(color: Colors.white,), // Show loading indicator
                          );
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    ' Suggested for you',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  StreamBuilder(
                      stream: dbSuggestedProducts.onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.snapshot.value != null) {
                          dynamic data =
                          snapshot.data!.snapshot.value as dynamic;

                          List<dynamic> imageAddress = [];
                          List<dynamic> id = [];
                          List<dynamic> title = [];
                          List<dynamic> price = [];
                          List<dynamic> specification = [];
                          List<dynamic> categoryBelong = [];



                          try {
                            if (data is List) {
                              for (var item in data) {
                                imageAddress.add(item['imageAddress']);
                                id.add(item['id']);
                                title.add(item['title']);
                                price.add(item['price']);
                                specification.add(item['specification']);
                                categoryBelong.add(item['categoryBelong']);



                              }
                            } else if (data != null && data is Map) {
                              data.forEach((key, value) {
                                imageAddress.add(value['imageAddress']);
                                id.add(value['id']);
                                title.add(value['title']);
                                price.add(value['price']);
                                specification.add(value['specification']);
                                categoryBelong.add(value['categoryBelong']);

                              });
                            }
                          } catch (e) {
                            const Text('Something went wrong!');
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: id.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          ProductDetailsScreen(
                                            product: Product(
                                              categoryBelong: categoryBelong[index],
                                              id: id[index].toString(),
                                              title: title[index],
                                              imageUrl: imageAddress[index],
                                              price: price[index].toString(),
                                              specification: specification[index]
                                            ),
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  child: Image.network(imageAddress[index]),
                                ),
                              ));
                        } else {
                          return const Center(
                            child:
                            CircularProgressIndicator(color: Colors.white,), // Show loading indicator
                          );
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
