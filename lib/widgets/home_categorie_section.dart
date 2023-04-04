import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/product_providers.dart';
import 'package:food_met/widgets/Product/product_container.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;

    int itemCount = 2;
    double space = size.width;

    if (orientation == Orientation.landscape) {
      itemCount = 4;
    }

    if (space > 800.0) {
      itemCount = 4;
    }
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return GridView.builder(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          itemCount: provider.getProductsByStatus(true).length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: itemCount,
            childAspectRatio: 0.65,
          ),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final product = provider.getProductsByStatus(true)[index];
            return ProductWidget(product: product);
          },
        );
      },
    );
  }
}
