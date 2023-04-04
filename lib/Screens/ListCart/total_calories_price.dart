import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/cart2_providers.dart';
import 'package:food_met/Dtos/services/remote_services.dart';
import 'package:provider/provider.dart';

class TotalCalories extends StatelessWidget {
  const TotalCalories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final cartProvider = context.read<CartProvider>();
        final totalCalories = cartProvider.products.fold<double>(
          0,
          (previousValue, cart) =>
              previousValue +
              cart.products.fold<double>(
                0,
                (previousValue, product) =>
                    previousValue + product.totalCalories,
              ),
        );
        final totalPrice = cartProvider.products.fold<double>(
          0,
          (previousValue, cart) =>
              previousValue +
              cart.products.fold<double>(
                0,
                (previousValue, product) => previousValue + product.price,
              ),
        );
        // mostrar un diálogo emergente con los valores de calorías totales y precio total
        final shouldClearCart = await DialogQuestion(context);
        if (shouldClearCart == true) {
          await RemoteServices.clearCart(); // vaciar el carrito
          // Mostrar un segundo diálogo con los totales
          // ignore: use_build_context_synchronously
          await DialogResponse(context, totalCalories, totalPrice);
        }

        if (shouldClearCart == true) {
          await RemoteServices.clearCart(); // vaciar el carrito
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Total(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> DialogResponse(
      BuildContext context, double totalCalories, double totalPrice) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Totales'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calorías totales: $totalCalories'),
            Text('Precio total: \$$totalPrice'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<bool?> DialogQuestion(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Totales'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Al calcular el total, la calculadora se vaciará'),
            SizedBox(height: 16),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Aceptar',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class Total extends StatelessWidget {
  const Total({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: Text(
                      'Calcular Calorias',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
