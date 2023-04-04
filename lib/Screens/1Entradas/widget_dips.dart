import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/Entradas/dips_providers.dart';
import 'package:food_met/widgets/Product/product_container.dart';
import 'package:provider/provider.dart';

class Dips extends StatefulWidget {
  // final Products product;
  const Dips({Key? key}) : super(key: key);

  @override
  State<Dips> createState() => _DipsState();
}

class _DipsState extends State<Dips> {

  @override
  void initState() {
    super.initState();
    Provider.of<DipsProvider>(context, listen: false).loadPrevPage();
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
    final controller = Provider.of<DipsProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<DipsProvider>(
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
