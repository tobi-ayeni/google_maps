import 'package:flutter/material.dart';
import '.././dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = "/menu_item_details";
  final Function toggleFavorites;
  final Function isFavorite;

  MealDetail(this.toggleFavorites, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSelectedTitle(context, "Ingredients"),
            buildContainerListView(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                      child: Text(
                        selectedMeal.ingredients[index],
                      ),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSelectedTitle(context, "Steps"),
            buildContainerListView(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("#${index + 1}"),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider()
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            isFavorite(mealId) == true ? Icons.star : Icons.star_border,
          ),
          onPressed: () => toggleFavorites(mealId)
          ),
    );
  }

  Widget buildSelectedTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainerListView(Widget child) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 200,
      width: 300,
      child: child,
    );
  }
}
