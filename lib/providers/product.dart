import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourit;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourit = false});

  Future<void> toggleFavouritStatus() async {
    final oldStatus = isFavourit;
    isFavourit = !isFavourit;
    notifyListeners();
    final url = Uri.parse(
        'https://shop-app-6390e-default-rtdb.firebaseio.com/products/$id.json');
    try {
      final response =
          await http.patch(url, body: jsonEncode({'isFavorite': isFavourit}));
      if (response.statusCode >= 400) {
        isFavourit = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourit = oldStatus;
      notifyListeners();
    }
  }
}
