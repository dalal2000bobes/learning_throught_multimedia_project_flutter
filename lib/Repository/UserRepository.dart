import 'dart:convert';
import 'urlRepo.dart';
import 'package:http/http.dart' as http;

Future<String> getLogin(String email, String password) async {
  var myUrl = Uri.parse("$path/users/login?email=$email&password=$password");
  final response = await http.get(
    myUrl,
    headers: {
      'Accept': 'application/json',
      'Charset': 'utf-8',
    },
  );
  return response.body;
}

Future<String> signup(var user) async {
  var myUrl = Uri.parse("$path/users/signup");
  final response = await http.post(myUrl,
      headers: {
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user));
  print(response.body);
  return response.body;
}

Future<String> update(var user) async {
  var myUrl = Uri.parse("$path/update/user");
  final response = await http.post(myUrl,
      headers: {
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user));
  print(response.body);
  return response.body;
}

Future<String> editPassword(var newPassword) async {
  var myUrl = Uri.parse("$path/users/reset/password");
  final response = await http.post(myUrl,
      headers: {
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(newPassword));
  print(response.body);
  return response.body;
}

Future sendCode(String email) async {
  var myUrl = Uri.parse("$path/users/verify/email?email=$email");
  await http.get(
    myUrl,
    headers: {
      'Accept': 'application/json',
      'Charset': 'utf-8',
    },
  );
}

Future<String> validCode(String email, String code) async {
  var myUrl = Uri.parse("$path/users/done/verify?email=$email&code=$code");
  final response = await http.get(
    myUrl,
    headers: {
      'Accept': 'application/json',
      'Charset': 'utf-8',
    },
  );
  return response.body;
}

Future<String> getUserInfo(String id) async {
  var myUrl =
      Uri.parse("$path/users/user/get?id=$id");
  final response = await http.get(
    myUrl,
    headers: {
      'Accept': 'application/json',
      'Charset': 'utf-8',
    },
  );
  return response.body;
}