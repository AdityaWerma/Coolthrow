import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this .onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.fastfood, size: 48),
                SizedBox(width: 18),
                Text('cooking up'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant, size: 26,),
            title: Text('sh'),
            onTap: (){
              onSelectScreen('meals');
            },

          ),
          ListTile(
            leading: Icon(Icons.restaurant, size: 26,),
            title: Text('sh'),
            onTap: (){
              onSelectScreen('filters');
            },

          ),
        ],
      ),
    );
  }
}
