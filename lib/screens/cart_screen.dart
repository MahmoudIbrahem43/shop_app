import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_shopping_app/providers/cart.dart' as ci;
import 'package:real_shopping_app/providers/orders.dart';

import '../providers/cart.dart' as c;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ci.Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    '\$' + cart.totalAmount.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                OrderButton(cart: cart),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (constex, index) => CartItem(
                id: cart.items.values.toList()[index].id,
                productId: cart.items.keys.toList()[index],
                title: cart.items.values.toList()[index].title,
                quantity: cart.items.values.toList()[index].quantity,
                price: cart.items.values.toList()[index].price),
            itemCount: cart.items.length,
          ),
        ),
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  final c.Cart? cart;
  const OrderButton({this.cart});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart!.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart!.items.values.toList(), widget.cart!.totalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cart!.clear();
            },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'Order Now',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
    );
  }
}
