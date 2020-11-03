import 'package:flutter/material.dart';
import 'package:recipies/model/meal.dart';
import 'package:recipies/widget/meal_item.dart';

class Favorites extends StatelessWidget {
  final List<Meal> favoritessMealss;

  Favorites(this.favoritessMealss);

  @override
  Widget build(BuildContext context) {
    if(favoritessMealss.isEmpty){
      return Center(
        child: Text("You have no Favorites yet - start adding some!"),
      );
    }else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            title: favoritessMealss[index].title,
            imageUrl: favoritessMealss[index].imageUrl,
            duration: favoritessMealss[index].duration,
            complexity: favoritessMealss[index].complexity,
            affordability:favoritessMealss[index].affordability,
            id: favoritessMealss[index].id,
          );
        },
        itemCount: favoritessMealss.length,
      );
    }

  }
}
