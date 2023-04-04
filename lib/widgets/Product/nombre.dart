import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';

class Nombre extends StatelessWidget {
  final Products product;

  const Nombre({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(23, 20, 20, 10),
          child: Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
