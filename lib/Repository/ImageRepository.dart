import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'urlRepo.dart';

Future<String> getText(PlatformFile? imageFile) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var user = preferences.getString('user');
  DateTime dateTime = DateTime.now();
  var myUrl = Uri.parse(
      "$path/convert/file/image/to/text?id=${jsonDecode(user.toString())["_id"]}&type=2&date=${dateTime.toString()}");
  var request = new http.MultipartRequest('POST', myUrl);
  request.files.add(await http.MultipartFile.fromPath(
    'images',
    imageFile!.path!,
  ));
  var response = await request.send();
  final res = await http.Response.fromStream(response);

  return res.body;
}
