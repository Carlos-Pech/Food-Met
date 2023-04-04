import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';

class Descripcion extends StatelessWidget {
  final Products product;
  const Descripcion({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final productId = product.id;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
          width: 260,
          child: Text(
            textAlign: TextAlign.justify,
            product.description,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ),
        MediaQuery.of(context).orientation == Orientation.landscape
            ? Expanded(
                child:
                    Container()) // agregar un contenedor vacío para hacer espacio para el botón
            : const SizedBox(
                width:
                    10), // agregar un espacio de 10 de ancho para separar el texto del botón
        Padding(
          padding: MediaQuery.of(context).orientation == Orientation.landscape
              ? const EdgeInsets.fromLTRB(0, 0, 20,
                  20) // mover el botón a la derecha si la pantalla está en modo horizontal
              : const EdgeInsets.fromLTRB(0, 0, 20, 20),
        ),
      ],
    );
  }
}
