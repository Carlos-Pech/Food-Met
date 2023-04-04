import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/widgets/Product/carrusel.dart';
import 'package:food_met/widgets/Product/descripcion.dart';
import 'package:food_met/widgets/Product/nombre.dart';
import 'package:food_met/widgets/Product/tabbar.dart';

import '../../Dtos/providers/carrito_compras_providers.dart';

class DetailsProduct extends StatelessWidget {
  final Products product;
  const DetailsProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productId = product.id;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material app',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          // El resto del contenido del AppBar
        ),
        body: Column(
          children: [
            Carrusel(
              product: product,
            ),
            Nombre(
              product: product,
            ),
            Descripcion(
              product: product,
            ),
            const Divider(
              height: 5,
              thickness: 0.5,
              color: Color.fromARGB(255, 206, 206, 206),
            ),
            Tabbarr(
              product: product,
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Precio: \$${product.price.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
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
                  icon: const Icon(Icons.calculate),
                  label: const Text('Agregar a la calculadora'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
