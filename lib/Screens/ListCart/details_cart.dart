import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/carrito_compras_providers.dart';

import '../../Dtos/Models/cart_resonse_dto.dart';

class Datos extends StatelessWidget {
  const Datos({
    Key? key,
    required this.product,
    required this.cart,
    required this.onRemoved, // Nuevo argumento
  }) : super(key: key);

  final Product product;
  final Cart cart;
  final VoidCallback onRemoved; // Nuevo campo

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: () {
                  final cartId = cart.id;
                  final productId = product.id;
                  // ignore: unnecessary_null_comparison
                  if (cartId != null) {
                    final cart = CarritoDeCompras();
                    cart.eliminarCarrito(cartId, productId);
                    debugPrint(product.name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Producto eliminado de la calculadora'),
                      ),
                    );
                    onRemoved(); // Llamada al VoidCallback
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '\$ ${product.price}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Calorias: ${product.totalCalories}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
