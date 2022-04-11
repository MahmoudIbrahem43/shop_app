import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_shopping_app/providers/cart.dart';
import 'package:real_shopping_app/providers/product.dart';
import 'package:real_shopping_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailsScreen.routeName,
                arguments: product.id,
              );
            },
            child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, child) {
              return IconButton(
                onPressed: () {
                  product.toggleFavouritStatus();
                },
                icon: Icon(
                  product.isFavourit
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Colors.deepOrange,
                ),
              );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.deepOrange,
            ),
          ),
        ),
      ),
    );
  }
}
