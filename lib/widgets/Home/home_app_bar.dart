//how create a dive?
import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/cart2_providers.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

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
                      const Dropdown(),
                      IconButton(
                        onPressed: () {
                          // Mostrar el AlertDialog para añadir un nuevo Mesa aquí
                        },
                        icon: const Icon(Icons.table_restaurant),
                      ),
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
                                            previousValue +
                                            cart.products.length,
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

//.......................................

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String _selectedMesa = '';
  List<Mesa> _mesas = [];

  Future<void> _getMesas() async {
    final response = await http
        .get(Uri.parse('https://api-foodmet.up.railway.app/mesa/mesas'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['docs'];
      final List<Mesa> mesas = data.map((mesa) => Mesa.fromJson(mesa)).toList();
      setState(() {
        _mesas = mesas;
        if (_mesas.isNotEmpty) {
          _selectedMesa = _mesas[0].nombre;
        }
      });
    } else {
      throw Exception('Failed to load mesas');
    }
  }

  @override
  void initState() {
    super.initState();
    _getMesas();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedMesa,
      onChanged: (String? newValue) {
        setState(() {
          _selectedMesa = newValue!;
        });
        _selectMesa(newValue!);
      },
      items: _mesas.map<DropdownMenuItem<String>>((Mesa mesa) {
        return DropdownMenuItem<String>(
          value: mesa.nombre,
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mesa.status ? Colors.green : Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(mesa.nombre),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 16,
                ),
                onPressed: () {
                  _liberarMesa(mesa.id);
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<void> _liberarMesa(String id) async {
    try {
      final response = await http.put(Uri.parse(
          'https://api-foodmet.up.railway.app/mesa/mesas/$id/liberar'));
      //a
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Mesa liberada: $id');
        await _getMesas();
      } else {
        throw Exception('Error al liberar mesa');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error al liberar la mesa: $error');
    }
  }

  Future<void> _selectMesa(String mesaNombre) async {
    try {
      final response = await http.post(
          Uri.parse('https://api-foodmet.up.railway.app/mesa/mesa/seleccionar'),
          body: {'table': mesaNombre});

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Mesa seleccionada: $mesaNombre');
      } else {
        throw Exception('error al seleccionar mesa');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error al seleccionar la mesa: $error');
    }
  }
}

class Mesa {
  final String id;
  final String nombre;
  final bool status;

  Mesa({
    required this.id,
    required this.nombre,
    required this.status,
  });

  factory Mesa.fromJson(Map<String, dynamic> json) {
    return Mesa(
      id: json['_id'],
      nombre: json['nombre'],
      status: json['status'],
    );
  }
}


// class MyDropDown extends StatefulWidget {
//   const Dropdown({Key? key}) : super(key: key);

//   @override
//   _MyDropDownState createState() => _MyDropDownState();
// }

// class _MyDropDownState extends State<Dropdown> {
//   String _selectedClient = 'Mesa 1';
//   final List<String> _clientOptions = ['Mesa 1', 'Mesa 2', 'Mesa 3'];

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: _selectedClient,
//       onChanged: (String? newValue) {
//         setState(() {
//           _selectedClient = newValue!;
//         });
//       },
//       items: _clientOptions.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }


