import 'package:flutter/material.dart';
import 'package:food_met/Screens/ListCart/details_cart.dart';


import '../../Dtos/Models/cart_resonse_dto.dart';

class CardList extends StatelessWidget {
  const CardList({
    Key? key,
    required this.product,
    required this.cart,
    required this.onRemoved,
  });

  final Product product;
  final Cart cart;
  final VoidCallback onRemoved;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.blue[700],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    // width: 120,
                    // height: 150,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/opps2.jpg',
                        width: 100,
                        height: 100,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Datos(product: product, cart: cart, onRemoved: onRemoved)
              ],
            )
          ],
        ),
      ),
    );
  }
}
