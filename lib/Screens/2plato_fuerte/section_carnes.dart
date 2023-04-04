import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/PlatoFuerte/carne_providers.dart';
import 'package:food_met/widgets/Product/product_container.dart';
import 'package:provider/provider.dart';

class Carnes extends StatefulWidget {
  // final Products product;
  const Carnes({Key? key}) : super(key: key);

  @override
  State<Carnes> createState() => _CarnesState();
}

class _CarnesState extends State<Carnes> {

  @override
  void initState() {
    super.initState();
    Provider.of<CarneProvider>(context, listen: false).loadPrevPage();
  }

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
    final controller = Provider.of<CarneProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     controller.isLoading ? 'Loading...' : 'Carnes',
      //     style: const TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   // title: const Text('My App'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CarneProvider>(
            builder: (context, usersProvider, child) => usersProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: usersProvider.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: itemCount,
                          childAspectRatio: 0.70,
                        ),
                        itemBuilder: (context, index) {
                          final product = usersProvider.products[index];
                          return ProductWidget(
                            product: product,
                          );
                        },
                      ),
                    ),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.loadPrevPage();
                },
                child: const Text('Anterior'),
              ),
              Text('${controller.currentPage} de ${controller.totalPages}'),
              ElevatedButton(
                onPressed: () {
                  controller.loadNextPage();
                },
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
