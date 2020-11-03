import 'package:flutter/material.dart';
import 'package:recipies/dummy_data.dart';
import 'package:recipies/model/meal.dart';
import 'package:recipies/screen/tab.dart';

import 'category_item_details.dart';
import 'filters.dart';
import 'meal_detail.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "vegan": false,
    "vegetarian": false,
    "lactose": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegetarian"] && !meal.isVegetarian) {
          return false;
        }
        if (_filters["vegan"] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal)=> meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

  bool _isMealFavorite(String id){
  _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_availableMeals);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipies',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1.0),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            title: TextStyle(
                fontSize: 17.8,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: Categories(),
      routes: {
        "/": (ctx) => TabScreen(_favoriteMeals),
        CategoryItemDetails.routeName: (ctx) =>
            CategoryItemDetails(_availableMeals),
        MealDetail.routeName: (ctx) => MealDetail(_toggleFavorites, _isMealFavorite),
        Filters.routeName: (ctx) => Filters(_filters,_setFilters),
      },
    );
  }
}
