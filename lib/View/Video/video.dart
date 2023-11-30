// import 'package:elearning/theme/box_icons_icons.dart';
// import 'package:elearning/theme/config.dart';
// import 'package:elearning/ui/widgets/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_throught_multimedia_project/Controller/VideoController.dart';
import 'package:learning_throught_multimedia_project/View/Video/VideoViewPage.dart';

import '../../common/box_icons_icons.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoController videoController = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
        init: videoController,
        builder: (videoController) {
          return Scaffold(
            body: videoController.notUpload
                ? Center(
                    child: MaterialButton(
                      onPressed: () async {
                        await videoController.getVideo();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("تحميل فيديو"),
                          Icon(Icons.upload_file_rounded),
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
                                child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: VideoViewPage(file: videoController.videoFile),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  color: Color(0xFF343434)),
                                              child: Text(""),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Revision - Vedio",
                                                style: TextStyle(
                                                    color: Color(0xFF01579B),
                                                    fontFamily:
                                                        'Blue Hat Display',
                                                    fontSize: 24),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(8),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ut odio id urna ornare rhoncus. Fusce egestas tellus vitae elit pellentesque, sit amet gravida metus consectetur. Sed in hendrerit elit. Phasellus ullamcorper vulputate ex quis consequat. Aenean fringilla vulputate egestas. Aenean nec mattis turpis. Aenean a faucibus purus, in pulvinar velit. Nulla efficitur erat commodo.",
                                            style: TextStyle(
                                                color: Color(0xFF343434),
                                                fontFamily: 'Red Hat Display',
                                                fontSize: 16),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            Positioned(
                                right: 30,
                                top: MediaQuery.of(context).size.height * 0.465,
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFABDCFF),
                                          Color(0xFF0396FF),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 25,
                                            color: Color(0xFF03A9F4)
                                                .withOpacity(0.4),
                                            offset: Offset(0, 4))
                                      ],
                                      borderRadius: BorderRadius.circular(500)),
                                  child: FloatingActionButton(
                                      // heroTag: "video",
                                      elevation: 0,
                                      highlightElevation: 0,
                                      // backgroundColor: Colors.orangeAccent,
                                      child: Icon(BoxIcons.bx_book_open, size: 40),
                                      onPressed: () {}),
                                )),
                          ],
                        )),
                      ), // color:Colors.white,
                    ],
                  ),
          );
        });
  }
}
