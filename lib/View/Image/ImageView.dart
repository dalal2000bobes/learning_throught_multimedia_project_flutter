import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:learning_throught_multimedia_project/Controller/ImageController.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';

import '../../Controller/SummerizationController.dart';
import '../../Controller/TypeController.dart';
import '../../common/box_icons_icons.dart';
import '../Exam/category_page.dart';
import '../FileTest/FileTest.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  ImageController imageController = Get.put(ImageController());
  TypeController typeController = Get.put(TypeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(
        init: imageController,
        builder: (imageController) {
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
                        if (true && (result == "3")) {
                          Get.to(CategoryPage(
                            questions: imageController.questions,
                            id: imageController.idAction,
                          ));
                        }else if (true && (result == "1")) {
                          downloadFile(imageController.linkS, "sum");
                        }else if (true && (result == "2")) {
                          downloadFile(imageController.linkQ, "exam");
                        }
                      });
                    },
                    color: Color.fromARGB(255, 24, 27, 55),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                     
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
                    "assets/icons/media_file.svg",
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 24, 27, 55),
              body: imageController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent,
                        valueColor: AlwaysStoppedAnimation(
                          Colors.blue.shade900,
                        ),
                        strokeWidth: 7,
                      ),
                    )
                  : Container(
                      child: imageController.notUpload
                          ? Center(
                              child: MaterialButton(
                                onPressed: () async {
                                  await imageController.getImageFromCamera();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "تحميل صورة",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.upload_file_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: SingleChildScrollView(
                                      child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                          color:
                                              Color.fromARGB(255, 24, 27, 55),
                                          child: Column(
                                            children: <Widget>[
                                              GetBuilder<ImageController>(
                                                init: imageController,
                                                builder: (imageController) {
                                                  return Container(
                                                    color: Color.fromARGB(
                                                        255, 24, 27, 55),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.75,
                                                    padding: EdgeInsets.only(
                                                        top: 30,
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                    child: Center(
                                                      child: Container(
                                                          color: Color.fromARGB(
                                                              255, 24, 27, 55),
                                                          child: PhotoView(
                                                            imageProvider: FileImage(
                                                                imageController
                                                                    .imageFile!),
                                                          )),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          24, 10, 8, 8.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            width: 4,
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            500),
                                                                color: Colors
                                                                    .redAccent),
                                                            child: Text(""),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "النص الملخص :",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Blue Hat Display',
                                                                  fontSize: 27),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    GetBuilder<ImageController>(
                                                        init: imageController,
                                                        builder:
                                                            (imageController) {
                                                          return (imageController
                                                                      .resultEx !=
                                                                  "")
                                                              ? Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  child: Text(
                                                                    imageController
                                                                        .resultAbs,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Center(
                                                                  child: Text(
                                                                    "...",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                );
                                                        }),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Divider(
                                                        color: Colors.white,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                    GetBuilder<ImageController>(
                                                        init: imageController,
                                                        builder:
                                                            (imageController) {
                                                          return (imageController
                                                                      .resultAbs !=
                                                                  "")
                                                              ? Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.9,
                                                                  child: ReadMoreText(
                                                                      imageController
                                                                          .resultEx,
                                                                      trimLines:
                                                                          3,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                      trimMode:
                                                                          TrimMode
                                                                              .Line,
                                                                      trimCollapsedText:
                                                                          "Show More",
                                                                      trimExpandedText:
                                                                          "Show Less",
                                                                      lessStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .red[900],
                                                                      ),
                                                                      moreStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .red[900],
                                                                      ),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        height:
                                                                            2,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                )
                                                              : Center(
                                                                  child: Text(
                                                                    "...",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                );
                                                        }),
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
            ),
          );
        });
  }
}
