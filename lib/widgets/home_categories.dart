import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<String> _visibleCategories = [
    'entradas',
    'platoFuerte',
    'bebidas',
    'postres'
  ];

final List<Map<String, dynamic>> _categories = [
    {
      'name': 'entradas',
      'icon': Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/images/tenedor.png'),
            ),
          ),
          const SizedBox(height: 8),
          const Flexible(
            child: Text(
              'Entradas',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    },
    {
      'name': 'platoFuerte',
      'icon': Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/images/filete123.png'),
            ),
          ),
          const SizedBox(height: 8),
          const Flexible(
            child: Text(
              'Plato fuerte',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    },
    {
      'name': 'bebidas',
      'icon': Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/images/bebida10.png'),
            ),
          ),
          const SizedBox(height: 8),
          const Flexible(
            child: Text(
              'Bebidas',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    },
    {
      'name': 'postres',
      'icon': Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/images/pastel.png'),
            ),
          ),
          const SizedBox(height: 8),
          const Flexible(
            child: Text(
              'Postres',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    },
  ];


  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.filled(_visibleCategories.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8.0,
                  children: List.generate(
                    _categories.length,
                    (index) {
                      if (_visibleCategories
                          .contains(_categories[index]['name'])) {
                        final visibleIndex = _visibleCategories
                            .indexOf(_categories[index]['name']);
                        return InkWell(
                          onTap: () {
                            // Navegar a la página correspondiente a la categoría
                            Navigator.of(context).pushNamed(
                              '/${_categories[index]['name']}',
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: _selected[visibleIndex]
                                ? Colors.orange
                                : Colors.white,
                            radius: 30.0,
                            child: _categories[index][
                                'icon'], // Usar el widget de imagen como el icono
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
