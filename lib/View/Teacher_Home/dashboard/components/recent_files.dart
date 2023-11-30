import 'package:get/get.dart';

import '../../../../Controller/oldActionController.dart';
import '../../../../Model/RecentFile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Common/constants.dart';
import '../../../Student_Home/dashboard/components/RecentActionInfo.dart';

class RecentFiles extends StatelessWidget {
  RecentFiles({
    Key? key,
  }) : super(key: key);
  OldActionController oldActionController = Get.put(OldActionController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: GetBuilder<OldActionController>(
          init: oldActionController,
          builder: (oldActionController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("الأنشطة السابقة",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: double.infinity,
                  child: oldActionController.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.redAccent,
                            valueColor: AlwaysStoppedAnimation(
                              Colors.blue.shade900,
                            ),
                            strokeWidth: 7,
                          ),
                        )
                      : DataTable(
                          columnSpacing: defaultPadding,
                          // minWidth: 600,
                          columns: [
                            DataColumn(
                              label: Text(
                                "نوع الملف",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "التاريخ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(
                            oldActionController.allQuestions.length,
                            (index) => recentFileDataRow(RecentFile(
                                oldActionController.allId[index],
                                oldActionController.allQuestions[index],
                                oldActionController.allGrade[index],
                                oldActionController.allEx[index],
                                oldActionController.allAbs[index],
                                oldActionController.allUrlS[index],
                                oldActionController.allUrlQ[index],
                                oldActionController.allType[index],
                                oldActionController.date[index])),
                          ),
                        ),
                ),
              ],
            );
          }),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  String icon = (fileInfo.type == "1")
      ? "assets/icons/pdf_file.svg"
      : ((fileInfo.type == "2")
          ? "assets/icons/media_file.svg"
          : "assets/icons/Figma_file.svg");
  String title = (fileInfo.type == "1")
      ? "ملف Pdf"
      : ((fileInfo.type == "2") ? "صورة" : "نص");
  return DataRow(
    cells: [
      DataCell(
        onTap: () {
          Get.to(RecentActioInfo(
            fileInfo: fileInfo,
          ));
        },
        Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 23,
              width: 23,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(
        fileInfo.date!,
        style: TextStyle(color: Colors.white, fontSize: 10),
      )),
    ],
  );
}
