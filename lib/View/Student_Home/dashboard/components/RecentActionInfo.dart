import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:learning_throught_multimedia_project/Model/RecentFile.dart';
import 'package:pdfx/pdfx.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Controller/TypeController.dart';
import '../../../Exam/category_page.dart';
import '../../../FileTest/FileTest.dart';

class RecentActioInfo extends StatefulWidget {
  final RecentFile fileInfo;
  const RecentActioInfo({super.key, required this.fileInfo});

  @override
  State<RecentActioInfo> createState() => _RecentActioInfoState(fileInfo);
}

class _RecentActioInfoState extends State<RecentActioInfo> {
  final RecentFile fileInfo;
  _RecentActioInfoState(this.fileInfo);

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
                if (true && (result == "3")) {
                  print(
                      "sssssssssssssssssssssssssssssssssssssss${fileInfo.id!}");
                  Get.to(CategoryPage(
                    questions: fileInfo.question!,
                    id: fileInfo.id!,
                  ));
                }else if (true && (result == "1")) {
                          downloadFile(fileInfo.urls!, "sum");
                        }else if (true && (result == "2")) {
                          downloadFile(fileInfo.urle!, "exam");
                        }
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
              (fileInfo.type == "1")
                  ? "assets/icons/pdf_file.svg"
                  : ((fileInfo.type == "2")
                      ? "assets/icons/media_file.svg"
                      : "assets/icons/Figma_file.svg"),
              height: 30,
              width: 30,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 24, 27, 55),
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
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(24, 10, 8, 8.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 4,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        color: Colors.redAccent),
                                    child: Text(""),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "النص الملخص :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Blue Hat Display',
                                          fontSize: 24),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                fileInfo.abs!,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * 0.9,
                              // height:
                              //     MediaQuery.of(context).size.height * 0.25,
                              child: ReadMoreText(fileInfo.ex!,
                                  trimLines: 10,
                                  textAlign: TextAlign.justify,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: "Show More",
                                  trimExpandedText: "Show Less",
                                  lessStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900],
                                  ),
                                  moreStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900],
                                  ),
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 2,
                                      color: Colors.white)),
                            )
                          ],
                        ),
                      ),
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
