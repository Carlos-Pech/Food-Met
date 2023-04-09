//how create a dive?

import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/cart2_providers.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  "Food Met",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  Row(
                    children: [              
                      const Text('Añadir cliente'),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String nombreCliente =
                                  ''; // aquí se almacenará el nombre del nuevo cliente
                              return AlertDialog(
                                title: const Text('Añadir nuevo cliente'),
                                content: TextField(
                                  onChanged: (value) {
                                    nombreCliente =
                                        value; // actualiza el valor del nombre del cliente en tiempo real
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Nombre del cliente',
                                    hintText:
                                        'Ingrese el nombre del nuevo cliente',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Guardar'),
                                    onPressed: () {
                                      // Aquí puedes agregar el código para guardar los datos del nuevo cliente.
                                      // En este ejemplo, simplemente se imprime el nombre del nuevo cliente.
                                      debugPrint(
                                          'Se ha agregado el cliente $nombreCliente.');
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),

                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const CartShoping(),
                  //       ),
                  //     );
                  //   },
                  //   icon: const Icon(
                  //     Icons.add,
                  //     color: Colors.black,
                  //     size: 30,
                  //   ),
                  // ),
                  cartProvider.products.isNotEmpty
                      ? Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              cartProvider.products
                                  .fold<int>(
                                    0,
                                    (previousValue, cart) =>
                                        previousValue + cart.products.length,
                                  )
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
