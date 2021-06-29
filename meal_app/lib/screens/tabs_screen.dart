import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import '../screens/favorites_screen.dart';
import '../screens/categories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages;
  int _selectedPageIndex = 0;

  @override
  initState() {
    pages = [
      {"page": CategoriesScreen(), "title": 'Category'},
      {"page": FavoritesScreen(widget._favoriteMeals), "title": 'Favorites'},
    ];
    super.initState();
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex]['title']),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: (pages[_selectedPageIndex]['page'] as Widget),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Categories"),
            // backgroundColor: Theme.of(context).primaryColor)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Favorites"),
            // backgroundColor: Theme.of(context).primaryColor)
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
