import 'dart:convert';

import 'package:flutter_base/example/data/models/example_model.dart';
import 'package:http/http.dart' as http;

class ExampleRepositories {
  ExampleRepositories();

  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getProduct(double id) async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/${id.toInt()}'),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
