import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Animations/FadeAnimation.dart';
import 'splash_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Get.to(SplashScreen(title: ''));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 27, 55),
        body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Color.fromARGB(255, 24, 27, 55),
                  Color.fromARGB(255, 24, 27, 55),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          // width: double.infinity,
          width: width,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -50,
                left: 0,
                child: FadeAnimation(
                    1,
                    Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/one.png'),
                              fit: BoxFit.cover)),
                    )),
              ),
              Positioned(
                top: -100,
                left: 0,
                child: FadeAnimation(
                    1.3,
                    Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/one.png'),
                              fit: BoxFit.cover)),
                    )),
              ),
              Positioned(
                top: -150,
                left: 0,
                child: FadeAnimation(
                    1.6,
                    Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/one.png'),
                              fit: BoxFit.cover)),
                    )),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.035,
                right: MediaQuery.of(context).size.width * 0.05,
                child: FadeAnimation(
                    1.6,
                    AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Center(
                            child: AnimatedBuilder(
                              animation: _widthController,
                              builder: (context, child) => Container(
                                width: _widthAnimation.value + 25,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // color: Colors.blue.withOpacity(.4)
                                  gradient: new LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 25, 28, 56),
                                        Color.fromARGB(255, 25, 28, 56),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _scaleController.forward();
                                  },
                                  child: Stack(children: <Widget>[
                                    AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                        left: _positionAnimation.value,
                                        child: AnimatedBuilder(
                                          animation: _scale2Controller,
                                          builder: (context, child) =>
                                              Transform.scale(
                                                  scale: _scale2Animation.value,
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // color: Colors.blue,
                                                      gradient:
                                                          new LinearGradient(
                                                              colors: [
                                                                Color.fromARGB(
                                                                    255,
                                                                    25,
                                                                    28,
                                                                    56),
                                                                Color.fromARGB(
                                                                    255,
                                                                    25,
                                                                    28,
                                                                    56),
                                                              ],
                                                              begin:
                                                                  const FractionalOffset(
                                                                      1.0, 0.0),
                                                              end:
                                                                  const FractionalOffset(
                                                                      0.0, 0.0),
                                                              stops: [0.0, 1.0],
                                                              tileMode: TileMode
                                                                  .clamp),
                                                    ),
                                                    child: hideIcon == false
                                                        ? Text(
                                                            "Lets Go ⭐️",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .white70,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Container(),
                                                  )),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          )),
                    )),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.17,
                left: MediaQuery.of(context).size.width * 0.01,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          // SizedBox(
                          //   height: 50,
                          // ),
                          FadeAnimation(
                              1,
                              Text(
                                "ESQ",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 110,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          FadeAnimation(
                              1.3,
                              Text(
                                "نعدك بأن يكون لديك أكثر وقت مفيد معنا على الإطلاق",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white.withOpacity(.7),
                                    height: 1.4,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              )),
                          // SizedBox(
                          //   height: 50,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
