import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Common/constants.dart';
import '../../../../Controller/StudyController.dart';

class Chart extends StatelessWidget {
  final String rate, rate1, rate2, rate3;
  const Chart({
    Key? key,
    required this.rate,
    required this.rate1,
    required this.rate2,
    required this.rate3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: Color.fromARGB(255, 19, 255, 188),
                  value: int.parse(rate1)/3,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Color(0xFFFFCF26),
                  value: int.parse(rate2)/3,
                  showTitle: false,
                  radius: 19,
                ),
                PieChartSectionData(
                  color: Color(0xFFEE2727),
                  value: int.parse(rate3)/3,
                  showTitle: false,
                  radius: 16,
                ),
                PieChartSectionData(
                  color: primaryColor.withOpacity(0.1),
                  value: 100-(int.parse(rate1)/3+int.parse(rate1)/3+int.parse(rate1)/3),
                  showTitle: false,
                  radius: 13,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  rate + "%",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text(
                  "100%",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// List<PieChartSectionData> paiChartSelectionData = ;
