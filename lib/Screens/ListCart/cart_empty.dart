import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/cart2_providers.dart';
import 'package:provider/provider.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          await cartProvider.fetchProducts();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://media2.giphy.com/media/GHOLi8MfqNoo9l3Xkn/giphy.gif?cid=ecf05e47nz4mrwey7ads2sfwmykjaj5or8p4j13chq21izt7&rid=giphy.gif&ct=g',
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 16.0),
              const Text("La calculadora está vacía."),
            ],
          ),
        ),
      ),
    );
  }
}
