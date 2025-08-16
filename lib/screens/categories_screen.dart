import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_my_shop_evencir/helper/app_colors.dart';
import 'package:task_my_shop_evencir/widgets/search_bar_widget.dart';
import '../services/api_service.dart';
import 'products_by_category_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, String>> _categories = [];
  List<Map<String, String>> _filteredCategories = [];
  bool _isLoading = true;
  String _error = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      print('🔄 Loading categories...');
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final categories = await ApiService.getCategories();
      print('📱 Categories loaded: $categories');
      print('📱 Categories type: ${categories.runtimeType}');
      print('📱 First category: ${categories.isNotEmpty ? categories.first : "Empty"}');
      print('📱 First category type: ${categories.isNotEmpty ? categories.first.runtimeType : "N/A"}');
      
      setState(() {
        _categories = categories;
        _filteredCategories = categories;
        _isLoading = false;
      });
      print('✅ Categories state updated successfully');
    } catch (e) {
      print('❌ Error loading categories: $e');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterCategories(String query) {
    print('🔍 Filtering categories with query: "$query"');
    print('🔍 Original categories count: ${_categories.length}');
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories;
        print('🔍 No query - showing all categories: ${_filteredCategories.length}');
      } else {
        _filteredCategories =
            _categories
                .where(
                  (category) =>
                      category['name']!.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
        print('🔍 Filtered categories count: ${_filteredCategories.length}');
        print('🔍 Filtered categories: $_filteredCategories');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Search Bar
          SearchBarWidget(
            controller: _searchController,
            onChanged: _filterCategories,
            hintText: 'Search Categories...',
            prefixIcon: Icons.search,
            fillColor: AppColors.white,
          ),

          // Results Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  '${_filteredCategories.length} results found',
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

          // Categories Grid
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
                            style: TextStyle(color: AppColors.red),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: _loadCategories,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                    : _filteredCategories.isEmpty
                    ? Center(
                      child: Text(
                        'No categories found',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    )
                    : RefreshIndicator(
                      onRefresh: _loadCategories,
                      child: GridView.builder(
                        padding: EdgeInsets.all(16.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9, // Slightly taller cards
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                        ),
                        itemCount: _filteredCategories.length,
                        itemBuilder: (context, index) {
                          final category = _filteredCategories[index];
                          return _buildCategoryCard(context, category);
                        },
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, String> category) {
    final categoryName = category['name'] ?? 'Unknown';
    final categoryImage = category['image'] ?? '';
    print('🎨 Building category card for: "$categoryName" with image: $categoryImage');
    return Container(
      decoration: BoxDecoration(
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
              builder:
                  (context) => ProductsByCategoryScreen(category: categoryName),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: _getCategoryGradient(categoryName),
          ),
          child: Stack(
            children: [
              // Category Image
              if (categoryImage.isNotEmpty)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(categoryImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.transparent, AppColors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              // Category Name
              Positioned(
                bottom: 12.w,
                left: 12.w,
                child: Text(
                  _capitalizeFirstLetter(categoryName),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LinearGradient _getCategoryGradient(String category) {
    log(category);
    switch (category.toLowerCase()) {
      case 'smartphones':
        return LinearGradient(
          colors: [AppColors.blue, AppColors.blue.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'laptops':
        return LinearGradient(
          colors: [AppColors.green, AppColors.green.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'fragrances':
        return LinearGradient(
          colors: [AppColors.purple, AppColors.purple.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'skincare':
        return LinearGradient(
          colors: [AppColors.pink, AppColors.pink.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'groceries':
        return LinearGradient(
          colors: [AppColors.orange, AppColors.orange.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'home-decoration':
        return LinearGradient(
          colors: [AppColors.brown, AppColors.brown.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'furniture':
        return LinearGradient(
          colors: [AppColors.teal, AppColors.teal.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'tops':
        return LinearGradient(
          colors: [AppColors.indigo, AppColors.indigo.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'womens-dresses':
        return LinearGradient(
          colors: [AppColors.deepPurple, AppColors.deepPurple.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'womens-shoes':
        return LinearGradient(
          colors: [AppColors.red, AppColors.red.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'mens-shirts':
        return LinearGradient(
          colors: [AppColors.blueGrey, AppColors.blueGrey.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'mens-shoes':
        return LinearGradient(
          colors: [AppColors.cyan, AppColors.cyan.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'mens-watches':
        return LinearGradient(
          colors: [AppColors.amber, AppColors.amber.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'womens-watches':
        return LinearGradient(
          colors: [AppColors.lime, AppColors.lime.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'womens-bags':
        return LinearGradient(
          colors: [AppColors.deepOrange, AppColors.deepOrange.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'womens-jewellery':
        return LinearGradient(
          colors: [AppColors.yellow, AppColors.yellow.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'sunglasses':
        return LinearGradient(
          colors: [AppColors.grey, AppColors.grey.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'automotive':
        return LinearGradient(
          colors: [AppColors.redAccent, AppColors.redAccent.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'motorcycle':
        return LinearGradient(
          colors: [AppColors.orangeAccent, AppColors.orangeAccent.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'lighting':
        return LinearGradient(
          colors: [AppColors.yellowAccent, AppColors.yellowAccent.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  String _capitalizeFirstLetter(String text) {
    print('🔤 Capitalizing text: "$text" (type: ${text.runtimeType})');
    if (text.isEmpty) return text;
    final result = text[0].toUpperCase() + text.substring(1).replaceAll('-', ' ');
    print('🔤 Capitalized result: "$result"');
    return result;
  }
}
