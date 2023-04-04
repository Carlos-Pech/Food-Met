import 'package:food_met/Dtos/Models/cart_resonse_dto.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'api_url.dart';

class RemoteServices2 {
  static Future<List<Cart>> fetchData(
  String url, {
  Map<String, String>? queryParams,
}) async {
  // Agregar parámetros de consulta a la URL
  url += "?sort=createdAt:-1&page=1&limit=4";

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    dynamic responseData = json.decode(response.body);
    if (responseData is Map<String, dynamic>) {
      final List<dynamic> data = responseData['docs'] ?? [];

      // Para mostrar los datos con logger
      // Crear una instancia de Logger
      var logger = Logger();
      // Imprimir los datos de respuesta usando el logger
      logger.d(responseData);

      return data.map((item) => Cart.fromJson(item)).toList();
    } else {
      throw Exception('Invalid response data type');
    }
  } else {
    throw Exception('Failed to load products');
  } // Agregar declaración de retorno aquí
}


  

  static Future<List<Cart>> fetchCart() async {
    var endpoint = ApiEndpoints.carrito;
    return fetchData(baseUrl + endpoint);
  }
}

class ApiEndpoints {
  static const products = 'api/product/';
  // static const productsCanapes = 'api/product/';
  static const carrito = 'api/cart/cart';
 
}
