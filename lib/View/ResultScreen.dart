import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/View/StartScreen.dart';
import 'package:quiz/ViewModel/QuizController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  final QuizController controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Get.isDarkMode ? Colors.grey[900]! : Colors.blue[100]!,
              Get.isDarkMode ? Colors.grey[800]! : Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, -50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          children: [
            Text(
              'Results',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: [
            _buildCelebrationIcon(),
            _buildScoreCard(),
            _buildStatsCard(),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCelebrationIcon() {
    return TweenAnimationBuilder(
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
          color: Get.theme.primaryColor.withOpacity(0.1),
        ),
        child: Icon(
          Icons.celebration,
          size: 50.sp,
          color: Get.theme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1200),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3.h),
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Get.theme.shadowColor.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Congratulations! 🎉',
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Obx(() {
              final scorePercentage =
                  (controller.score / controller.totalQuestions) * 100;
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: scorePercentage),
                duration: Duration(milliseconds: 1500),
                builder: (context, double value, _) {
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 15.h,
                            width: 15.h,
                            child: CircularProgressIndicator(
                              value: value / 100,
                              strokeWidth: 12,
                              backgroundColor:
                                  Get.theme.primaryColor.withOpacity(0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Get.theme.primaryColor),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${value.round()}%',
                                style: GoogleFonts.poppins(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              Text(
                                'Score',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1400),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Get.theme.shadowColor.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildStatRow(
              icon: Icons.check_circle_outline,
              label: 'Correct Answers',
              value: '${controller.score}',
            ),
            Divider(height: 3.h),
            _buildStatRow(
              icon: Icons.assignment_turned_in,
              label: 'Total Questions',
              value: '${controller.totalQuestions}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Get.theme.primaryColor,
          size: 24.sp,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1600),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: ElevatedButton(
          onPressed: () {
            controller.resetQuiz();
            Get.offAll(
              () => StartScreen(),
              transition: Transition.fadeIn,
              duration: Duration(milliseconds: 500),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 2.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.replay, size: 20.sp),
              SizedBox(width: 2.w),
              Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/View/StartScreen.dart';
// import 'package:quiz/ViewModel/QuizController.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class ResultScreen extends StatelessWidget {
//   final QuizController controller = Get.find<QuizController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       : (
//         title: Text(
//           'Quiz Results',
//           style: TextStyle(fontSize: 20.sp),
//         ),
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20.sp),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.celebration,
//                 size: 35.sp,
//                 color: Get.theme.primaryColor,
//               ),
//               SizedBox(height: 3.h),
//               Text(
//                 'Quiz Completed!',
//                 style: TextStyle(
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 2.h),
//               Obx(() => Text(
//                     'Your Score: ${controller.score}',
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       color: Get.theme.primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )),
//               SizedBox(height: 2.h),
//               Text(
//                 'Questions Completed: ${controller.totalQuestions}/${controller.totalQuestions}',
//                 style: TextStyle(fontSize: 16.sp),
//               ),
//               SizedBox(height: 5.h),
//               ElevatedButton(
//                 onPressed: () {
//                   controller.resetQuiz();
//                   Get.offAll(() => StartScreen());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 8.w,
//                     vertical: 2.h,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Text(
//                   'Try Again',
//                   style: TextStyle(fontSize: 18.sp),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }