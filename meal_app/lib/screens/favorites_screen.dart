import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  FavoritesScreen(this._favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty)
      return Center(
        child: Text("Favorites list is empty!"),
      );
    else
      return Center(
        child: Center(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: _favoriteMeals[index].id,
                title: _favoriteMeals[index].title,
                imageUrl: _favoriteMeals[index].imageUrl,
                duration: _favoriteMeals[index].duration,
                complexity: _favoriteMeals[index].complexity,
                affordability: _favoriteMeals[index].affordability,
              );
            },
            itemCount: _favoriteMeals.length,
          ),
        ),
      );
  }
}
