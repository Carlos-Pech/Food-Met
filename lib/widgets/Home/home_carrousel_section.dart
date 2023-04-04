import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_met/Dtos/providers/PlatoFuerte/carne_providers.dart';
import 'package:food_met/Dtos/providers/product_providers.dart';
import 'package:food_met/widgets/Product/deails_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CarrouselSection extends StatelessWidget {
  List<String> localImgList = [
    "assets/images/cocina.jpg",
    "assets/images/proteinas.jpg",
    "assets/images/dos.jpg"
  ];

  CarrouselSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        if (productProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (productProvider.products.isEmpty) {
          return Center(
              child: Column(
            children: [
              CarouselSlider(
                  items: localImgList
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  e,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    height: 180,
                  ))
            ],
          ));
        } else {
          return Column(
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              CarouselSlider(
                items: productProvider.products
                    .map((product) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsProduct(product: product),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                  height: 148.0,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      'assets/images/error.gif',
                                      fit: BoxFit.cover,
                                      height: 140.0,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  height: 180,
                ),
              )
            ],
          );
        }
      },
    );
  }
}
