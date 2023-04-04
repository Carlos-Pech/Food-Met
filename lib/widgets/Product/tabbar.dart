import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';

class Tabbarr extends StatefulWidget {
  final Products product;
  const Tabbarr({super.key, required this.product});

  @override
  State<Tabbarr> createState() => _TabbarrState();
}

class _TabbarrState extends State<Tabbarr> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    // final Color? splashColor;
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 2),
                                    Text(
                                      "Tiempo: ${widget.product.time.toString()}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // const Icon(Icons.whatshot,
                                    //     color: Colors.white),
                                    const SizedBox(width: 2),
                                    Text(
                                      "Calorías: ${widget.product.totalCalories}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Ingredientes",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ...widget.product.ingredients!
                      .map(
                        (ingredient) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                ingredient.name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      int.parse(ingredient.calories) > 200
                                          ? const Icon(
                                              Icons.local_fire_department,
                                              color: Colors.red,
                                            )
                                          : Image.asset(
                                              'assets/icons/low-calorie.png',
                                              width: 28,
                                              height: 28,
                                            ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Calorías: ${ingredient.calories} Cal",
                                        style: TextStyle(
                                          color:
                                              int.parse(ingredient.calories) >
                                                      200
                                                  ? Colors.red
                                                  : Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.green,
                                          border: Border.all(
                                            color: double.parse(
                                                        ingredient.weight) >
                                                    200
                                                ? Colors.red
                                                : Colors.grey[400]!,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.scale,
                                              color: double.parse(
                                                          ingredient.weight) >
                                                      200
                                                  ? Colors.red
                                                  : Colors.white,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${ingredient.weight} ${ingredient.unidad}",
                                              style: TextStyle(
                                                color: double.parse(
                                                            ingredient.weight) >
                                                        200
                                                    ? Colors.red
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
