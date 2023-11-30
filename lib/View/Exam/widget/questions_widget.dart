import 'package:flutter/material.dart';
import '../../../Controller/data/questions.dart';
import '../../../Model/option.dart';
import '../../../Model/question.dart';
import 'options_widget.dart';

class QuestionsWidget extends StatelessWidget {
  final PageController controller;
  final List<Question> questions;
  final ValueChanged<Option> onClickedOption;

  const QuestionsWidget({
    Key? key,
    required this.controller,
    required this.onClickedOption, required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
        controller: controller,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return buildQuestion(question: question);
        },
      );

  Widget buildQuestion({
    required Question question,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              question.text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'اختر الاجابة الصحيحة مما يلي :',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                  color: Colors.white),
            ),
            SizedBox(height: 32),
            Expanded(
              child: OptionsWidget(
                question: question,
                onClickedOption: onClickedOption,
              ),
            ),
          ],
        ),
      );
}
