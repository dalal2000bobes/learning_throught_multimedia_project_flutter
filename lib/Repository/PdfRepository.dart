import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'urlRepo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<String> pdfToText(PlatformFile file) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  DateTime dateTime = DateTime.now();
  var user = preferences.getString('user');
  var myUrl = Uri.parse("$path/convert/file/pdf/to/text?id=${jsonDecode(user.toString())["_id"]}&type=1&date=${dateTime.toString()}");
  var request = new http.MultipartRequest('POST', myUrl);
  request.files.add(await http.MultipartFile.fromPath(
    'files',
    file.path!,
  ));
  var response = await request.send();
  final res = await http.Response.fromStream(response);
  return res.body;
}
