import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';

// ignore: must_be_immutable

class Carrusel extends StatefulWidget {
  final Products product;

  const Carrusel({Key? key, required this.product}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CarruselState createState() => _CarruselState();
}

class _CarruselState extends State<Carrusel> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.product.image,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        // En caso de error, mostrar una imagen por defecto
        return Image.asset("assets/images/error.gif");
      },
    );
  }
}
