import 'dart:convert';
import 'urlRepo.dart';
import 'package:http/http.dart' as http;

Future<String> updateGrade(int grade, String id) async {
  var myUrl = Uri.parse("$path/action/update");
  final response = await http.post(myUrl,
      headers: {
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({"id": id, "result": grade}));
  return response.body;
}
