import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/constants.dart';
import '../../../../Controller/StudyController.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  StorageDetails({
    Key? key,
  }) : super(key: key);

  StudyController studyController = Get.put(StudyController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
      ),
      child: GetBuilder<StudyController>(
          init: studyController,
          builder: (studyController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "مستويات التعلم",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: defaultPadding),
                studyController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.redAccent,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.blue.shade900,
                          ),
                          strokeWidth: 7,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chart(
                            rate: studyController.rate.toString(),
                            rate1: studyController.rate1.toString(),
                            rate2: studyController.rate2.toString(),
                            rate3: studyController.rate3.toString(),
                          ),
                          StorageInfoCard(
                            svgSrc: "assets/icons/pdf_file.svg",
                            title: "ملف Pdf",
                            amountOfFiles:
                                studyController.rate1.toString() + "%",
                          ),
                          StorageInfoCard(
                            svgSrc: "assets/icons/media_file.svg",
                            title: "ًصورة",
                            amountOfFiles:
                                studyController.rate2.toString() + "%",
                          ),
                          StorageInfoCard(
                            svgSrc: "assets/icons/Figma_file.svg",
                            title: "نص",
                            amountOfFiles:
                                studyController.rate3.toString() + "%",
                          ),
                        ],
                      ),
              ],
            );
          }),
    );
  }
}
