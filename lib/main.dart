import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/Bebidas/cocteles_provider.dart';
import 'package:food_met/Dtos/providers/Bebidas/vinos_provider.dart';
import 'package:food_met/Dtos/providers/Entradas/dips_providers.dart';
import 'package:food_met/Dtos/providers/Entradas/ensaladas_providers.dart';
import 'package:food_met/Dtos/providers/Entradas/sopas_providers.dart';
import 'package:food_met/Dtos/providers/PlatoFuerte/carne_providers.dart';
import 'package:food_met/Dtos/providers/PlatoFuerte/mariscos_providers.dart';
import 'package:food_met/Dtos/providers/PlatoFuerte/pasta_providers.dart';
import 'package:food_met/Dtos/providers/Postres/chescake_provider.dart';
import 'package:food_met/Dtos/providers/Postres/pasteles_provider.dart';
import 'package:food_met/Dtos/providers/Postres/pays_provider.dart';
import 'package:food_met/Dtos/providers/cart2_providers.dart';
import 'package:food_met/Screens/Categories/entradas_screen.dart';
import 'package:food_met/Screens/alert404_page.dart';
import 'package:food_met/Screens/Categories/bebidas_screen.dart';
import 'package:food_met/Screens/home_screen.dart';
import 'package:food_met/Screens/Categories/plato_fuerte_screen.dart';
import 'package:food_met/Screens/Categories/postres_screen.dart';
import 'package:food_met/Screens/splash.dart';
// import 'package:food_met/widgets/cart.dart';
import 'package:provider/provider.dart';
import 'Dtos/providers/Entradas/canapes_provider.dart';
import 'Dtos/providers/product_providers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Entradas
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => DipsProvider()),
        ChangeNotifierProvider(create: (_) => CanapesProvider()),
        ChangeNotifierProvider(create: (_) => EnsaladasProvider()),
        ChangeNotifierProvider(create: (_) => SopasProvider()),
        //Plato fuerte,
        ChangeNotifierProvider(create: (_) => CarneProvider()),
        ChangeNotifierProvider(create: (_) => PastasProvider()),
        ChangeNotifierProvider(create: (_) => MariscosProvider()),
        //Postres
        ChangeNotifierProvider(create: (_) => PastelesProvider()),
        ChangeNotifierProvider(create: (_) => PaysProvider()),
        ChangeNotifierProvider(create: (_) => CheesecakeProvider()),
        //Bebidas,
        ChangeNotifierProvider(create: (_) => VinosProvider()),
        ChangeNotifierProvider(create: (_) => CoctelesProvider()),

        //Carrito,
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // home: SplashScreen(),
        title: 'FoodMet',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/entradas': (context) => const EntradasScreen(),
          '/platoFuerte': (context) => const PlatoFuerteScreen(),

          '/bebidas': (context) => const BebidasScreen(),
          '/postres': (context) => const PostresScreen(),
          // '/items': (context) => const Products(),
          // '/products': (context) => const ListsProductPage(),
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const ErrorPage(),
          );
        },
      ),
    );
  }
}
