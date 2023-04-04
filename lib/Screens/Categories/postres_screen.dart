import 'package:flutter/material.dart';
import 'package:food_met/Screens/4Postres/section_cheesecake.dart';
import 'package:food_met/Screens/4Postres/section_pasteles.dart';
import 'package:food_met/Screens/4Postres/section_pays.dart';

class PostresScreen extends StatelessWidget {
  const PostresScreen({
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
            "Postres",
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
              Tab(text: 'Pasteles'),
              Tab(text: 'Pays'),
              Tab(text: 'Cheesecake'),
            ],
          ),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                Pasteles(),
                Pays(),
                Cheesecake(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
