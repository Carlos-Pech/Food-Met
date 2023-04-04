import 'package:flutter/material.dart';
import 'package:food_met/Screens/2plato_fuerte/section_carnes.dart';
import 'package:food_met/Screens/2plato_fuerte/section_mariscos.dart';
import 'package:food_met/Screens/2plato_fuerte/section_pastas.dart';

class PlatoFuerteScreen extends StatelessWidget {
  const PlatoFuerteScreen({
    super.key,
  });

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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Plato fuerte",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Carnes'),
              Tab(text: 'Pastas'),
              Tab(text: 'Mariscos'),
            ],
          ),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                Carnes(),
                Pastas(),
                Mariscos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
