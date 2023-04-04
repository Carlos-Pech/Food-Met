import 'package:flutter/material.dart';

class TotalCaloriesDialog extends StatelessWidget {
  const TotalCaloriesDialog({
    Key? key,
    required this.totalCalories,
    required this.totalPrice,
  }) : super(key: key);

  final double totalCalories;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
    );
  }
}
