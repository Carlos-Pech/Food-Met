import 'package:flutter/material.dart';
import 'package:food_met/Screens/home_screen.dart';
import 'package:food_met/Screens/list_cart_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required IconThemeData selectedIconTheme,
      required TextStyle selectedLabelStyle});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<String> clientes = ["Cliente 1", "Cliente 2"];

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> menuItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color:
              widget.currentIndex == 2 ? const Color(0xFFF9A602) : Colors.black,
        ),
        label:
            'Cliente', //Aqui debe ir el nombre del cliente cuando lo seleccione
      ),
    ];

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: menuItems,
      selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    );
  }
}

// ignore: non_constant_identifier_names
BottomNavigationBar Boton(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      if (index == currentIndex) {
        return; // No hacer nada si se presiona el ícono de la pantalla actual
      }

      switch (index) {
        case 0:
          // Navegar a la pantalla de Inicio
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          break;
        case 1:
          // Navegar a la pantalla de Perfil
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartShoping()),
          );
          break;
        case 2:
          String selectedClient =
              'Cliente 1'; // Cliente seleccionado inicialmente
          DropDownCl(context, selectedClient);
          // SelectClient(context);
          break;

        default:
          break;
      }
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: currentIndex == 0 ? const Color(0xFFF9A602) : Colors.black,
        ),
        label: 'Inicio',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.calculate,
          color: currentIndex == 1 ? const Color(0xFFF9A602) : Colors.black,
        ),
        label: 'Calcula Cal.',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: currentIndex == 2 ? const Color(0xFFF9A602) : Colors.black,
        ),
        label: 'Cliente',
      ),
    ],
    selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  );
}

//Este metodo es para mostrar la lista de los clientes en un dropdown
// ignore: non_constant_identifier_names
Future<dynamic> DropDownCl(BuildContext context, String selectedClient) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Selecciona un cliente'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: selectedClient,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedClient = newValue;
                    // Lógica para manejar la selección del cliente aquí
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Cliente 2',
                    child: Text('Cliente 1'),
                  ),
                  DropdownMenuItem(
                    value: 'Cliente 1',
                    child: Text('Cliente 2'),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String updatedName = selectedClient;
                          return AlertDialog(
                            title: const Text('Editar cliente'),
                            content: TextFormField(
                              initialValue: selectedClient,
                              onChanged: (value) {
                                updatedName = value;
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  selectedClient = updatedName;
                                },
                                child: const Text('Guardar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmar eliminación'),
                            content: const Text(
                                '¿Está seguro de que desea eliminar este cliente?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Lógica para eliminar el cliente aquí
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Eliminar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmar eliminación'),
                        content: const Text(
                            '¿Está seguro de que desea vaciar toda la lista de clientes?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Lógica para vaciar la lista de clientes aquí
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Vaciar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Vaciar lista'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Future<dynamic> SelectClient(BuildContext context) {
  String clientName = 'Cliente 1'; //Nombre inicial del cliente
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Selecciona un cliente'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          ListTile(
            title: Text(clientName),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String updatedName = clientName;
                        return AlertDialog(
                          title: const Text('Editar cliente'),
                          content: TextFormField(
                            initialValue: clientName,
                            onChanged: (value) {
                              updatedName = value;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                clientName = updatedName;
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.green),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmar eliminación'),
                          content: const Text(
                              '¿Está seguro de que desea eliminar este cliente?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Lógica para eliminar el cliente aquí
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              // Lógica para seleccionar el Cliente 3
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  debugPrint("Pesionaste el boton");
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text('Eliminar clientes'),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

class MyDropDown extends StatefulWidget {
  const MyDropDown({Key? key}) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String _selectedClient = 'Cliente 1';
  final List<String> _clientOptions = ['Cliente 1', 'Cliente 2', 'Cliente 3'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedClient,
      onChanged: (String? newValue) {
        setState(() {
          _selectedClient = newValue!;
        });
      },
      items: _clientOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(value),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String updatedName = value;
                      return AlertDialog(
                        title: const Text('Editar cliente'),
                        content: TextFormField(
                          initialValue: value,
                          onChanged: (value) {
                            updatedName = value;
                          },
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                _clientOptions[_clientOptions.indexOf(value)] =
                                    updatedName;
                                _selectedClient = updatedName;
                              });
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.green),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmar eliminación'),
                        content: const Text(
                            '¿Está seguro de que desea eliminar este cliente?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                _clientOptions.remove(value);
                                _selectedClient = _clientOptions[0];
                              });
                              // Lógica para eliminar el cliente aquí
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Eliminar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

















// BottomNavigationBar Boton2(BuildContext context, int currentIndex) {
//   return BottomNavigationBar(
//     currentIndex: currentIndex,
//     onTap: (index) {
//       if (index == currentIndex) {
//         return; // No hacer nada si se presiona el ícono de la pantalla actual
//       }

//       switch (index) {
//         case 0:
//           // Navegar a la pantalla de Inicio
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeScreen()),
//           );
//           break;
//         case 1:
//           // Navegar a la pantalla de Perfil
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const CartShoping()),
//           );
//           break;
//         case 2:
//           break;
//         default:
//           break;
//       }
//     },
//     items: [
//       BottomNavigationBarItem(
//         icon: Icon(
//           Icons.home,
//           color: currentIndex == 0 ? Colors.blue : Colors.black,
//         ),
//         label: 'Inicio',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(
//           Icons.calculate,
//           color: currentIndex == 1 ? Colors.blue : Colors.black,
//         ),
//         label: 'Calcula Cal.',
//       ),
//     ],
//     selectedLabelStyle: const TextStyle(color: Colors.blue),
//   );
// }
