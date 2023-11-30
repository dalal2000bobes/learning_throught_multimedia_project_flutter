import 'dart:convert';
import 'urlRepo.dart';
import 'package:http/http.dart' as http;

Future<String> getAllAct(String id) async {
  var myUrl = Uri.parse("$path/action/get?id=$id");
  final response = await http.get(
    myUrl,
    headers: {
      'Accept': 'application/json',
      'Charset': 'utf-8',
    },
  );
  // print(response.body);
  return response.body;
}
