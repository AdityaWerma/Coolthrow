import 'package:coolthrow/screens/home.dart';
import 'package:coolthrow/screens/orders.dart';
import 'package:flutter/material.dart';
import 'package:coolthrow/screens/categories.dart';
import 'package:coolthrow/screens/filters.dart';
import 'package:coolthrow/widgets/bottom_navigation_bar.dart';

import '../models/product.dart';
import 'account.dart';
import 'chat.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
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

  void _setScreen(String identifier) {
    Navigator.of(context).pop(); //closing the drawer manulally
    if (identifier == 'filters') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const FiltersScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();

    if (_selectedIndex == 1) {
      activePage = const CategoriesScreen(
      );
    }
    if (_selectedIndex == 2) {
      activePage = const OrdersScreen();
    }
    // if (_selectedIndex == 3) {
    //   activePage = ProductsScreen(
    //     products: _favoriteMeals,
    //     // onToggleFavorite: _toggleMealFavouriteStatus,
    //     title: '',
    //   );
    // }
    if (_selectedIndex == 4) {
      activePage = const ChatScreen();

    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // FirebaseAuth.instance.signOut();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AccountScreen(),
              ),);
            },
            icon: Icon(
              Icons.account_circle_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: activePage,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
