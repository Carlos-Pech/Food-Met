import 'package:http/http.dart' as http;
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import '../../Screens/index.dart';
import 'api_url.dart';

class RemoteServices {
  static Future<List<Products>> fetchData(
    String url, {
    Map<String, String>? queryParams,
  }) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic>) {
        final List<dynamic> data = responseData['docs'] ?? [];
        // debugPrint(response.body);

        //Para mostrar los datos con logger
        // Crear una instancia de Logger
        var logger = Logger();
        // Imprimir los datos de respuesta usando el logger
        logger.d(responseData);

        return data.map((item) => Products.fromJson(item)).toList();
      } else {
        throw Exception('Invalid response data type');
      }
    } else {
      throw Exception('Failed to load products');
    } // Agregar declaración de retorno aquí
  }

  //Home
  static Future<List<Products>> fetchProducts() async {
    var endpoint = ApiEndpoints.products;
    return fetchData(baseUrl + endpoint);
  }

  //Entradas
  static Future<List<Products>> fetchProductsDips(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.dips}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsCanapes(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.canapes}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsEnsaladas(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.ensaladas}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsSopas(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.sopas}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  //Plato fuerte
  static Future<List<Products>> fetchProductsCarne(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.carne}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsPasta(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.pastas}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsMariscos(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.mariscos}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  //Bebidas
  static Future<List<Products>> fetchProductsVinos(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.vinos}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsCocteles(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.cocteles}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  //Postres
  static Future<List<Products>> fetchProductsPasteles(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.pasteles}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsPays(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.pays}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  static Future<List<Products>> fetchProductsCheesecake(
      {required int page, required int limit}) async {
    var endpoint = '${ApiEndpoints.cheesecake}?page=$page&limit=$limit';
    return fetchData(baseUrl + endpoint);
  }

  //Actualizar los datos
  static Future<void> actualizarValorEnBaseDeDatos(
    String productId,
    bool nuevoValor,
  ) async {
    final Map<String, dynamic> body = {
      'inCart': nuevoValor,
    };
    try {
      final response = await http.put(
        Uri.parse('https://apifood-met.up.railway.app/api/product/$productId'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        debugPrint('Valor actualizado en la base de datos');
        debugPrint(productId);
        // El valor se actualizó correctamente en la base de datos del servidor
      } else {
        // Ocurrió un error al actualizar el valor en la base de datos del servidor
        throw Exception(
            'Error al actualizar valor en la base de datos: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
      debugPrint('Error al actualizar valor en la base de datos: $e');
    }
  }

  //agregar al carrito de compras
  static Future<void> agregarProductoAlCarrito(String productId) async {
    // Verificar si el producto existe
    try {
      final response = await http.get(
        Uri.parse(
          'https://apifood-met.up.railway.app/api/product/find/$productId',
        ),
      );
      if (response.statusCode == 200) {
        // El producto existe, se puede agregar al carrito
        debugPrint('El producto existe');

        final Map<String, dynamic> body = {
          'productoId': productId,
        };

        try {
          final response = await http.post(
            Uri.parse(
                'https://apifood-met.up.railway.app/api/cart/$productId/agregar-producto'),
            body: json.encode(body),
            headers: {'Content-Type': 'application/json'},
          );
          if (response.statusCode == 200) {
            debugPrint("producto agregado");
            // El producto se agregó correctamente al carrito en la base de datos del servidor
            // Aquí puedes hacer algo con la respuesta del servidor si lo deseas
          } else {
            // Ocurrió un error al agregar el producto al carrito en la base de datos del servidor
            throw Exception(
                'Error al agregar producto al carrito en el servidor: ${response.statusCode}\n${response.body}');
          }
        } catch (e) {
          // Manejar cualquier error que pueda ocurrir
          debugPrint(
              'Error al agregar producto al carrito en el servidor15: $e');
        }
      } else if (response.statusCode == 404) {
        // El producto no existe
        debugPrint('El producto no existe');
      } else {
        // Ocurrió un error en la petición GET
        throw Exception(
            'Error al obtener producto del servidor1597: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
      debugPrint('Error al verificar si el producto existe: $e');
    }
  }

  static Future<void> eliminarProductoDelCarrito(String cartId) async {
    // Verificar si el carrito existe
    try {
      final response = await http.get(
        Uri.parse(
          'https://apifood-met.up.railway.app/api/cart/find/$cartId',
        ),
      );
      if (response.statusCode == 200) {
        // El carrito existe, se puede eliminar el producto
        debugPrint('El carrito existe');

        try {
          final response = await http.delete(
            Uri.parse(
                'https://apifood-met.up.railway.app/api/cart/cart/$cartId/'),
            headers: {'Content-Type': 'application/json'},
          );
          if (response.statusCode == 200) {
            debugPrint("producto eliminado");
            // El producto se eliminó correctamente del carrito en la base de datos del servidor
            // Aquí puedes hacer algo con la respuesta del servidor si lo deseas
          } else {
            // Ocurrió un error al eliminar el producto del carrito en la base de datos del servidor
            throw Exception(
                'Error al eliminar producto del carrito en el servidor: ${response.statusCode}\n${response.body}');
          }
        } catch (e) {
          // Manejar cualquier error que pueda ocurrir
          debugPrint(
              'Error al eliminar producto del carrito en el servidor: $e');
        }
      } else if (response.statusCode == 404) {
        // El carrito no existe
        debugPrint('El carrito no existe');
      } else {
        // Ocurrió un error en la petición GET
        throw Exception(
            'Error al obtener carrito del servidor: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
      debugPrint('Error al verificar si el carrito existe: $e');
    }
  }

  static Future<void> clearCart() async {
    try {
      final response = await http.delete(Uri.parse('${baseUrl}api/cart/cart'));
      if (response.statusCode != 200) {
        throw Exception('Failed to clear cart.');
      }
      print('Cart cleared successfully.');
    } catch (e) {
      print('Error clearing cart: $e');
      throw Exception('Failed to clear cart.');
    }
  }
}

class ApiEndpoints {
  static const products = 'api/product/';
  // static const productsCanapes = 'api/product/';
  //Entradas
  static const dips = 'api/product/subcategory/63e842578e88abbc8117f199';
  static const canapes = 'api/product/subcategory/63e84dc38e88abbc8117f19b';
  static const ensaladas = 'api/product/subcategory/63e84dd08e88abbc8117f19d';
  static const sopas = 'api/product/subcategory/63e84dda8e88abbc8117f19f';
  //plato fuerte
  static const carne = 'api/product/subcategory/63e84e3f8e88abbc8117f1a7';
  static const pastas = 'api/product/subcategory/63e84e448e88abbc8117f1a9';
  static const mariscos = 'api/product/subcategory/63e84e4b8e88abbc8117f1ab';
  // bebidas
  static const vinos = 'api/product/subcategory/63e84e638e88abbc8117f1ad';
  static const cocteles = 'api/product/subcategory/63e84e6b8e88abbc8117f1af';
  //postres
  static const pasteles = 'api/product/subcategory/63e84e078e88abbc8117f1a1';
  static const pays = 'api/product/subcategory/63e84e0c8e88abbc8117f1a3';
  static const cheesecake = 'api/product/subcategory/63e84e248e88abbc8117f1a5';
  static const carrito = 'api/cart/cart';
}
