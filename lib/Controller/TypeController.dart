import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeController extends GetxController {
  String type = "";
  @override
  void onInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user = preferences.getString('user');
    type = jsonDecode(user.toString())["type"];
    update();
    super.onInit();
  }
}
