import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_throught_multimedia_project/Controller/UserController.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/theme_helper.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../Student_Home/main/main_screen.dart';
import '../Teacher_Home/main/main_screen.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'widgets/header_widget.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    double padd = MediaQuery.of(context).size.width - 650;
    bool isPadd = MediaQuery.of(context).size.width > 650;
    UserController userController = Get.find();
    // UserController userController = Get.put(UserController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 27, 55),
        body: Container(
          // color: Colors.white70,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: _headerHeight,
                  child: HeaderWidget(
                      _headerHeight, true, Icons.privacy_tip_outlined),
                ),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'التحقق',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                // textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'أدخل كود التحقق الذي أرسلناه للتو إلى بريدك الإلكتروني',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                // textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: OTPTextField(
                                  keyboardType: TextInputType.text,
                                  length: 10,
                                  width: MediaQuery.of(context).size.width,
                                  fieldWidth: 30,
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white70,
                                  ),
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldStyle: FieldStyle.box,
                                  otpFieldStyle: OtpFieldStyle(
                                    borderColor: Colors.white70,
                                    errorBorderColor: Colors.white70,
                                    enabledBorderColor: Colors.white70,
                                    disabledBorderColor: Colors.white70,
                                    focusBorderColor: Colors.white70,
                                  ),
                                  onCompleted: (pin) {
                                    setState(() {
                                      _pinSuccess = true;
                                    });
                                    userController.codeInput = pin;
                                  },
                                ),
                              ),
                              SizedBox(height: 50.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "إذا لم تستقبل كود التحقق ؟\t",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'إعادة الإرسال',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          // await userController.sendCode();
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ThemeHelper().alartDialog(
                                                  "تم بنجاح",
                                                  "تم إعادة إرسال كود التحقق بنجاح",
                                                  context);
                                            },
                                          );
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40.0),
                              Container(
                                decoration: _pinSuccess
                                    ? ThemeHelper().buttonBoxDecoration(context)
                                    : ThemeHelper().buttonBoxDecoration(
                                        context, "#AAAAAA", "#757575"),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "تحقق".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: _pinSuccess
                                      ? () async {
                                          bool done =
                                              await userController.validCode(
                                                      userController.codeInput)
                                                  as bool;
                                          print(done);
                                          if ((userController.state == 1) &&
                                              (done)) {
                                            await userController.login();
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            var user =
                                                preferences.getString('user');
                                            String type = jsonDecode(
                                                user.toString())["type"];
                                            Get.off((type == "1")
                                                ? Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: MainScreen(),
                                                  )
                                                : Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: TeacherHomeScreen(),
                                                  ));

                                            if ((userController.messageError !=
                                                    "Done") &&
                                                (userController.messageError !=
                                                    ""))
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return ThemeHelper()
                                                      .alartDialog(
                                                          "للأسف فشلت العملية",
                                                          userController
                                                              .messageError,
                                                          context);
                                                },
                                              );
                                          } else if ((userController.state ==
                                                  2) &&
                                              (done)) {
                                            await userController.goToSignUp();
                                            Get.off(Get.off((userController
                                                        .dropdownValue ==
                                                    "1")
                                                ? Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: MainScreen(),
                                                  )
                                                : Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: TeacherHomeScreen(),
                                                  )));
                                            if ((userController.messageError !=
                                                    "Done") &&
                                                (userController.messageError !=
                                                    ""))
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return ThemeHelper()
                                                      .alartDialog(
                                                          "للأسف فشلت العملية",
                                                          userController
                                                              .messageError,
                                                          context);
                                                },
                                              );
                                          } else if ((userController.state ==
                                                  3) &&
                                              (done)) {
                                            await userController
                                                .goToForgetPassword();
                                            Get.off(LoginPage());
                                          } else if ((userController.state ==
                                                  4) &&
                                              (done)) {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            var user =
                                                preferences.getString('user');
                                            String type = jsonDecode(
                                                user.toString())["type"];
                                            await userController.updateUser();
                                            Get.off(Get.off((type == "1")
                                                ? Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: MainScreen(),
                                                  )
                                                : Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: TeacherHomeScreen(),
                                                  )));
                                          }
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
