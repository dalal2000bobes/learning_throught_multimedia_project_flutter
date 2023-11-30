import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Repository/StudyRepository.dart' as repo;
import '../Model/question.dart';

class StudyController extends GetxController {
  String id = "";
  int rate = 0;
  bool isLoading = false;
  int rate1 = 0;
  int rate2 = 0;
  int rate3 = 0;
  @override
  void onInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user = preferences.getString('user');
    id = jsonDecode(user.toString())["_id"];
    await updateRate();
    update();
    super.onInit();
  }

  Future<void> updateRate() async {
    isLoading = true;
    update();
    var data = await repo.updateStudy(id);
    var d = jsonDecode(data);
    rate = d["allRate"];
    rate1 = d["rate1"];
    rate2 = d["rate2"];
    rate3 = d["rate3"];
    update();
    isLoading = false;
    update();
  }
}
