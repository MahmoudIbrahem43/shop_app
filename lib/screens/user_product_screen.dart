import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_shopping_app/providers/products.dart';
import 'package:real_shopping_app/screens/edit_product_screen.dart';
import 'package:real_shopping_app/widgets/app_drawer.dart';
import 'package:real_shopping_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_product';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Prodcuts'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                id: productsData.items[index].id,
                title: productsData.items[index].title,
                imageUrl: productsData.items[index].imageUrl,
              ),
              const Divider()
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
