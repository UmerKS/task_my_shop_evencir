import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_my_shop_evencir/helper/app_AppTextStyle.dart';
import '../models/product.dart';
import '../providers/favorites_provider.dart';
import '../helper/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: AppTextStyle.style1.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 24.sp,
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 200.w,
              padding: EdgeInsets.all(12.sp),

              // decoration: BoxDecoration(color: AppColors.grey),
              child: Image.network(
                widget.product.images.isNotEmpty
                    ? widget.product.images[0]
                    : 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                fit: BoxFit.cover,
              ),
            ),

            // Product Details Section
            Container(
              color: AppColors.white,
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header with Favorite Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Details:',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Consumer<FavoritesProvider>(
                        builder: (context, favoritesProvider, child) {
                          final isFavorite = favoritesProvider.isFavorite(
                            widget.product.id,
                          );
                          return IconButton(
                            onPressed: () {
                              favoritesProvider.toggleFavorite(widget.product);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  isFavorite
                                      ? AppColors.red
                                      : AppColors.grey500,
                              size: 24.sp,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Product Attributes
                  _buildAttributeRow(
                    'Name:',
                    widget.product.title.toLowerCase(),
                  ),
                  _buildAttributeRow(
                    'Price:',
                    '\$${widget.product.price.toStringAsFixed(2)}',
                  ),
                  _buildAttributeRow('Category:', widget.product.category),
                  _buildAttributeRow('Brand:', widget.product.brand),
                  _buildAttributeRow('Rating:', '${widget.product.rating}'),
                  _buildRatingStars(widget.product.rating),
                  _buildAttributeRow('Stock:', '${widget.product.stock}'),

                  SizedBox(height: 30.h),

                  // Description Section
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.grey500,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Text(
                    'Product Gallery:',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Gallery Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.2,
                    ),
                    itemCount:
                        widget.product.images.length > 4
                            ? 4
                            : widget.product.images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: NetworkImage(widget.product.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16.sp, color: AppColors.grey500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          ...List.generate(5, (index) {
            return Icon(
              index < rating.floor() ? Icons.star : Icons.star_border,
              color: AppColors.yellow,
              size: 20.sp,
            );
          }),
        ],
      ),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).replaceAll('-', ' ');
  }
}
