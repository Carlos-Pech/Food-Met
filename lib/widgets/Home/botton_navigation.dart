import 'package:flutter/material.dart';
import 'package:food_met/Screens/home_screen.dart';
import 'package:food_met/Screens/list_cart_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required IconThemeData selectedIconTheme,
      required TextStyle selectedLabelStyle});

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> menuItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
    ];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: menuItems,
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
    ],
    selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  );
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
