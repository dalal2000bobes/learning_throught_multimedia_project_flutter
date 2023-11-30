import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:learning_throught_multimedia_project/Model/question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/RecentFile.dart';
import '../Model/option.dart';
import '../Repository/oldActionRepository.dart' as repo;

class OldActionController extends GetxController {
  bool isLoading = true;
  List<List<Question>> allQuestions = [];
  List<String> date = [];
  List<String> allEx = [];
  List<String> allAbs = [];
  List<String> allUrlS = [];
  List<String> allUrlQ = [];
  List<String> allType = [];
  List<String> allId = [];
  List<int> allGrade = [];
  List<RecentFile> all = [];

  @override
  void onInit() async {
    await getAllAction();
    print("ddddddddddddddddddddddddddddddddddd${all.length.toString()}");
    print("ssssssssssssssssssssssssssssssssss${isLoading}");
    isLoading = false;
    update();
    super.onInit();
  }

  Future<void> getAllAction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user = preferences.getString('user');
    String id = jsonDecode(user.toString())["_id"];
    var data = await repo.getAllAct(id);
    var actionData = jsonDecode(data);
    for (var element in actionData) {
      date.add(element["date"]);
      allAbs.add(element["abs"]);
      allEx.add(element["ex"]);
      allUrlS.add(element["urlSum"]);
      allUrlQ.add(element["urlExam"]);
      allType.add(element["type"]);
      date.add(element["date"]);
      allId.add(element["id"]);
      allGrade.add(element["result"]);
      List<Question> qList = [];
      for (var eq in element["q"]) {
        List<Option> p = [];
        for (var e in eq["option"]) {
          Option o = new Option(
              text: e["text"], code: e["code"], isCorrect: e["isCorrect"]);
          p.add(o);
        }
        Question q = Question(
          options: p,
          text: eq["text"],
        );
        qList.add(q);
      }
      allQuestions.add(qList);
      print(
          "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${allQuestions.length.toString()}");
      update();
    }
    for (int i = 0; i < allQuestions.length; i++) {
      all.add(RecentFile(allId[i],allQuestions[i], allGrade[i], allEx[i], allAbs[i],
          allUrlS[i], allUrlQ[i], allType[i], date[i]));
    }
    isLoading = false;
    update();
  }
}


// import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences preferences = await SharedPreferences.getInstance();
// preferences.setString('user', json.encode(value.toJson()));
// preferences.setString('userToken', value.token);

// SharedPreferences preferences = await SharedPreferences.getInstance();
// var user = preferences.getString('user');

// home:(userss.id==null)||(userss.id.isEmpty) ?WelcomePage():PageMarket(userss),