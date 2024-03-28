import 'package:coolthrow/screens/eats.dart';
import 'package:coolthrow/screens/home.dart';
import 'package:coolthrow/screens/orders.dart';
import 'package:coolthrow/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:coolthrow/screens/categories.dart';
import 'package:coolthrow/widgets/bottom_navigation_bar.dart';

import '../models/product.dart';
import 'account.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  static const IconData location_on =
      IconData(0xe3ab, fontFamily: 'MaterialIcons');

  int _selectedIndex = 0;
  final List<Product> _favoriteMeals = [];

  late final void Function(Product product) onToggleFavorite; //main banaya hoon

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleMealFavouriteStatus(Product product) {
    final isExisting = _favoriteMeals.contains(product);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(product);
      });
      _showInfoMessage('Removed from cart.');
    } else {
      setState(() {
        _favoriteMeals.add(product);
        _showInfoMessage('Added to cart!');
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();
    bool isAppBarVisible = true;

    if (_selectedIndex == 1) {
      activePage = const CategoriesScreen();
    }
    if (_selectedIndex == 2) {
      activePage = const EatsScreen();
      isAppBarVisible = false;
    }
    if (_selectedIndex == 3) {
      activePage = const OrdersScreen();
    }
    if (_selectedIndex == 4) {
      activePage = const AccountScreen();
      isAppBarVisible = false;
    }

    return Scaffold(
      appBar: isAppBarVisible
          ? AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const SearchScreen(),
                      ),
                    );
                  },
                ),
              ],
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFE2D1),
                      Color(0xFFDCFCFF),
                    ],
                  ),
                ),
              ),
              leading: Image.asset('assets/images/Coolthrow_logo.png'),
              title: const Text(
                'Coolthrow',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize:
                    const Size.fromHeight(25.0), // Adjust the height as needed
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  color: const Color(0xFFDCFCFF),
                  child: const Row(
                    children: [
                      SizedBox(width: 9),
                      Icon(
                        location_on,
                        size: 15,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Deliver to Rajkiya Engineering College, Azamgarh',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: activePage,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
