import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_throught_multimedia_project/View/Exam/Score.dart';
import '../../Controller/QuestionController.dart';
import '../../Controller/data/questions.dart';
import '../../Model/option.dart';
import '../../Model/question.dart';
import 'widget/question_numbers_widget.dart';
import 'widget/questions_widget.dart';

class CategoryPage extends StatefulWidget {
  final List<Question> questions;
  final String id;
  const CategoryPage({Key? key, required this.questions, required this.id})
      : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState(questions, id);
}

class _CategoryPageState extends State<CategoryPage> {
  late PageController controller;
  QuestionController questionController = Get.put(QuestionController());
  late Question question;
  late String id;

  _CategoryPageState(List<Question> question, this.id);

  @override
  void initState() {
    questionController.questions = widget.questions;
    super.initState();

    controller = PageController();
    question = questionController.questions.first;
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 24, 27, 55),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 24, 27, 55),
                    Colors.blue.shade900,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: QuestionNumbersWidget(
                  questions: questionController.questions,
                  question: question,
                  onClickedNumber: (index) => nextQuestion(index, true),
                ),
              ),
            ),
          ),
          body: QuestionsWidget(
            controller: controller,
            onClickedOption: (option) {
              if (question.isLocked) {
                return;
              } else {
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option.code;
                  if (option.isCorrect) {
                    questionController.count += 1;
                  }
                  final nextPage = controller.page! + 1;
                  print(nextPage);
                  if (nextPage.toInt() < questionController.questions.length) {
                    setState(() {
                      question = questionController.questions[nextPage.toInt()];
                    });
                    Future.delayed(Duration(seconds: 2), () {
                      controller.jumpToPage(nextPage.toInt());
                    });
                  } else if (nextPage == questionController.questions.length) {
                    Future.delayed(Duration(seconds: 2), () async {
                      // await questionController.updateResult();
                      print("ddddddddddddddddddddddddddd$id");
                      print(
                          "ddddddddddddddddddddddddddd${questionController.updateResult()}");
                      await questionController.storeGrade(id);
                      Get.off(ScoreScreen(
                        result: questionController.updateResult(),
                      ));
                    });
                  }
                });
              }
            },
            questions: questionController.questions,
          ),
        ),
      );

  void nextQuestion(int index, bool jump) {
    final nextPage = controller.page! + 1;
    int indexPage = index;
    print(nextPage);
    print(indexPage);
    print(index);
    setState(() {
      question = questionController.questions[indexPage];
    });

    if (jump) {
      controller.jumpToPage(indexPage);
    }
  }
}
