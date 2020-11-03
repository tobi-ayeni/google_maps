import 'package:flutter/material.dart';
import 'package:recipies/model/category_model.dart';
import '../screen/category_item_details.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.pushNamed(
          context,
          CategoryItemDetails.routeName,
          arguments: {
            "id": id,
            "title": title,
          },
        );
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (_) {
//              return CategoryItemDetails(
//                title: title,
//                id: id,
//              );
//            },
//
//          ),
//        );
        print(title);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: color,
            borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
