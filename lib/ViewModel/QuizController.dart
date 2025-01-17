import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Models/QuestionModel.dart';
import 'package:quiz/Models/QuestionsModels.dart';
import 'package:quiz/ViewModel/Repositry/QuizRepositry.dart';

class QuizController extends GetxController {
  final QuizRepository _repository = QuizRepository();

  final _quizData = Rx<QuestionModel?>(null);
  final _currentQuestionIndex = 0.obs;
  final _score = 0.obs;
  final _isLoading = false.obs;
  final _userAnswers = RxMap<int, int>();
  final _error = Rx<String?>(null);

  QuestionModel? get quizData => _quizData.value;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get score => _score.value;
  bool get isLoading => _isLoading.value;
  String? get error => _error.value;
  int get totalQuestions => _quizData.value?.questions?.length ?? 0;
  Questions? get currentQuestion =>
      _quizData.value?.questions?[_currentQuestionIndex.value];
  bool get isLastQuestion =>
      _currentQuestionIndex.value == (totalQuestions - 1);
  Map<int, int> get userAnswers => _userAnswers;

  Future<void> loadQuizData() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final data = await _repository.fetchQuizData();

      if (data == null) {
        throw Exception('Received null quiz data');
      }

      if (data.questions == null || data.questions!.isEmpty) {
        throw Exception('Quiz has no questions');
      }

      _quizData.value = data;
      _currentQuestionIndex.value = 0;
      _score.value = 0;
      _userAnswers.clear();
    } catch (e) {
      print('Error loading quiz data: $e');
      _error.value = e.toString();

      Get.snackbar(
        'Error',
        'Failed to load quiz data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 251, 111, 101),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        isDismissible: true,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  void answerQuestion(int questionId, int optionId) {
    try {
      if (_quizData.value == null) {
        throw Exception('Quiz data is not loaded');
      }

      _userAnswers[questionId] = optionId;

      final question = _quizData.value!.questions![_currentQuestionIndex.value];
      final selectedOption = question.options!.firstWhere(
        (opt) => opt.id == optionId,
        orElse: () => throw Exception('Invalid option ID'),
      );

      final correctMarks =
          int.tryParse(_quizData.value!.correctAnswerMarks ?? '1') ?? 1;
      final negativeMarks =
          int.tryParse(_quizData.value!.negativeMarks ?? '0') ?? 0;

      if (selectedOption.isCorrect ?? false) {
        _score.value += correctMarks;
      } else {
        _score.value -= negativeMarks;
      }
    } catch (e) {
      print('Error in answerQuestion: $e');
      Get.snackbar(
        'Error',
        'Failed to process answer: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void nextQuestion() {
    if (_currentQuestionIndex.value < totalQuestions - 1) {
      _currentQuestionIndex.value++;
    }
  }

  void resetQuiz() {
    _currentQuestionIndex.value = 0;
    _score.value = 0;
    _userAnswers.clear();
    _error.value = null;
  }

  double getProgress() {
    if (totalQuestions == 0) return 0.0;
    return (_currentQuestionIndex.value + 1) / totalQuestions;
  }
}
