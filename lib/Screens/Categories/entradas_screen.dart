import 'package:flutter/material.dart';
import 'package:food_met/Screens/1Entradas/section_ensaladas.dart';
import 'package:food_met/Screens/1Entradas/section_sopas.dart';
import 'package:food_met/Screens/1Entradas/widget_canapes.dart';
import 'package:food_met/Screens/1Entradas/widget_dips.dart';

class EntradasScreen extends StatelessWidget {
  const EntradasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Size size = MediaQuery.of(context).size;

    double space = size.width;

    if (orientation == Orientation.landscape) {}

    if (space > 800.0) {}

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Entradas",
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
              Tab(text: 'Dips'),
              Tab(text: 'Canapes'),
              Tab(text: 'Ensaladas'),
              Tab(text: 'Sopas'),
            ],
          ),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                Dips(), // Screen for category Dips,
                Canapes(),
                Ensaladas(),
                Sopas()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
