import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_my_shop_evencir/helper/app_colors.dart';
import 'package:task_my_shop_evencir/widgets/search_bar_widget.dart';
import '../models/product.dart';
import '../providers/favorites_provider.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredFavorites = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterFavorites('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFavorites(String query) {
    final favoritesProvider = Provider.of<FavoritesProvider>(
      context,
      listen: false,
    );
    final favorites = favoritesProvider.favoriteProductsList;

    setState(() {
      if (query.isEmpty) {
        _filteredFavorites = favorites;
      } else {
        _filteredFavorites =
            favorites
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
          onChanged: _filterFavorites,

          hintText: 'Search Favorites...',
          prefixIcon: Icons.search,
          fillColor: AppColors.white,
        ),

        // Favorites List
        Expanded(
          child: Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final favorites = favoritesProvider.favoriteProductsList;

              if (favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80.sp,
                        color: AppColors.grey500,
                      ),
                       SizedBox(height: 16.h),
                      Text(
                        'No favorites yet',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey900,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Start adding products to your favorites!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.grey500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              if (_filteredFavorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: AppColors.grey500,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No favorites found',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.grey900,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Try adjusting your search terms',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: _filteredFavorites.length,
                itemBuilder: (context, index) {
                  final product = _filteredFavorites[index];
                  return _buildFavoriteCard(
                    context,
                    product,
                    favoritesProvider,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteCard(
    BuildContext context,
    Product product,
    FavoritesProvider favoritesProvider,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 3,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Product Image
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(product.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      product.brand,
                                              style: TextStyle(color: AppColors.grey900, fontSize: 14.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _capitalizeFirstLetter(product.category),
                                              style: TextStyle(color: AppColors.grey500, fontSize: 12.sp),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                                                  style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: AppColors.blue,
                        ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16.sp, color: AppColors.yellow),
                                                          SizedBox(width: 4.w),
                            Text(
                              product.rating.toString(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Remove from Favorites Button
              IconButton(
                onPressed: () {
                  favoritesProvider.removeFavorite(product.id);
                  _filterFavorites(_searchController.text);
                },
                icon: Icon(Icons.favorite, color: AppColors.red, size: 24.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).replaceAll('-', ' ');
  }
}
