import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VideoController extends GetxController {
  @override
  void onInit() async {
    update();
    super.onInit();
  }

  ImagePicker videoPicker = ImagePicker();
  File? videoFile;
  PlatformFile? file;
  bool notUpload = true;

  Future<void> getVideo() async {
    FilePickerResult? resultF = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );
    if (resultF != null) {
      file = resultF.files.first;
      videoFile = File(resultF.files.single.path.toString());
      notUpload = false;
      // update();
      // await getTextFromPdf();
      update();
    } else {
      // User canceled the picker
    }
    update();
  }
}


// import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences preferences = await SharedPreferences.getInstance();
// preferences.setString('user', json.encode(value.toJson()));
// preferences.setString('userToken', value.token);

// SharedPreferences preferences = await SharedPreferences.getInstance();
// var user = preferences.getString('user');

// home:(userss.id==null)||(userss.id.isEmpty) ?WelcomePage():PageMarket(userss),