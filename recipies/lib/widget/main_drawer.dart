import 'package:flutter/material.dart';
import '../screen/filters.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
              text: "Meals",
              icon: Icons.restaurant,
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  ("/"),
                );
              }),
          buildListTile(
            text: "Filters",
            icon: Icons.settings,
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                Filters.routeName,
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildListTile({String text, IconData icon, Function onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
