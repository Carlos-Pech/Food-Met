import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class SearchSection extends StatefulWidget {
  // final Products product;
  const SearchSection({Key? key}) : super(key: key);

  @override
  SearchSectionState createState() => SearchSectionState();
}

// ignore: camel_case_types
class SearchSectionState extends State<SearchSection> {
  final _searchController = TextEditingController();
  String? _searchResult;
  dynamic _searchResponse;
  bool _showNotFoundPopup = false;
  void _fetchSearchResult() async {
    final name = _searchController.text;
    final url = 'https://apifood-met.up.railway.app/api/product/buscar/$name';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      _searchResult = null;
      _searchResponse = jsonResponse;
      _showNotFoundPopup = false;
    } else {
      _searchResult = null;
      _searchResponse = null;
      _showNotFoundPopup = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_showNotFoundPopup) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Producto no encontrado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No se encontraron productos con ese nombre.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showNotFoundPopup = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('OK'),
              )
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5), // Cambia el color de fondo
            borderRadius:
                BorderRadius.circular(20), // Cambia el radio de los bordes
            border: Border.all(color: Colors.grey, width: 1), // Cambia el borde
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 50,
                  width: 300,
                  child: TextFormField(
                    controller: _searchController,
                    onFieldSubmitted: (_) => _fetchSearchResult(),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search here',
                      hintStyle: TextStyle(
                          color: Colors
                              .grey), // Cambia el color del texto de sugerencia
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 27,
                  color: Colors.grey,
                ),
                onPressed: _fetchSearchResult,
              ),
            ],
          ),
        ),
        if (_searchResult == 'No hay productos con ese nombre')
          Center(
            child: Text(
              'Buscador: $_searchResult',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        if (_searchResponse != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromARGB(173, 238, 238, 238),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'Resultados de la búsqueda:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchResponse.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = _searchResponse[index];
                        return Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            border: null,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 60,
                                child: Image.network(
                                  product['image'],
                                  height: 60,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      '${product['name']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${product['description']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '\$${product['price']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
