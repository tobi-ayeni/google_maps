import 'package:flutter/material.dart';
import 'package:recipies/model/meal.dart';
import '../widget/main_drawer.dart';
import './favorites.dart';
import 'category.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabScreen(this.favouriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  void _selected(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {
        "page": Categories(),
        "title": "Categories",
      },
      {
        "page": Favorites(widget.favouriteMeals),
        "title": "Your Favorites",
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"]),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selected,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        selectedFontSize: 24,
        unselectedFontSize: 14,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          )
        ],
      ),
    );
  }
}
// TO ADD TABSCREEN AT THE TOP OF YOUR SCREEN
// return DefaultTabController(
//   length: 2,
//   child: Scaffold(
//     appBar: AppBar(
//       title: Text("Meals"),
//       bottom: TabBar(
//         tabs: [
//           Tab(icon: Icon(Icons.category), text: "Categories",),
//           Tab(icon: Icon(Icons.star), text: "Favorites ",),
//         ],
//       ),
//     ),
//     body: TabBarView(
//       children: [
//         Categories(),
//         Favorites()
//       ],
//     ),
//   ),
// );
