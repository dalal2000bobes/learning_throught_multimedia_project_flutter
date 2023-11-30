import '../Common/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final Color? color;
  final int? id;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.color,
    this.id,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "تحميل ملف Pdf",
    id: 1,
    svgSrc: "assets/icons/pdf_file.svg",
    color: Color.fromARGB(255, 19, 255, 188),
  ),
  CloudStorageInfo(
    title: "تحميل صورة",
    // numOfFiles: 1328,
    svgSrc: "assets/icons/media_file.svg",
    id:2,
    color: Color(0xFFFFA113),
  ),
  // CloudStorageInfo(
  //   title: "Video File",
  //   //numOfFiles: 1328,
  //   svgSrc: "assets/icons/media.svg",
  //   totalStorage: "1GB",
  //   color: Color(0xFFA4CDFF),
  //   percentage: 10,
  // ),
  // CloudStorageInfo(
  //   title: "Voice File",
  //  // numOfFiles: 5328,
  //   svgSrc: "assets/icons/sound_file.svg",
  //   totalStorage: "1GB",
  //   color: Color(0xFF007EE5),
  //   percentage: 78,
  // ),
];
