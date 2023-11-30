import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Common/theme_helper.dart';
import '../../Controller/UserController.dart';
import 'login_page.dart';
import 'splash_screen.dart';
import 'widgets/header_widget.dart';
import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  double _headerHeight = 150;
  bool checkboxValue = false;
  UserController userController = Get.put(UserController(), permanent: true);

  @override
  Widget build(BuildContext context) {
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
            child: Stack(
              children: [
                Container(
                  height: 150,
                  child: HeaderWidget(
                    _headerHeight,
                    false,
                    Icons.person_add_alt_1_rounded,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                print("Edit Image ...");
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 5, color: Colors.white),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20,
                                          offset: const Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey.shade300,
                                      size: 80.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.grey,
                                      size: 27.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              userController.inputFirstName.text +
                                  " " +
                                  userController.inputLastName.text,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: TextFormField(
                                controller: userController.inputFirstName,
                                onChanged: (value) {
                                  userController.FirstName = value;
                                },
                                decoration: ThemeHelper()
                                    .textInputDecoration('الاسم', 'أدخل اسمك'),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "الرجاء إدخال اسمك";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: TextFormField(
                                controller: userController.inputLastName,
                                onChanged: (value) {
                                  userController.LastName = value;
                                },
                                decoration: ThemeHelper()
                                    .textInputDecoration('اللقب', 'أدخل لقبك'),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "الرجاء إدخال لقبك";
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
                                controller: userController.inputTextEmail,
                                onChanged: (value) {
                                  userController.UserEmail = value;
                                },
                                decoration: ThemeHelper().textInputDecoration(
                                    "البريد الإلكتروني",
                                    "أدخل بريدك الإلكتروني"),
                                keyboardType: TextInputType.emailAddress,
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
                            SizedBox(height: 20.0),
                            Container(
                              child: TextFormField(
                                controller: userController.inputTextPassword,
                                onChanged: (value) {
                                  userController.UserPassword = value;
                                },
                                obscureText: true,
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
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: DropdownButton<String>(
                                    value: userController.dropdownValue,
                                    dropdownColor:
                                        Color.fromARGB(255, 24, 27, 55),
                                    icon: const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.white,
                                    ),
                                    iconSize: 30,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 21),
                                    onChanged: (newValue) {
                                      setState(() {
                                        userController.dropdownValue =
                                            newValue!;
                                      });
                                    },
                                    items: <String>["1", "2"]
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            (value == "1")
                                                ? "حساب طالب"
                                                : "حساب أستاذ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "حفظ التعديلات".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    userController.state = 4;
                                    await userController.sendCode();
                                    // await userController.goToSignUp();
                                    Get.to(ForgotPasswordVerificationPage());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
