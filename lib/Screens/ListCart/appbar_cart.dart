import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/cart2_providers.dart';
import 'package:provider/provider.dart';

class AppBarCart extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text("Calculadora", style: TextStyle(color: Colors.black,),),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Consumer<CartProvider>(
          builder: (context, cartProvider, child) => Stack(
            children: [
              IconButton(
                onPressed: () {
                  
                },
                icon: const Icon(
                  Icons.calculate,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              if (cartProvider.products.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                    child: Text(
                      cartProvider.products
                          .fold<int>(
                            0,
                            (previousValue, cart) =>
                                previousValue + cart.products.length,
                          )
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
