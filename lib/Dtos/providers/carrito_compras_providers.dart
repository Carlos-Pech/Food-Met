import 'package:flutter/material.dart';
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/Dtos/services/remote_services.dart';

class CarritoDeCompras extends ChangeNotifier {
  bool isLoading = false;
  List<Products> products = [];

  final Products product = Products(
      id: '',
      name: '',
      price: 00,
      image: '',
      category: null,
      description: '',
      inCart: false,
      ingredients: [],
      nutrition: false,
      status: null,
      subcategory: null,
      time: null,
      totalCalories: 00, 
      isDeleted: true,
      );

  final List<Products> _productosEnCarrito = [];

  List<Products> get productosEnCarrito => _productosEnCarrito;

  void agregarProductoAlCarrito(String productId) async {
    try {
      // Verificar si el producto ya está en el carrito
      bool productoYaEnCarrito =
          _productosEnCarrito.any((producto) => producto.id == productId);
      if (productoYaEnCarrito) {
        throw Exception('El producto ya está en el carrito');
      }

      // Llamar al servicio para agregar el producto al carrito en el servidor
      await RemoteServices.agregarProductoAlCarrito(productId);

      // Agregar el producto al carrito localmente
      var products = Products(
        id: product.id,
        category: product.category,
        description: product.description,
        image: product.image,
        inCart: true,
        ingredients: product.ingredients,
        name: product.name,
        nutrition: product.nutrition,
        price: product.price,
        status: product.status,
        subcategory: product.subcategory,
        time: product.time,
        totalCalories: product.totalCalories,
        isDeleted: true,
      );
      final producto = products;
      _productosEnCarrito.add(producto);

      // Notificar a los oyentes que se actualizó el carrito
      notifyListeners();
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
      debugPrint('Error al agregar producto al carrito: $e');
    }
  }

  void eliminarCarrito(String cartId, String productId) async {
    try {
      // Llamar al servicio para eliminar el carrito en el servidor
      await RemoteServices.eliminarProductoDelCarrito(cartId);

      // Eliminar todos los productos del carrito localmente
      _productosEnCarrito.clear();

      // Notificar a los oyentes que se actualizó el carrito
      notifyListeners();
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
      debugPrint('Error al eliminar carrito localmente: $e');
    }
  }
}
