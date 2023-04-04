import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/Dtos/providers/carrito_compras_providers.dart';

class ProductWidgets {
  static Widget buildShoppingButton(BuildContext context, Products product) {
    final productId = product.id;

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // ignore: unnecessary_null_comparison
            if (productId != null) {
              final cart = CarritoDeCompras();
              cart.agregarProductoAlCarrito(productId);
              debugPrint(product.name);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Producto agregado a la calculadora'),
                ),
              );
            } else {
              debugPrint(
                  'El ID del producto no es un número entero válido: ${product.id}');
              debugPrint(product.name);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('El producto no tiene un ID válido.'),
                ),
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 187, 3, 3)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(20, 20),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(10),
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 20,
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  static Widget buildTimeColumn(Products product) {
    return Column(
      children: [
        const Icon(
          Icons.timer,
          color: Colors.green,
        ),
        const SizedBox(height: 2),
        Text(
          '${product.time} min',
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static Widget buildCaloriesColumn(Products product) {
    return Column(
      children: [
        product.totalCalories >= 200
            ? const Icon(
                Icons.local_fire_department,
                color: Colors.red,
              )
            : Image.asset(
                'assets/icons/low-calorie.png',
                width: 28,
                height: 28,
              ),
        const SizedBox(height: 2),
        Text(
          '${product.totalCalories} Cal',
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
