import 'package:flutter/cupertino.dart';

import 'option.dart';

class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  String selectedOption = "0";

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
  });
}
