import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/widgets/Product/deails_screen.dart';
import 'package:food_met/widgets/Product/row_section.dart';

class ProductWidget extends StatelessWidget {
  final Products product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            // offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsProduct(product: product),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 140.0,
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12.0),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      height: 148.0,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/error.gif',
                          fit: BoxFit.cover,
                          height: 140.0,
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: product.nutrition
                        ? Image.asset(
                            'assets/icons/vegano.png',
                            width: 28,
                            height: 28,
                          )
                        : Image.asset(
                            'assets/icons/veg.png',
                            width: 28,
                            height: 28,
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              // 'DIPS',
              product.name,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: .5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    product.category?.name ?? "Categoría desconocida",
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 2,
              width: double.infinity,
              color: Colors.grey[200],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProductWidgets.buildShoppingButton(context, product),
                ProductWidgets.buildTimeColumn(product),
                ProductWidgets.buildCaloriesColumn(product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
