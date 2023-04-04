
import 'package:food_met/Dtos/Models/product_response_dto.dart';
import 'package:food_met/Dtos/services/remote_services.dart';
import '../../../Screens/index.dart';


class CheesecakeProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Products> _allProducts = [];
  List<Products> _currentPageProducts = [];
  int _currentPage = 1;
  int _pageSize = 10;
  List<Products> products = [];
  // ignore: prefer_typing_uninitialized_variables
  var canLoadPrevPage;
  int get currentPage => _currentPage;

  int get totalPages => (_allProducts.length / _pageSize).ceil();

  CheesecakeProvider() {
    fetchProducts();
    // fetchProductsCanapes();
  }

  get productsPerPage => null;

  get totalProducts => null;


  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

        try {
      final response = await RemoteServices.fetchProductsCheesecake(
        page: _currentPage,
        limit: _pageSize,
      );

      if (response.length > 0) {
        if (_currentPage == 1) {
          _allProducts = response;
        } else {
          _allProducts.addAll(response);
        }
        _currentPageProducts = response;
        if (response.length < _pageSize) {
          // No hay más productos para cargar
          _pageSize = _allProducts.length;
        }
      }
    } catch (error) {
      // Manejar errores carne
    }

    isLoading = false;
    notifyListeners();
  }

  List<Products> get currentPageProducts => _currentPageProducts;

  bool get canLoadMore => _allProducts.length % _pageSize == 0;

  Future<void> loadMore(int nextPage) async {
    if (canLoadMore) {
      _currentPage = nextPage;

      final response = await RemoteServices.fetchProductsCheesecake(
        page: _currentPage,
        limit: _pageSize,
      );
      if (response.isNotEmpty) {
        _allProducts.addAll(response);
        _currentPageProducts = response;
        if (response.length < _pageSize) {
          // No hay más productos para mariscos
          _pageSize = _allProducts.length;
        }
      } else {
        _currentPage = _currentPage - 1;
      }
    }
  }

  Future<void> loadNextPage() async {
    final nextPage = _currentPage + 1;
    if (nextPage <= totalProducts ~/ _pageSize + 1) {
      await loadMore(nextPage);
    }
  }

  Future<void> loadPrevPage() async {
    final prevPage = _currentPage - 1;
    if (prevPage >= 1) {
      await loadMore(prevPage);
    }

    List<Products> allProducts = await RemoteServices.fetchProductsCheesecake(page: 1, limit: 10);
    products = allProducts
        .where((product) =>
            product.category?.name == "Plato fuerte" &&
            product.subcategory?.name == "Cheesecake")
        .toList();

    debugPrint('Total products: ${products.length}');
    isLoading = false;
    notifyListeners();
  }
}
