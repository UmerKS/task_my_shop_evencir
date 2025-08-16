import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  // Get all products
  static Future<List<Product>> getProducts({int limit = 100}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?limit=$limit'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get single product by ID
  static Future<Product> getProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> productJson = json.decode(response.body);
        return Product.fromJson(productJson);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get all categories with name and image
  static Future<List<Map<String, String>>> getCategories() async {
    try {
      print('🔍 Fetching categories from API...');
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories'),
      );

      print('📡 API Response Status: ${response.statusCode}');
      print('📄 API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = json.decode(response.body);
        print('📋 Raw Categories JSON: $categoriesJson');

        // Extract category names and images properly
        final List<Map<String, String>> categories =
            categoriesJson.map<Map<String, String>>((category) {
              if (category is String) {
                print('✅ Category (String): $category');
                return {
                  'name': category,
                  'image': _getCategoryImage(
                    category,
                  ), // Generate image for string category
                };
              } else if (category is Map<String, dynamic>) {
                final name =
                    category['name'] ?? category['slug'] ?? category.toString();
                final image =
                    category['img'] ??
                    category['image'] ??
                    _getCategoryImage(name);
                print('✅ Category (Map): $name with image: $image');
                return {'name': name, 'image': image};
              } else {
                print('✅ Category (Other): ${category.toString()}');
                return {
                  'name': category.toString(),
                  'image': _getCategoryImage(category.toString()),
                };
              }
            }).toList();

        print('🎯 Final Categories List: $categories');
        return categories;
      } else {
        print('❌ API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('💥 Exception in getCategories: $e');
      throw Exception('Error: $e');
    }
  }

  // Helper method to generate category images
  static String _getCategoryImage(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'smartphones':
        return 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&h=300&fit=crop';
      case 'laptops':
        return 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400&h=300&fit=crop';
      case 'fragrances':
        return 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400&h=300&fit=crop';
      case 'skincare':
        return 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400&h=300&fit=crop';
      case 'groceries':
        return 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop';
      case 'home-decoration':
        return 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop';
      case 'furniture':
        return 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&h=300&fit=crop';
      case 'tops':
        return 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400&h=300&fit=crop';
      case 'womens-dresses':
        return 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400&h=300&fit=crop';
      case 'womens-shoes':
        return 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=400&h=300&fit=crop';
      case 'mens-shirts':
        return 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=300&fit=crop';
      case 'mens-shoes':
        return 'https://images.unsplash.com/photo-1549298916-b41d114d2c36?w=400&h=300&fit=crop';
      case 'mens-watches':
        return 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400&h=300&fit=crop';
      case 'womens-watches':
        return 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400&h=300&fit=crop';
      case 'womens-bags':
        return 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop';
      case 'womens-jewellery':
        return 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce3b7?w=400&h=300&fit=crop';
      case 'sunglasses':
        return 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400&h=300&fit=crop';
      case 'automotive':
        return 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=400&h=300&fit=crop';
      case 'motorcycle':
        return 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop';
      case 'lighting':
        return 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400&h=300&fit=crop';
      default:
        return 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&h=300&fit=crop';
    }
  }

  // Get products by category
  static Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
