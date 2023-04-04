import 'package:food_met/Dtos/Models/cart_resonse_dto.dart';
import 'package:food_met/Dtos/services/servicio_remoto.dart';

import '../../Screens/index.dart';
import 'carrito_compras_providers.dart';

class CartProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Cart> products = [];
  Cart _cart = Cart(id: "", products: []);

  set cart(Cart newCart) {
    _cart = newCart;
    notifyListeners();
  }


  CartProvider() {
    fetchProducts();
    // fetchProductsCanapes();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    List<Cart> fetchedCart = await RemoteServices2.fetchCart();
    products =
        fetchedCart; // Asignar toda la lista de carritos a la variable `products`
    if (products.isNotEmpty) {
      _cart = products.first; // Asignar el primer carrito de la lista a `_cart`
      debugPrint('Total products: ${_cart.products.length}');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> removeItem(Product product) async {
    if (_cart.id != null) {
      final cart = CarritoDeCompras();
      cart.eliminarCarrito(_cart.id!, product.id);
      // Actualizar la lista de productos en el carrito
      _cart.products.removeWhere((p) => p.id == product.id);
      // Notificar a los widgets que están escuchando el cambio
      notifyListeners();
    }
  }
}

