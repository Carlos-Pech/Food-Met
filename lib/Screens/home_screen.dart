import 'package:flutter/material.dart';
import 'package:food_met/widgets/Home/botton_navigation.dart';
import 'package:food_met/widgets/home_categories.dart';
import '../widgets/Home/home_app_bar.dart';
import '../widgets/Home/home_carrousel_section.dart';
import '../widgets/home_categorie_section.dart';
import '../widgets/home_search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const HomeAppBar(),
          const Padding(
            padding: EdgeInsets.all(19),
            child: SearchSection(),
          ),

          CarrouselSection(),

          const CategoriesText(),

          const Padding(
            padding: EdgeInsets.only(bottom: 19),
            child: CategoriesWidget(),
          ),

          const Recomendaciones(),

          const Categories(),
          // const ProductHome()
        ],
      ),
      bottomNavigationBar: Boton(context, _currentIndex),
    );
  }
}

class CategoriesText extends StatelessWidget {
  const CategoriesText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 25, top: 20),
      child: Text(
        "Categorias",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class Recomendaciones extends StatelessWidget {
  const Recomendaciones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        "Lo más nuevo",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
