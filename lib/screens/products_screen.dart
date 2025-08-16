import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../providers/favorites_provider.dart';
import '../helper/app_colors.dart';
import '../widgets/search_bar_widget.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String _error = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final products = await ApiService.getProducts();
      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts =
            _products
                .where(
                  (product) =>
                      product.title.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      product.category.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      product.brand.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        SearchBarWidget(
          controller: _searchController,
          onChanged: _filterProducts,
          hintText: 'Search products...',
          prefixIcon: Icons.search,
          fillColor: AppColors.white,
        ),

        // Results Count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                '${_filteredProducts.length} results found',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grey500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // Products List
        Expanded(
          child:
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error.isNotEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: $_error',
                          style: TextStyle(color: AppColors.blue),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            _loadProducts();
                            log(_error);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                  : _filteredProducts.isEmpty
                  ? Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  )
                  : RefreshIndicator(
                    onRefresh: _loadProducts,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return _buildProductCard(context, product);
                      },
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isFavorite = favoritesProvider.isFavorite(product.id);

        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: double.infinity,
                  height: 200.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.thumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Product Info
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Product Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.black,
                            ),
                          ),
                          // Price
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Rating with Stars
                      Row(
                        children: [
                          Text(
                            product.rating.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          ...List.generate(5, (index) {
                            return Icon(
                              index < product.rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: AppColors.yellow,
                              size: 16.sp,
                            );
                          }),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Brand
                      Text(
                        'By ${product.brand}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      // Category
                      Text(
                        'In ${product.category}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
