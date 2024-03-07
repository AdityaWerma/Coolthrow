import 'package:flutter/material.dart';
import 'package:coolthrow/screens/tabs.dart';
import 'package:coolthrow/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(
          onSelectScreen: (identifier) {
            Navigator.of(context).pop();
            if (identifier == 'meals') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      const TabsScreen())); //pushreplacement for replacing screen
            }
          },
        ),
        appBar: AppBar(
          title: const Text('Your filters'),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop({
              Filter.glutenFree : _glutenFreeFilterSet,
            });
            return false;
          },
          child: Column(
            children: [
              SwitchListTile(
                value: _glutenFreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _glutenFreeFilterSet = isChecked;
                  });
                },
                title: Text('Gluten-free'),
                subtitle: Text('Only include Gluten-free meals.'),
                activeColor: Colors.blue,
                contentPadding: EdgeInsets.only(left: 34, right: 22),
              ),
            ],
          ),
        ));
  }
}
