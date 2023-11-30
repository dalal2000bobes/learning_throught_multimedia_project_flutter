import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class ScoreScreen extends StatelessWidget {
  final double result ;
  const ScoreScreen({super.key, required this.result});
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 27, 55),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Spacer(flex: 2),
                Image(
                  image: AssetImage("assets/images/quizResultBadge.png"),
                ),
                Text(
                  (result >= 50)?
                  "مبارك نجحت 🤩🥳":
                  " لا تيأس  😔💔",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                Text(
                  (result >= 50)?
                  "لقد أتممت الاختبار":
                    "حاول مرة اخرى",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25,
                    )),
                Spacer(flex: 3),
                Text("النتيجة",
                    style: TextStyle(color: Colors.white70, fontSize: 21)),
                Spacer(),
                Text(
                  result.toInt().toString()+"%",
                  // "${_qnController.numOfCorrectAns * 10}/${_qnController.questions.length * 10}",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(flex: 3),
              ],
            )
          ],
        ),
      ),
    );
  }
}
