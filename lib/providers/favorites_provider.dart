import 'package:flutter/foundation.dart';
import '../models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final Set<int> _favoriteIds = {};
  final Map<int, Product> _favoriteProducts = {};

  Set<int> get favoriteIds => _favoriteIds;
  Map<int, Product> get favoriteProducts => _favoriteProducts;
  List<Product> get favoriteProductsList => _favoriteProducts.values.toList();

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }

  void toggleFavorite(Product product) {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
      _favoriteProducts.remove(product.id);
    } else {
      _favoriteIds.add(product.id);
      _favoriteProducts[product.id] = product;
    }
    notifyListeners();
  }

  void removeFavorite(int productId) {
    _favoriteIds.remove(productId);
    _favoriteProducts.remove(productId);
    notifyListeners();
  }

  void clearFavorites() {
    _favoriteIds.clear();
    _favoriteProducts.clear();
    notifyListeners();
  }
} 