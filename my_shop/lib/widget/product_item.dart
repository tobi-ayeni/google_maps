import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/screen/product_detail.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // ProductItem(this.id, this.title, this.imageUrl); // final Product _product;
  //
  // ProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context);
    // print(productData.isFavorite);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetail.routeName,
          arguments: productData.id
        );
      },
      child: GridTile(
        child: Image.network(
          productData.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: GridTileBar(
            backgroundColor: Colors.black87,
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
            leading: IconButton(
              icon: Icon(productData.isFavorite ? Icons.favorite: Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                productData.toggleFavoriteStatus();
              },
            ),
            title: Text(
              productData.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
