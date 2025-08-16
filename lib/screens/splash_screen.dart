import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:task_my_shop_evencir/helper/app_assets.dart';
import 'package:task_my_shop_evencir/helper/app_colors.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _setStatusBarStyle();
    _navigateToHome();
  }

            void _setStatusBarStyle() {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: AppColors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: AppColors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
            );
          }

  _navigateToHome() async {
    // Show splash for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
        backgroundColor: AppColors.white,
        extendBodyBehindAppBar: true, // Extend behind status bar
        extendBody: true, // Extend behind system UI
      body: Container(
        width: 1.sw, // Full screen width using ScreenUtil
        height: 1.sh, // Full screen height using ScreenUtil
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.splashImg),
            fit: BoxFit.cover, // This ensures full screen coverage
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
