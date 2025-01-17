import 'package:quiz/Models/QuestionModel.dart';
import 'package:quiz/data/Network/network_api.dart';

import 'dart:convert';

class QuizRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<QuestionModel> fetchQuizData() async {
    const url = "https://api.jsonserve.com/Uw5CrX";
    try {
      final response = await _apiServices.getApi(url);

      if (response is String) {
        final jsonResponse = jsonDecode(response) as Map<String, dynamic>;
        print(jsonResponse.toString());

        return QuestionModel.fromJson(jsonResponse);
      } else if (response is Map<String, dynamic>) {
        print(response.toString());

        return QuestionModel.fromJson(response);
      } else {
        throw Exception("Unexpected response type: ${response.runtimeType}");
      }
    } catch (e) {
      print('Error in QuizRepository: $e');
      rethrow;
    }
  }
}
