import 'package:flutter/material.dart';
import 'package:flutter_base/example/data/models/example_model.dart';
import 'package:flutter_base/example/ui/view/product_detail_page.dart';
import 'package:go_router/go_router.dart';

class ExampleItemCard extends StatelessWidget {
  const ExampleItemCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          ProductDetailPage.routeName,
          pathParameters: {'id': product.id.toString()},
        );
      },
      child: ListTile(
        leading: Image.network(
          product.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
        title: Text(product.title),
        subtitle: Text('\$${product.price}'),
      ),
    );
  }
}
