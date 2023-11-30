import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<String?> getFolderPath() async {
  String? path = await FilePicker.platform.getDirectoryPath();
  return path;
}

Future<void> openDocument(String urlWord) async {
  final Uri url = Uri.parse(urlWord);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

Future downloadFile(String url,String name) async {
  await Permission.storage.request();
  DateTime dateTime = DateTime.now();
  Dio dio = Dio();
  Directory? directory = await Directory('/storage/emulated/0/Download');
  Directory? downloadsDirectory = Directory('${directory!.path}');
  String path =
      '${await downloadsDirectory!.path}/$name ${dateTime.toString()}.docx';
  print(path);
  var request = await http.get(Uri.parse(url));
  var bytes = request.bodyBytes;
  File file = File(path);
  await file.writeAsBytes(bytes);
  print("Done store");
}

class FileTest extends StatefulWidget {
  const FileTest({super.key});

  @override
  State<FileTest> createState() => _FileTestState();
}

class _FileTestState extends State<FileTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        onPressed: () {
          // downloadFile(
          //     "https://docs.google.com/document/d/14CL53wkRigOTktcaPTd260KFCoe3HbqG/edit?pli=1");
          openDocument(
              "https://docs.google.com/document/d/1_FZAy-V_fPTlc0ILTI82rKI-pzcpGCRp/edit");
        },
        child: Icon(Icons.cloud_download),
      )),
    );
  }
}
