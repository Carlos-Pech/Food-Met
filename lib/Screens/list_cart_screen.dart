// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/Dtos/providers/cart2_providers.dart';
import 'package:food_met/Screens/ListCart/appbar_cart.dart';
import 'package:food_met/Dtos/providers/carrito_compras_providers.dart';

import 'package:food_met/Screens/ListCart/card_cart.dart';
import 'package:food_met/Screens/ListCart/total_calories_price.dart';
import 'package:food_met/widgets/Home/botton_navigation.dart';
import 'package:provider/provider.dart';

class CartShoping extends StatefulWidget {
  const CartShoping({Key? key}) : super(key: key);

  @override
  _CartShopingState createState() => _CartShopingState();
}

class _CartShopingState extends State<CartShoping> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCart(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              if (cartProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (cartProvider.products.isEmpty) {
                return const Center(
                  child: Text('No hay productos en la calculadora'),
                );
              } else {
                return Expanded(
                  child: RefreshIndicator(
                    // Definimos la función de actualización que se ejecutará al tirar hacia abajo
                    onRefresh: () => cartProvider.fetchProducts(),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartProvider.products.fold<int>(
                              0,
                              (previousValue, cart) =>
                                  previousValue + cart.products.length,
                            ),
                            itemBuilder: (context, index) {
                              int runningTotal = 0;
                              for (final cart in cartProvider.products) {
                                final products = cart.products;
                                if (index < runningTotal + products.length) {
                                  final product =
                                      products[index - runningTotal];
                                  return CardList(
                                    product: product,
                                    cart: cart,
                                    onRemoved: () {
                                      cartProvider.removeItem(product);
                                    },
                                  );
                                }
                                runningTotal += products.length;
                              }
                              throw StateError('Invalid index');
                            },
                          ),
                        ),
                        const TotalCalories(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Boton(context, currentIndex),
    );
  }
}

void showPopup(BuildContext context, Products user) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 200.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
              Image.network(user.image,
                  fit: BoxFit.cover, alignment: Alignment.topCenter),
              const SizedBox(height: 10.0),
              Text(user.name),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    const Icon(Icons.price_change, color: Colors.green),
                    Text(user.price.toString())
                  ]),
                  Column(
                    children: [
                      const Icon(Icons.timer, color: Colors.green),
                      const SizedBox(height: 2),
                      Text(
                        '${user.time} min',
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      user.totalCalories >= 200
                          ? const Icon(Icons.local_fire_department,
                              color: Colors.red)
                          : Image.asset('assets/icons/low-calorie.png',
                              width: 28, height: 28),
                      const SizedBox(height: 2),
                      Text(
                        '${user.totalCalories} Kcal',
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar')),
            ],
          ),
        ),
      );
    },
  );
}



// class CartEmpty extends StatelessWidget {
//   const CartEmpty({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.network(
//               'https://media2.giphy.com/media/GHOLi8MfqNoo9l3Xkn/giphy.gif?cid=ecf05e47nz4mrwey7ads2sfwmykjaj5or8p4j13chq21izt7&rid=giphy.gif&ct=g',
//               height: 300,
//               width: 300,
//             ),
//             const SizedBox(height: 16.0),
//             const Text("El carrito está vacío."),
//           ],
//         ),
//       ),
//     );
//   }
// }
