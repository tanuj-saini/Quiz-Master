import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/View/StartScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Get.off(
        () => StartScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 800),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Get.isDarkMode ? Colors.grey[900]! : Colors.blue[300]!,
              Get.isDarkMode ? Colors.grey[800]! : Colors.blue[100]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      padding: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.quiz,
                        size: 60.sp,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 4.h),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Text(
                      'Quiz Master',
                      style: GoogleFonts.poppins(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Test Your Knowledge',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Get.isDarkMode
                            ? Colors.grey[300]
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 40.w,
                  child: LinearProgressIndicator(
                    backgroundColor: Get.theme.primaryColor.withOpacity(0.2),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
                    minHeight: 0.5.h,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
