import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';

class ProductItem extends StatelessWidget {
  final Products product;
  final VoidCallback onTap;

  const ProductItem({required this.product, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          product.image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Text('Precio: ${product.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: onTap,
        ),
      ),
    );
  }
}
