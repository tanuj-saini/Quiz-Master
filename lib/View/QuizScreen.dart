import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Models/OPtionModel.dart';
import 'package:quiz/View/ResultScreen.dart';
import 'package:quiz/ViewModel/QuizController.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatelessWidget {
  final QuizController controller = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Get.isDarkMode ? Colors.grey[900]! : Colors.blue[50]!,
              Get.isDarkMode ? Colors.grey[800]! : Colors.white,
            ],
          ),
        ),
        child: Obx(() {
          if (controller.isLoading) {
            return Center(
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Get.theme.primaryColor,
                      ),
                    ),
                  );
                },
              ),
            );
          }

          if (controller.quizData == null) {
            return _buildErrorState();
          }

          return SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                _buildProgressBar(),
                _buildQuestionCard(),
                _buildNavigationButton(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: 'quiz_title',
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          Text(
            'Quiz in Progress',
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 40.sp), // To balance the close button
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: TweenAnimationBuilder(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 40.sp,
              color: Colors.red,
            ),
            SizedBox(height: 2.h),
            Text(
              'Failed to load quiz',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ElevatedButton.icon(
              onPressed: controller.loadQuizData,
              icon: Icon(Icons.refresh),
              label: Text(
                'Retry',
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 1.5.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Get.theme.primaryColor,
                ),
              ),
              Obx(() => Text(
                    '${((controller.getProgress() * 100).round())}%',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.primaryColor,
                    ),
                  )),
            ],
          ),
          SizedBox(height: 1.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Obx(() => TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: controller.getProgress()),
                  duration: Duration(milliseconds: 500),
                  builder: (context, double value, _) {
                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: Get.theme.primaryColor.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Get.theme.primaryColor,
                      ),
                      minHeight: 0.8.h,
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.sp),
        child: Obx(() {
          final question = controller.currentQuestion;
          if (question == null) return SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${controller.currentQuestionIndex + 1}',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Get.theme.primaryColor,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                question.description ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                '(Select all that apply)',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 3.h),
              ...question.options?.asMap().entries.map(
                        (entry) => _buildOptionCard(
                          question.id!,
                          entry.value,
                          entry.key,
                        ),
                      ) ??
                  [],
            ],
          );
        }),
      ),
    );
  }

  Widget _buildOptionCard(int questionId, Options option, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 200 + (index * 100)),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(100 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.5.h),
        child: Obx(() {
          final isSelected =
              controller.isOptionSelected(questionId, option.id!);

          return GestureDetector(
            onTap: () => controller.answerQuestion(questionId, option.id!),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isSelected
                    ? Get.theme.primaryColor.withOpacity(0.15)
                    : Get.theme.cardColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color:
                      isSelected ? Get.theme.primaryColor : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Get.theme.shadowColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.sp),
              child: Row(
                children: [
                  Container(
                    width: 24.sp,
                    height: 24.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected
                            ? Get.theme.primaryColor
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                      color: isSelected
                          ? Get.theme.primaryColor
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 16.sp,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      option.description ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNavigationButton() {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Obx(() {
        final currentQuestionId = controller.currentQuestion?.id;
        final hasAnswered = currentQuestionId != null &&
            controller.userAnswers.containsKey(currentQuestionId) &&
            controller.userAnswers[currentQuestionId]!.isNotEmpty;

        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: hasAnswered ? 1 : 0.5),
          duration: Duration(milliseconds: 300),
          builder: (context, double value, child) {
            return Transform.scale(
              scale: 0.95 + (0.05 * value),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: ElevatedButton(
            onPressed: hasAnswered
                ? () {
                    if (controller.isLastQuestion) {
                      controller.submitAnswer();
                      Get.to(
                        () => ResultScreen(),
                        transition: Transition.fadeIn,
                        duration: Duration(milliseconds: 500),
                      );
                    } else {
                      controller.nextQuestion();
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100.w, 6.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: hasAnswered ? 4 : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.isLastQuestion ? 'Finish Quiz' : 'Next Question',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 2.w),
                Icon(
                  controller.isLastQuestion
                      ? Icons.done_all
                      : Icons.arrow_forward,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
