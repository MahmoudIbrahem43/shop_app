import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_shopping_app/providers/product.dart';
import 'package:real_shopping_app/providers/products.dart';
import 'product_item.dart';

class productsGrid extends StatelessWidget {
  bool isFavourit;
  productsGrid({required this.isFavourit});


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts =isFavourit ? productsData.favouritProduct: productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => ChangeNotifierProvider<Product>.value(
        value:  loadedProducts[index],
        child: ProductItem(),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
