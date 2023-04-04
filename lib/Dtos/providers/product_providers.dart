// import 'package:food_met/Dtos/Models/product_response_dto.dart';
// import 'package:http/http.dart' as http;

import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/Dtos/services/remote_services.dart';
// import 'package:food_met/Dtos/services/remote_services.dart';

import '../../Screens/index.dart';

// import 'package:logger/logger.dart'
class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Products> products = [];

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    products = await RemoteServices.fetchProducts();
    products = products.where((product) => product.status == true).toList(); // agregar filtro por estado
    debugPrint('Total products: ${products.length}');
    isLoading = false;
    notifyListeners();
  }

  List<Products> getProductsByStatus(bool status) {
    return products.where((product) => product.status == status).toList();
  }
}
