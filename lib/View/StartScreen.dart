import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/View/QuizScreen.dart';
import 'package:quiz/ViewModel/QuizController.dart';
import 'package:quiz/Comman/ThemeController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();
  final QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeController.isDarkMode.value
                      ? Colors.grey[900]!
                      : Colors.blue[300]!,
                  themeController.isDarkMode.value
                      ? Colors.grey[800]!
                      : Colors.blue[100]!,
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  children: [
                    _buildAppBar(),
                    Expanded(
                      child: _buildBody(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: 'quiz_title',
            child: Obx(() => Text(
                  'Quiz Master',
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black87,
                  ),
                )),
          ),
          Obx(() => AnimatedRotation(
                duration: Duration(milliseconds: 500),
                turns: themeController.isDarkMode.value ? 0.5 : 0,
                child: IconButton(
                  icon: Icon(
                    themeController.isDarkMode.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    size: 24.sp,
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black87,
                  ),
                  onPressed: () {
                    themeController.toggleTheme();
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 1000),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeController.isDarkMode.value
                      ? Colors.white.withOpacity(0.1)
                      : Get.theme.primaryColor.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.quiz,
                  size: 50.sp,
                  color: themeController.isDarkMode.value
                      ? Colors.purple
                      : Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 800),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 50 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    'Welcome to\nQuiz Master!',
                    style: GoogleFonts.poppins(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Challenge yourself with our interactive quizzes!',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: themeController.isDarkMode.value
                          ? Colors.grey[300]
                          : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 1200),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: GestureDetector(
                onTap: () async {
                  await quizController.loadQuizData();
                  Get.to(
                    () => QuizScreen(),
                    transition: Transition.zoom,
                    duration: Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeController.isDarkMode.value
                            ? Colors.purple[400]!
                            : Colors.blue,
                        themeController.isDarkMode.value
                            ? Colors.purple[300]!
                            : Colors.blueAccent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: themeController.isDarkMode.value
                            ? Colors.purple.withOpacity(0.3)
                            : Get.theme.primaryColor.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start Quiz',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
