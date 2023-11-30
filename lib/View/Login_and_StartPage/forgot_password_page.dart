import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/UserController.dart';
import '../../common/theme_helper.dart';

import 'forgot_password_verification_page.dart';
import 'login_page.dart';
import 'widgets/header_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;
    double padd = MediaQuery.of(context).size.width - 650;
    bool isPadd = MediaQuery.of(context).size.width > 650;
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
                  child:
                      HeaderWidget(_headerHeight, true, Icons.password_rounded),
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
                                'نسيت كلمة المرور ؟',
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
                                'أدخل البريد الإلكتروني المرتبط بالحساب مع كلمة المرور الجديدة',
                                style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                // textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'سوف نرسل كود تحقق إلى بريدك الإلكتروني قبل تغيير كلمة المرور',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
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
                              Container(
                                child: TextFormField(
                                  controller: userController.inputTextEmail,
                                  onChanged: (value) {
                                    userController.UserEmail = value;
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      "البريد الإلكتروني",
                                      "أدخل البريد الإلكتروني الخاص بك"),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "الرجاء إدخال البريد الإلكتروني الخاص بك";
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                      return "البريد الإلكتروني المدخل غير معرف";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  obscureText: true,
                                  controller:
                                      userController.inputTextNewPassword,
                                  onChanged: (value) {
                                    userController.UserNewPassword = value;
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      "كلمة المرور", "أدخل كلمة المرور"),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "الرجاء إدخال كلمة المرور";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 40.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "إرسال".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      userController.state = 3;
                                      await userController.sendCode();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordVerificationPage()),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "تذكرت كلمة المرور ؟\t",
                                        style: TextStyle(color: Colors.white)),
                                    TextSpan(
                                      text: 'تسجيل الدخول',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                          );
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                  ],
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
