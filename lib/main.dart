import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_shopping_app/providers/cart.dart';
import 'package:real_shopping_app/providers/orders.dart';
import 'package:real_shopping_app/providers/products.dart';
import 'package:real_shopping_app/screens/cart_screen.dart';
import 'package:real_shopping_app/screens/orders_screen.dart';
import 'package:real_shopping_app/screens/product_detail_screen.dart';
import 'package:real_shopping_app/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Products>(
            create: (context) => Products(),
          ),
          ChangeNotifierProvider<Cart>(
            create: (context) => Cart(),
          ),
          ChangeNotifierProvider<Orders>(
            create: (context) => Orders(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
              fontFamily: 'Lato',
              primaryColor: Colors.purple,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.deepOrange)),
          home: ProductsOverViewScreen(),
          routes: {
            ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
          },
        ));
  }
}
