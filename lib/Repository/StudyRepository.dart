import 'dart:convert';
import 'urlRepo.dart';
import 'package:http/http.dart' as http;

Future<String> updateStudy(String id) async {
  var myUrl = Uri.parse("$path/action/rate?id=$id");
  final response = await http.get(myUrl,
      headers: {
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Content-Type': 'application/json'
      },);
  return response.body;
}
