import 'package:flutter/material.dart';
import 'package:recipies/model/category_model.dart';
import 'package:recipies/widget/category_item.dart';
import '../dummy_data.dart';

class Categories extends StatelessWidget {
  CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: DUMMYCATEGORIES.map((element) {
        return CategoryItem(element.id, element.title, element.color);
      }).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    );
  }
}
// appBar: AppBar(
// title: const Text("Deli Meal"),
// ),
