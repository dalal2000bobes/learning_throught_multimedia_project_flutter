import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'urlRepo.dart';
import 'package:http/http.dart' as http;

Future<String> getSum(String text) async {
  DateTime dateTime = DateTime.now();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var user = preferences.getString('user');
  var myUrl = Uri.parse("$path/summary/");
  final response = await http.post(myUrl,
      headers: {
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "text": text,
        "id": jsonDecode(user.toString())["_id"],
        "type": "3",
        "date": dateTime.toString()
      }));
  return response.body;
}
