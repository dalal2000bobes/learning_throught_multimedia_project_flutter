import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Repository/QuestionRepository.dart' as repo;
import '../Model/question.dart';

class QuestionController extends GetxController {
  List<Question> questions = [];
  // int result = 0;
  double count = 0;
  Future<void> storeGrade(String id) async {
    double x = updateResult();
    int r = x.toInt();
    await repo.updateGrade(r, id);
  }

  double updateResult() {
    double r = count / questions.length;
    double result = r * 100;
    update();
    return result;
  }
}
