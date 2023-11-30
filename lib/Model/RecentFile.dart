import 'package:learning_throught_multimedia_project/Model/question.dart';

class RecentFile {
  final String? type, date, ex, abs, urls, urle,id;
  int? grade;
  final List<Question>? question;

  RecentFile(this.id,this.question, this.grade, this.ex, this.abs, this.urls, this.urle,
      this.type, this.date);
}
