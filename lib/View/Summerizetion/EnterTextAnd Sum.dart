import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:learning_throught_multimedia_project/Controller/SummerizationController.dart';
import 'package:readmore/readmore.dart';

import '../../Controller/TypeController.dart';
import '../../common/box_icons_icons.dart';
import '../Exam/category_page.dart';
import '../FileTest/FileTest.dart';

class EnterTextAndSum extends StatefulWidget {
  const EnterTextAndSum({super.key});

  @override
  State<EnterTextAndSum> createState() => _EnterTextAndSumState();
}

class _EnterTextAndSumState extends State<EnterTextAndSum> {
  SumController sumController = Get.put(SumController());
  TypeController typeController = Get.put(TypeController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade900,
                  Color.fromARGB(255, 24, 27, 55),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (result) {
                setState(() {
                  // do something
                  if (true && (result == "3")) {
                    Get.to(CategoryPage(questions: sumController.questions, id: sumController.idAction,));
                  }else if (true && (result == "1")) {
                          downloadFile(sumController.linkS, "sum");
                        }else if (true && (result == "2")) {
                          downloadFile(sumController.linkQ, "exam");
                        }
                });
              },
              color: Color.fromARGB(255, 24, 27, 55),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
               
                const PopupMenuItem<String>(
                  value: '1',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "تحميل التلخيص  ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.file_download,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                
                const PopupMenuItem<String>(
                  value: '2',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "تحميل أسئلة الاختبار ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.file_download,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                if (typeController.type == "1")
                const PopupMenuItem<String>(
                  value: '3',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "اختبر الآن",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.grade,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
          leading: MaterialButton(
            onPressed: () {},
            child: SvgPicture.asset(
              "assets/icons/Figma_file.svg",
              height: 30,
              width: 30,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 24, 27, 55),
        drawerScrimColor: Color.fromARGB(255, 24, 27, 55),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 30, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 25,
                                color: Colors.white70.withOpacity(0.4),
                                offset: Offset(0, 4))
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.39,
                        child: TextFormField(
                          controller: sumController.text,
                          obscureText: false,
                          maxLines: 17,
                          onChanged: (value) async {
                            sumController.updateText(value);
                            await sumController.updateSum();
                          },
                          decoration: InputDecoration(
                            // hintText: "Enter you Text",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colors.white,
                            iconColor: Colors.white,
                            focusColor: Colors.white,
                            hoverColor: Colors.white,
                            prefixIconColor: Colors.white,
                            suffixIconColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 35),
                            label: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(""),
                            ),
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                      GetBuilder<SumController>(
                          init: sumController,
                          builder: (sumController) {
                            return sumController.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.redAccent,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.blue.shade900,
                                      ),
                                      strokeWidth: 7,
                                    ),
                                  )
                                :  ((sumController.content!="")&&(sumController.resultEx!="")&&(sumController.resultAbs!=""))? Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              24, 10, 8, 8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: 4,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            500),
                                                    color: Colors.redAccent),
                                                child: Text(""),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "النص الملخص :",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'Blue Hat Display',
                                                      fontSize: 27),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        (sumController.resultEx != "")
                                            ? Container(
                                                padding: EdgeInsets.all(8),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: Text(
                                                  sumController.resultAbs,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  "...",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Divider(
                                            color: Colors.white,
                                            thickness: 1,
                                          ),
                                        ),
                                        (sumController.resultEx != "")
                                            ? Container(
                                                padding: EdgeInsets.all(8),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: ReadMoreText(
                                                    sumController.resultEx,
                                                    trimLines: 3,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    trimMode: TrimMode.Line,
                                                    trimCollapsedText:
                                                        "Show More",
                                                    trimExpandedText:
                                                        "Show Less",
                                                    lessStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red[900],
                                                    ),
                                                    moreStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red[900],
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        height: 2,
                                                        color: Colors.white)),
                                              )
                                            : Center(
                                                child: Text(
                                                  "...",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ):Container();
                          })
                    ],
                  )),
                ],
              )),
            ), // color:Colors.white,
          ],
        ),
      ),
    );
  }
}
