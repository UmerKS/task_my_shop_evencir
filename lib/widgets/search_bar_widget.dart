import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helper/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
    this.prefixIcon = Icons.search,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.enabled = true,
    this.padding,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(16.w),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        enabled: enabled,
        style: TextStyle(color: textColor ?? AppColors.black, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor ?? AppColors.grey500,
            fontSize: 16.sp,
          ),
          prefixIcon:
              prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.grey500, size: 20.sp)
                  : null,
          suffixIcon:
              suffixIcon != null
                  ? GestureDetector(
                    onTap: onSuffixIconTap,
                    child: Icon(
                      suffixIcon,
                      color: AppColors.grey500,
                      size: 20.sp,
                    ),
                  )
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.grey,
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.grey,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.black,
              width: 2.w,
            ),
          ),
          filled: true,
          fillColor: fillColor ?? AppColors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}
