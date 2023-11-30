import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:learning_throught_multimedia_project/View/FileTest/FileTest.dart';
import 'package:learning_throught_multimedia_project/View/Image/ImageView.dart';
import 'package:learning_throught_multimedia_project/View/Login_and_StartPage/registration_page.dart';
import 'package:learning_throught_multimedia_project/View/Pdf/PdfView.dart';
import 'package:learning_throught_multimedia_project/View/Summerizetion/EnterTextAnd%20Sum.dart';
import 'package:learning_throught_multimedia_project/View/Video/VideoViewPage.dart';
import 'package:learning_throught_multimedia_project/View/Video/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/Exam/category_page.dart';
import 'View/Login_and_StartPage/forgot_password_verification_page.dart';
import 'View/Login_and_StartPage/home.dart';
import 'View/Login_and_StartPage/profile_page.dart';
import 'View/Pdf/PdfViewPage.dart';
import 'View/Student_Home/main/main_screen.dart';
import 'View/Teacher_Home/main/main_screen.dart';

bool isLogin = false;
String type = "";
Future<void> open() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var user = preferences.getString('user');
  if ((user != "") && (user != null)) {
    isLogin = true;
    type = jsonDecode(user.toString())["type"];
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await open();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: HexColor('#001E3D'),
        colorScheme: ColorScheme?.fromSwatch().copyWith(
          secondary: HexColor('#3286A2'),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 24, 27, 55),
        // primarySwatch: Colors.grey,
        // primarySwatch: Colors.blue,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        // child: TeacherHomeScreen(),
        // child: MainScreen(),
        child: (!isLogin)
            ? HomePage()
            : (type == "1")
                ? MainScreen()
                : TeacherHomeScreen(),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //  home: LoginPage(),
      // home: HomePage (),
      // home: CategoryPage(),
      // home: MainScreen(),
      // home:TeacherHomeScreen()
      // home: RegistrationPage(),
      // home: Home(),
      // home: VideoPage(),
      // home: HomeView()
      // home: HomeSumerizetion(),
      // home: EnterTextAndSum(),
      // home: ImageView(),
      // home: AudioPage(),
      // home: PdfPage(),
      // home: FileTest(),
      // home: Summerization(),
      // home: VideoViewPage(),
      // home: PdfViewPage(),
      // home: VideoViewPage(),
      // home: TexttoSound(),
      // home: StartPage(),
      // home: SplashScreen(title: 'Flutter Login UI'),
    );
  }
}

class StartAppPage extends StatefulWidget {
  const StartAppPage(String type, {super.key});

  @override
  State<StartAppPage> createState() => _StartAppPageState(type);
}

class _StartAppPageState extends State<StartAppPage> {
  _StartAppPageState(String type);

  @override
  Widget build(BuildContext context) {
    return (type == "1")
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: MainScreen(),
          )
        : Directionality(
            textDirection: TextDirection.rtl,
            child: TeacherHomeScreen(),
          );
  }
}
