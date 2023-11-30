import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_throught_multimedia_project/Controller/UserController.dart';
import 'forgot_password_verification_page.dart';
import '../../common/theme_helper.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserController userController = Get.put(UserController(), permanent: true);
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double padd = MediaQuery.of(context).size.width - 650;
    bool isPadd = MediaQuery.of(context).size.width > 650;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 27, 55),
        body: Container(
          height: MediaQuery.of(context).size.height,
          // color: Colors.white70,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: _headerHeight,
                  child: HeaderWidget(
                      _headerHeight,
                      true,
                      Icons
                          .login_rounded), //let's create a common header widget
                ),
                SafeArea(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: EdgeInsets.fromLTRB(
                          20, 10, 20, 10), // This will be the login form
                      child: Column(
                        children: [
                          Text(
                            'مرحبا',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'أدخل معلومات حسابك',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [   
                                Container(
                                  child: TextFormField(
                                    controller: userController.inputTextEmail,
                                    onChanged: (text) {
                                      userController.UserEmail = text;
                                    },
                                    decoration: ThemeHelper()
                                        .textInputDecoration(
                                            'البريد الإلكتروني', 'أدخل البريد الإلكتروني الخاص بك'),
                                    validator: (val) {
                                      if ((val!.isEmpty) ||
                                          !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                              .hasMatch(val)) {
                                        return "البريد الإلكتروني المدخل غير معرف";
                                      }
                                      return null;
                                    },
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  child: TextFormField(
                                    obscureText: true,
                                    controller:
                                        userController.inputTextPassword,
                                    onChanged: (text) {
                                      userController.UserPassword = text;
                                    },
                                    decoration: ThemeHelper()
                                        .textInputDecoration('كلمة المرور',
                                            'أدخل كلمة المرور الخاصة بك'),
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
                                SizedBox(height: 15.0),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordPage()),
                                      );
                                    },
                                    child: Text(
                                      "نسيت كلمة المرور ؟",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'تسجيل الدخول'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () async {
                                      //After successful login we will redirect to profile page. Let's create profile page now
                                      // await userController.login();
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ProfilePage()));
                                      if (_formKey.currentState!.validate()) {
                                        userController.state = 1;
                                        await userController.sendCode();
                                        Get.to(
                                            ForgotPasswordVerificationPage());
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "لا تملك حساب ؟\t",
                                        style: TextStyle(color: Colors.white)),
                                    TextSpan(
                                      text: 'إنشاء',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationPage()));
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent),
                                    ),
                                  ])),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
