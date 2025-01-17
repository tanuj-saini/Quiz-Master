import 'package:get/get.dart';

class StartController extends GetxController {
  var isLoading = false.obs;

  void startQuiz() {
    Get.snackbar("Start Quiz", "Quiz is starting...");
  }
}
