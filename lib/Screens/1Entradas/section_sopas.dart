import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/Dtos/providers/Entradas/sopas_providers.dart';
import 'package:food_met/widgets/Product/product_container.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Sopas extends StatefulWidget {
  // final Products product;
  const Sopas({Key? key}) : super(key: key);

  @override
  State<Sopas> createState() => _SopasState();
}

class _SopasState extends State<Sopas> {

  @override
  void initState() {
    super.initState();
    Provider.of<SopasProvider>(context, listen: false).loadPrevPage();
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
    final controller = Provider.of<SopasProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     controller.isLoading ? 'Loading...' : 'Sopas',
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
          Consumer<SopasProvider>(
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
