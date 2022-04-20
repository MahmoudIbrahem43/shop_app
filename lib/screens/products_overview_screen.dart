import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_shopping_app/providers/cart.dart';
import 'package:real_shopping_app/providers/products.dart';
import 'package:real_shopping_app/screens/cart_screen.dart';
import 'package:real_shopping_app/widgets/app_drawer.dart';
import 'package:real_shopping_app/widgets/badge.dart';
import '../widgets/productsGrid.dart';

enum Filters {
  Favorites,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var _showOnlyFavourits = false;
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //   Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  //   super.initState();
  // }

  @override
  void didChangeDependencies()async {
    if (_isInit) {
     setState(() {
        _isLoading = true;
     });
     await Provider.of<Products>(context).fetchAndSetProducts().then((_){
       setState(() {
         _isLoading=false;
       });
     });
    }
    _isInit = false;
    // print(Provider.of<Products>(context).items[0].title);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shop App'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => const [
                PopupMenuItem(
                  child: Text('Only Favourit'),
                  value: Filters.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: Filters.All,
                ),
              ],
              onSelected: (Filters selectedValue) {
                if (selectedValue == Filters.Favorites) {
                  setState(() {
                    _showOnlyFavourits = true;
                  });
                } else {
                  setState(() {
                    _showOnlyFavourits = false;
                  });
                }
              },
              icon: const Icon(Icons.more_vert),
            ),
            Consumer<Cart>(
              builder: (context, cart, ch) => Badge(
                child: ch!,
                value: cart.itemsCount.toString(),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : productsGrid(
                isFavourit: _showOnlyFavourits,
              ));
  }
}
