import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Repository/UserRepository.dart' as repo;

class UserController extends GetxController {
  TextEditingController _inputTextEmail = new TextEditingController();
  TextEditingController get inputTextEmail => _inputTextEmail;

  TextEditingController _inputTextPassword = new TextEditingController();
  TextEditingController get inputTextPassword => _inputTextPassword;

  TextEditingController _inputTextNewPassword = new TextEditingController();
  TextEditingController get inputTextNewPassword => _inputTextNewPassword;

  TextEditingController _inputFirstName = new TextEditingController();
  TextEditingController get inputFirstName => _inputFirstName;

  TextEditingController _inputLastName = new TextEditingController();
  TextEditingController get inputLastName => _inputLastName;

  String UserEmail = "";
  String UserPassword = "";
  String UserNewPassword = "";
  String FirstName = "";
  String LastName = "";
  String messageError = "";
  String userID = "";
  String codeInput = "";
  String dropdownValue = '1';

  int state = 0;

  @override
  void onInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user = preferences.getString('user');
    if ((user != "") && (user != null)) {
      inputTextEmail.text = jsonDecode(user.toString())["email"];
      inputTextPassword.text = jsonDecode(user.toString())["password"];
      inputFirstName.text = jsonDecode(user.toString())["firstName"];
      inputLastName.text = jsonDecode(user.toString())["lastName"];
      dropdownValue = jsonDecode(user.toString())["type"];
    }
    update();
    super.onInit();
  }

  Future sendCode() async {
    await repo.sendCode(UserEmail);
  }

  Future<bool> validCode(String code) async {
    var value = await repo.validCode(UserEmail, code);
    return jsonDecode(value)["result"];
  }

  Future login() async {
    var value = await repo.getLogin(UserEmail, UserPassword);
    if (jsonDecode(value)["message"] == "Done") {
      messageError = "Done";
      userID = jsonDecode(value)["result"];
      var r = await repo.getUserInfo(userID);
      var x = jsonDecode(r);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user', json.encode(x));
    } else if (jsonDecode(value)["message"] == "False") {
      messageError = "فشل تسجيل الدخول الرجاء المحاولة مرة أخرى";
    }
    userID = jsonDecode(value)["result"];

    print("User id is : " + userID + "\nmessage is : " + messageError);

    UserEmail = "";
    UserPassword = "";
    messageError = "";
    update();
  }

  Future updateUser() async {
    var user = {
      "firstName": FirstName,
      "lastName": LastName,
      "email": UserEmail,
      "password": UserPassword,
      "latePosition": "1.5",
      "longPosition": "1.5",
      "token": "no token",
      "image": "no image",
      "type": dropdownValue
    };
    await repo.update(user);
  }

  Future goToSignUp() async {
    var user = {
      "firstName": FirstName,
      "lastName": LastName,
      "email": UserEmail,
      "password": UserPassword,
      "latePosition": "1.5",
      "longPosition": "1.5",
      "token": "no token",
      "image": "no image",
      "type": dropdownValue
    };
    var value = await repo.signup(user);
    if (jsonDecode(value)["message"] == "Done") {
      messageError = "Done";
      userID = jsonDecode(value)["result"];
      var r = await repo.getUserInfo(userID);
      var x = jsonDecode(r);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user', json.encode(x));
    } else if (jsonDecode(value)["message"] == "The email is already in use") {
      messageError =
          "البريد الالكتروني موجود بالفعل الرجاء المحاولة باستخدجام بريد الكتروني جديد او قم بتسجيل الدخول بدلا من ذلك";
    } else if (jsonDecode(value)["message"] ==
        "The account has not been created") {
      messageError = "فشل انشاء الحساب الرجاء المحاولة مرة أخرى";
    }
    userID = jsonDecode(value)["result"];

    print("User id is : " + userID + "\nmessage is : " + messageError);

    UserEmail = "";
    UserPassword = "";
    FirstName = "";
    LastName = "";
    messageError = "";
    update();
  }

  Future goToForgetPassword() async {
    var editPass = {
      "email": UserEmail,
      "password": UserNewPassword,
    };
    var value = await repo.editPassword(editPass);
    if (jsonDecode(value)["result"] == "Done") {
      messageError = "Done";
    } else if (jsonDecode(value)["result"] == "False") {
      messageError = "False";
    }

    print("Message is : " + messageError);

    UserEmail = "";
    UserNewPassword = "";
    messageError = "";
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