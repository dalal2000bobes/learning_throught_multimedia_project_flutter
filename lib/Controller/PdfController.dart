import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/option.dart';
import '../Model/question.dart';
import '../Repository/PdfRepository.dart' as repo;

class FilePdfController extends GetxController {
  String idAction = "";
  String linkQ = "";
  String linkS = "";
  String content = "";
  String resultEx = "";
  String resultAbs = "";
  List<Question> questions = [];
  TextEditingController text = new TextEditingController();
  bool isLoading = false;
  ImagePicker imagePicker = ImagePicker();
  File? pdfFile;
  PlatformFile? file;
  bool notUpload = true;

  Future<void> getFilePdf() async {
    FilePickerResult? resultF = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (resultF != null) {
      file = resultF.files.first;
      pdfFile = File(resultF.files.single.path.toString());
      notUpload = false;
      isLoading = true;
      update();
      await getTextFromPdf();
      update();
    } else {
      // User canceled the picker
    }
    update();
  }

  Future getTextFromPdf() async {
    print("Hello to convert image to text");
    var value = await repo.pdfToText(file!);
    resultAbs = jsonDecode(value)["abs"];
    resultEx = jsonDecode(value)["ex"];
    for (var element in jsonDecode(value)["q"]) {
      List<Option> p = [];
      for (var e in element["option"]) {
        Option o = new Option(
            text: e["text"], code: e["code"], isCorrect: e["isCorrect"]);
        p.add(o);
      }
      Question q = Question(
        options: p,
        text: element["text"],
      );
      questions.add(q);
    }
    linkQ = jsonDecode(value)["urlExam"];
    linkS = jsonDecode(value)["urlSum"];
    idAction = jsonDecode(value)["id"];
    isLoading = false;
    update();
  }

  @override
  void onInit() async {
    update();
    super.onInit();
  }

  // ImagePicker videoPicker = ImagePicker();
  // File? videoFile;

  // Future getVideoFromCamera() async {
  //   final source = await videoPicker.pickVideo(source: ImageSource.gallery);
  //   videoFile = File(source!.path);
  // }
}


// import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences preferences = await SharedPreferences.getInstance();
// preferences.setString('user', json.encode(value.toJson()));
// preferences.setString('userToken', value.token);

// SharedPreferences preferences = await SharedPreferences.getInstance();
// var user = preferences.getString('user');

// home:(userss.id==null)||(userss.id.isEmpty) ?WelcomePage():PageMarket(userss),