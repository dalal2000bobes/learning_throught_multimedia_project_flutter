import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/option.dart';
import '../Model/question.dart';
import '../Repository/ImageRepository.dart' as repo;

class ImageController extends GetxController {
  TextEditingController text = new TextEditingController();
  String idAction = "";
  ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;
  File? imageFile;
  String linkQ = "";
  String linkS = "";
  PlatformFile? file;
  bool notUpload = true;
  String content = "";
  String resultEx = "";
  String resultAbs = "";
  List<Question> questions = [];

  Future getImageFromCamera() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'gif'],
    );
    if (result != null) {
      notUpload = false;
      file = result.files.first;
      imageFile = File(result.files.single.path.toString());
      isLoading = true;
      update();
      await getTextFromImage();
      // var value = await repo.storeImage(image);
      // imagePath = jsonDecode(value)["link"];
      update();
    } else {
      // User canceled the picker
    }
    update();
  }

  Future getTextFromImage() async {
    print("Hello to convert image to text");
    var value = await repo.getText(file);
    resultAbs = jsonDecode(value)["abs"];
    resultEx = jsonDecode(value)["ex"];
    update();
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
    isLoading = false;
    idAction = jsonDecode(value)["id"];
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