import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:learning_throught_multimedia_project/Model/option.dart';
import 'package:learning_throught_multimedia_project/Model/question.dart';
import '../Repository/SummerizationRepository.dart' as repo;

class SumController extends GetxController {
  String idAction = "";
  String content = "";
  String resultEx = "";
  String linkQ = "";
  String linkS = "";
  String resultAbs = "";
  List<Question> questions = [];
  TextEditingController text = new TextEditingController();
  bool isLoading = false;
  void updateText(value) {
    content = value;
    if (content != "") {
      isLoading = true;
      update();
    } else if (content == "") {
      isLoading = false;
      update();
    }
    update();
  }

  Future updateSum() async {
    update();
    var value = await repo.getSum(content);
    resultAbs = jsonDecode(value)["abs"];
    resultEx = jsonDecode(value)["ex"];
    for (var element in jsonDecode(value)["q"]) {
      List<Option> p = [];
      for (var e in element["option"]) {
        Option o = new Option(
            text: e["text"], code: e["code"], isCorrect: e["isCorrect"]);
        p.add(o);
      }
      Question q = Question(
        options: p,
        text: element["text"],
      );
      questions.add(q);
    }
    idAction = jsonDecode(value)["id"];
    linkQ = jsonDecode(value)["urlExam"];
    linkS = jsonDecode(value)["urlSum"];
    isLoading = false;
    update();
  }

  @override
  void onInit() async {
    update();
    super.onInit();
  }

  // ImagePicker videoPicker = ImagePicker();
  // File? videoFile;

  // Future getVideoFromCamera() async {
  //   final source = await videoPicker.pickVideo(source: ImageSource.gallery);
  //   videoFile = File(source!.path);
  // }
}


// import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences preferences = await SharedPreferences.getInstance();
// preferences.setString('user', json.encode(value.toJson()));
// preferences.setString('userToken', value.token);

// SharedPreferences preferences = await SharedPreferences.getInstance();
// var user = preferences.getString('user');

// home:(userss.id==null)||(userss.id.isEmpty) ?WelcomePage():PageMarket(userss),