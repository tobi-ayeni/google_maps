import 'package:flutter/material.dart';
import 'package:recipies/model/meal.dart';
import 'package:recipies/widget/meal_item.dart';
import '../dummy_data.dart';

class CategoryItemDetails extends StatelessWidget {
  static const routeName = "/categories_item_details";
  final List<Meal> availableMeals;


  CategoryItemDetails(this.availableMeals); //  final String title;
//  final String id;
//
//  CategoryItemDetails({this.title, this.id});

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final title = routeArguments["title"];
    final id = routeArguments["id"];
    final mealsByCategory = availableMeals.where((element) {
      return element.categoriesId.contains(id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            title: mealsByCategory[index].title,
            imageUrl: mealsByCategory[index].imageUrl,
            duration: mealsByCategory[index].duration,
            complexity: mealsByCategory[index].complexity,
            affordability: mealsByCategory[index].affordability,
            id: mealsByCategory[index].id,
          );
        },
        itemCount: mealsByCategory.length,
      ),
    );
  }
}
